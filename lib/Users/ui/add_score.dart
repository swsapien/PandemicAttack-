import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:virusapp/Users/bloc/bloc_user.dart';
import 'package:virusapp/Users/model/score.dart';
import 'package:virusapp/views/views.dart';
import 'package:virusapp/virus_game_ui.dart';
import 'package:virusapp/widgets/button_personal.dart';
import 'package:virusapp/widgets/form_generic.dart';

class AddScore extends StatefulWidget{
  int userScore;
  String timeScore;
  final VirusGameUIState game;
  AddScore(this.userScore, this.timeScore, this.game);
  @override
  State<StatefulWidget> createState(){
    return _AddScore();
  }
}

class _AddScore extends State<AddScore>{

  @override
  Widget build(BuildContext context) {
    double _marginSizes = 20;
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final _controllerNicknameBox = TextEditingController();
    
    return ListView(
      children: <Widget>[
        FormGeneric(
          hintTextPrimary: "ADD YOU NICKNAME",
          controllerTitleBook: _controllerNicknameBox
        ),
        Container(
          padding: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: _marginSizes,
            right: _marginSizes
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 5),
                child:  InkWell(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: "8bitpusab",
                      color: Colors.blueGrey
                    ),
                  ),
                  onTap: () {
                    widget.game.activeView = Views.lost;
                    widget.game.update();
                  },
                ),
              ),
               Padding(
                padding: EdgeInsets.only(left: 5),
                child:  ButtonPersonal(
                  titleText: "SAVE",
                  height: 40,
                  width: 120,
                  onPressed: () {
                      if(_controllerNicknameBox.text.length > 3)
                      {
                        Score score = Score(
                          nickname: _controllerNicknameBox.text,
                          userScore: widget.userScore,
                          timeScore: widget.timeScore
                        );
                        userBloc.updateScores(score);
                        widget.game.activeView = Views.lost;
                        widget.game.update();
                      }
                  },
                )
              )
            ]
          )
        )
      ]
    );
  }
}