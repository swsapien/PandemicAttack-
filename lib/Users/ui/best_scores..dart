import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:virusapp/Users/bloc/bloc_user.dart';
import 'package:virusapp/Users/model/score.dart';
import 'package:virusapp/views/views.dart';
import 'package:virusapp/virus_game_ui.dart';
import 'package:virusapp/widgets/button_personal.dart';

class BestScores extends StatefulWidget{
  final VirusGameUIState game;
  BestScores(this.game);
  
  @override
  State<StatefulWidget> createState() {
    return _BestScores();
  }
}

class _BestScores extends State<BestScores>{
  double heightModalt = 350;
  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    
    return Container(
      height: heightModalt,
      child: StreamBuilder(
        stream: userBloc.scoresListStream(),
        builder: (context, AsyncSnapshot snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.white, valueColor: new AlwaysStoppedAnimation<Color>(Colors.green[900])));
              break;
            case ConnectionState.done:
              return returnView(userBloc.getScores(snapshot.data.documents));
              break;
            case ConnectionState.active:
              return returnView(userBloc.getScores(snapshot.data.documents));
              break;
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.white, valueColor: new AlwaysStoppedAnimation<Color>(Colors.green[900])));
              break;
            default:
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.white));
          }
        },
      )
    );
  }
  Widget listViewScores(List<Score> listScores){
    return ListView(
      children: listScores.map((score){
        return Container(
          padding: EdgeInsets.only(
            bottom: 5,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black26,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child:  Text(
                    score.nickname,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "8bitpusab",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:  Text(
                    score.timeScore.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "8bitpusab",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[600]
                    ),
                  ),
                ), 
                Expanded(
                  flex: 1,
                  child:  Text(
                    score.userScore.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "8bitpusab",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.greenAccent[700]
                    ),
                  ),
                ),
              ],
            ),
        );
      },
      ).toList()
    );
  }

  Widget returnView(List<Score> listScores) {
    switch(widget.game.activeView){
      case Views.viewScores:
        return listViewScores(listScores);
      case Views.lost:
        if(listScores.first.userScore < widget.game.score){
          heightModalt = 500;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                child: Image(
                  width: 280,
                  height: 280,
                  image: AssetImage("assets/images/bestscore.png")
                )
              )
            ],
          );
        }else{
            heightModalt = 500;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    width: 280,
                    height: 280,
                    image: AssetImage("assets/images/game-over.png")
                  )
                )
              ],
            );
        }
        break;
      default:
        heightModalt = 350;
        return Container();
    }
  }
}