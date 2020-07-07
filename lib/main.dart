import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virusapp/virus_game.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loadResources();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  VirusGame game = VirusGame();
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
  runApp(game.widget);
}

loadResources(){
  Flame.bgm.initialize();
  Flame.images.loadAll(<String>[
    'bg/background.png',
    'bg/bkg-home.png',
    'Green_Virus_01.png',
    'Green_Virus_02.png',
    'Red_Virus.png',
    'cloud.png',
    'back.png'
  ]);
  Flame.audio.loadAll(<String>[
    'splash.mp3',
    'startGame.mp3',
    'inGame.mp3',
    'lostGame.mp3'
  ]);
}