import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:virusapp/Users/bloc/bloc_user.dart';
import 'package:virusapp/virus_game.dart';
import 'package:virusapp/virus_game_ui.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loadResources();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  VirusGameUI gameUI =  VirusGameUI();
  VirusGame game = VirusGame(gameUI.state);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);

  runApp(
    BlocProvider(
      child: MaterialApp(
        title: 'Pandemic Attack!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Stack(
            //fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: game.onTapDown,
                  child: game.widget,
                ),
              ),
              gameUI
            ],
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
      bloc: UserBloc(),
    )
  );
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