import 'dart:math';
import 'dart:ui';
import 'package:flame/animation.dart';
import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:virusapp/components/buttons/restart_button.dart';
import 'package:virusapp/components/buttons/try_again_component.dart';
import 'package:virusapp/views/game_view.dart';
import 'package:virusapp/components/score_component.dart';
import 'package:virusapp/components/buttons/start_button.dart';
import 'package:virusapp/components/virus_component.dart';
import 'package:virusapp/components/time_score_component.dart';
import 'package:virusapp/controller/virus_spawner.dart';
import 'package:virusapp/views/views.dart';
import 'package:virusapp/views/home_view.dart';
import 'package:virusapp/views/lost_view.dart';

import 'views/views.dart';


class VirusGame extends BaseGame {
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
  View activeView = View.home;
  GameView gameView;
  HomeView homeView;
  LostView lostView;
  StartButton startButton;
  RestartButton restartButton;
  VirusSpawner virusSpawner;
  TimeScoreComponent timeScoreComponent;
  ScoreComponent scoreComponent;
  TryAgainComponent tryAgainComponent;

  VirusGame(){
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
    restartButton = RestartButton(this);
    virusSpawner = VirusSpawner(this);
    timeScoreComponent =  TimeScoreComponent(this);    
    scoreComponent =  ScoreComponent(this);    
    tryAgainComponent =  TryAgainComponent(this);    
  }
  @override
  void render(Canvas canvas) {
    

    if(activeView == View.home){
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


    if (activeView == View.lost) {
      lostView.render(canvas);
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
      restartButton.render(canvas);
      scoreComponent.position = Offset((screenSize.width/2) -50,  (screenSize.height/1.5) - 50);
      scoreComponent.render(canvas);
      tryAgainComponent.render(canvas);
    }

    if(activeView == View.playing){ //InGame
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
    if (((creationTimer >= difficulty) ||  listVirus.length == 0) && activeView == View.playing) {
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
      activeView = View.lost;
    }
    listVirus.removeWhere((VirusComponent virus) => virus.remove);
    if(lastVirusAdded >= 1)
    {
      difficulty = difficulty >= 0.7 ? difficulty - 0.1 : 0.7;
      lastVirusAdded = 0;
    }
    creationTimer += time;
    lastVirusAdded += time;
    speed += speed <= 250 ? 0.10 : 0;  
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
      if( activeView != View.home &&
          (touchPositionDy <=  lostView.bgBackRect.bottom && touchPositionDy >= lostView.bgBackRect.top) &&
          (touchPositionDx <=  lostView.bgBackRect.right && touchPositionDx >= lostView.bgBackRect.left))
      {
        activeView = View.home;
        resetGame();
      }else if( activeView == View.home ||
          (touchPositionDy <=  (tryAgainComponent.position.dy + tryAgainComponent.painter.height) && touchPositionDy >= tryAgainComponent.position.dy) &&
          (touchPositionDx <=  (tryAgainComponent.position.dx + tryAgainComponent.painter.width) && touchPositionDx >= tryAgainComponent.position.dx))
      {
        activeView = View.playing;
        startButton.onTapDown();
        resetGame();
      }
     
    }else{
      listVirus.forEach((VirusComponent virus){
        if(( touchPositionDy <= (virus.y + componentSize) && touchPositionDy  >= virus.y ) && 
            (touchPositionDx <= (virus.x + componentSize) && touchPositionDx >= virus.x)){
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