import 'dart:math';
import 'dart:ui';
import 'package:flame/animation.dart';
import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:virusapp/Users/ui/view_scores.dart';
import 'package:virusapp/components/buttons/restart_button.dart';
import 'package:virusapp/components/buttons/try_again_component.dart';
import 'package:virusapp/components/buttons/best_scores_component.dart';
import 'package:virusapp/views/game_view.dart';
import 'package:virusapp/components/score_component.dart';
import 'package:virusapp/components/buttons/start_button.dart';
import 'package:virusapp/components/virus_component.dart';
import 'package:virusapp/components/time_score_component.dart';
import 'package:virusapp/controller/virus_spawner.dart';
import 'package:virusapp/views/views.dart';
import 'package:virusapp/views/home_view.dart';
import 'package:virusapp/views/lost_view.dart';
import 'package:virusapp/virus_game_ui.dart';
import 'components/buttons/save_score_component.dart';
import 'views/views.dart';


class VirusGame extends BaseGame {
  final VirusGameUIState virusGameUI;
  double componentSize = 60;
  double speed = 30.0;
  double difficulty = 3;
  double lastVirusAdded = 0;
  double creationTimer = 0.0;
  int virusScoreValue = 5;
  int score = 0;
  Size screenSize;
  List<Sprite> virusSprite;
  List<Sprite> deadVirus;
  List<VirusComponent> listVirus = List<VirusComponent>();
  GameView gameView;
  HomeView homeView;
  LostView lostView;
  StartButton startButton;
  VirusSpawner virusSpawner;
  TimeScoreComponent timeScoreComponent;
  ScoreComponent scoreComponent;
  TryAgainComponent tryAgainComponent;
  BestScoresComponent bestScoresComponent;
  SaveScoreComponent saveScoreComponent;

  VirusGame(this.virusGameUI){
    initialize();
  }
  
  initialize() async {
    screenSize = await Flame.util.initialDimensions();
    virusSprite = List<Sprite>(); 
    virusSprite.add(Sprite('Green_Virus_01.png'));
    virusSprite.add(Sprite('Green_Virus_02.png'));
    deadVirus = List<Sprite>();
    deadVirus.add(Sprite('Red_Virus.png'));
    gameView = GameView(this);
    homeView = HomeView(this);
    lostView = LostView(this);
    startButton = StartButton(this);
    virusSpawner = VirusSpawner(this);
    timeScoreComponent =  TimeScoreComponent(this);    
    scoreComponent =  ScoreComponent(this);    
    tryAgainComponent =  TryAgainComponent(this);   
    bestScoresComponent = BestScoresComponent(this);
    saveScoreComponent = SaveScoreComponent(this);
  }
  @override
  void render(Canvas canvas) {
    if(virusGameUI.activeView == Views.home){
      homeView.render(canvas);
      startButton.render(canvas);
      if(!homeView.audioActive)
      {
        homeView.startAudio();
        homeView.audioActive = true;
        gameView.audioActive = false;
        lostView.audioActive = false;
      }
    }


    if (virusGameUI.activeView == Views.lost || virusGameUI.activeView == Views.viewScores || virusGameUI.activeView == Views.saveScore) {
      listVirus.forEach((VirusComponent virus){
        virus.remove = true;
      });
      if(!lostView.audioActive)
      {
        lostView.startAudio();
        homeView.audioActive = false;
        gameView.audioActive = false;
        lostView.audioActive = true;
      }
      lostView.render(canvas);
      scoreComponent.render(canvas);
      tryAgainComponent.render(canvas);
      bestScoresComponent.render(canvas);
      saveScoreComponent.render(canvas);
    }

    if(virusGameUI.activeView == Views.playing){ //InGame
      gameView.render(canvas);
      if(!gameView.audioActive)
      {
        gameView.startAudio();
        homeView.audioActive = false;
        gameView.audioActive = true;
        lostView.audioActive = false;
      }
      timeScoreComponent.render(canvas);
      scoreComponent.render(canvas);
    }
    listVirus.forEach((VirusComponent virus) {
      if(virus.isDead ){
        virus.animation = Animation.spriteList(deadVirus);
        virus.speed += 25;
      }
    });
    super.render(canvas);
  }
  @override
  void update(double time) {
    if (((creationTimer >= difficulty) ||  listVirus.length == 0) && virusGameUI.activeView == Views.playing) {
      creationTimer = 0.0;
      Animation animation = Animation.spriteList(virusSprite, stepTime: 0.2, loop: true);
      VirusComponent virusComponent = VirusComponent(animation, speed, componentSize);
      add(virusComponent);
      listVirus.add(virusComponent);
      virusComponent.update(time);
    }
    int removedVirus = listVirus?.where((VirusComponent virus) => virus.remove)?.length;
    int deadVirus = listVirus?.where((VirusComponent virus) => virus.isDead)?.length;
    if(removedVirus > deadVirus ){
      virusGameUI.activeView = Views.lost;
      virusGameUI.score = score;
      virusGameUI.update();
    }
    listVirus.removeWhere((VirusComponent virus) => virus.remove);
    if(lastVirusAdded >= 1)
    {
      difficulty = difficulty >= 0.7 ? difficulty - 0.1 : 0.7;
      lastVirusAdded = 0;
    }
    creationTimer += time;
    lastVirusAdded += time;
    speed += speed <= 300 ? 0.10 : 0;  
    timeScoreComponent.update(time);
    scoreComponent.update(time);
    homeView.update(time);
    super.update(time);
  }
  void onTapDown(TapDownDetails tap){
    Offset position = tap.localPosition;
    var  touchPositionDx = position.dx;
    var touchPositionDy = position.dy;
    if(listVirus.length == 0){
      if(virusGameUI.activeView != Views.home &&
          (touchPositionDy <=  lostView.bgBackRect.bottom && touchPositionDy >= lostView.bgBackRect.top) &&
          (touchPositionDx <=  lostView.bgBackRect.right && touchPositionDx >= lostView.bgBackRect.left))
      {
        virusGameUI.activeView = Views.home;
         virusGameUI.update();
        resetGame();
      }else if(virusGameUI.activeView == Views.home || virusGameUI.activeView == Views.lost &&
          (touchPositionDy <=  (tryAgainComponent.position.dy + tryAgainComponent.painter.height) && touchPositionDy >= tryAgainComponent.position.dy) &&
          (touchPositionDx <=  (tryAgainComponent.position.dx + tryAgainComponent.painter.width) && touchPositionDx >= tryAgainComponent.position.dx))
      {
        virusGameUI.activeView = Views.playing;
        startButton.onTapDown();
        virusGameUI.update();
        resetGame();
      }else if(virusGameUI.activeView == Views.lost &&
          (touchPositionDy <=  (bestScoresComponent.position.dy + bestScoresComponent.painter.height) && touchPositionDy >= bestScoresComponent.position.dy) &&
          (touchPositionDx <=  (bestScoresComponent.position.dx + bestScoresComponent.painter.width) && touchPositionDx >= bestScoresComponent.position.dx))
      {
        virusGameUI.activeView = Views.viewScores;
        virusGameUI.update();
      }else if(virusGameUI.activeView == Views.lost &&
          (touchPositionDy <=  (saveScoreComponent.position.dy + saveScoreComponent.painter.height) && touchPositionDy >= saveScoreComponent.position.dy) &&
          (touchPositionDx <=  (saveScoreComponent.position.dx + saveScoreComponent.painter.width) && touchPositionDx >= saveScoreComponent.position.dx))
      {
        virusGameUI.activeView = Views.saveScore;
        virusGameUI.score = score;
        virusGameUI.timeScore = timeScoreComponent.elapsed;
        virusGameUI.update();
      }
     
    }else{
      listVirus.forEach((VirusComponent virus){
        if(( touchPositionDy <= (virus.y + componentSize +15) && touchPositionDy  >= virus.y -15) && 
            (touchPositionDx <= (virus.x + componentSize +15) && touchPositionDx >= virus.x -15)){
          score += (virusScoreValue + (speed * 0.1)).round();
          virus.onTapDown();
          return true;
        }
      });
    }
  }
  void resetGame(){
    speed = 30.0;
    difficulty = 3;
    score = 0;
    timeScoreComponent.resetTime();
  }
  double randomPosition(Size size){
    return (Random().nextDouble() * size.width) - componentSize;
  }
}