import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:virusapp/Users/bloc/bloc_user.dart';
import 'package:virusapp/Users/model/score.dart';
import 'package:virusapp/widgets/button_personal.dart';

class ViewScores extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ViewScores();
  }
}

class _ViewScores extends State<ViewScores>{
  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      height: 260,
      child: StreamBuilder(
        stream: userBloc.scoresListStream(),
        builder: (context, AsyncSnapshot snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.white));
              break;
            case ConnectionState.done:
              return listViewScores(userBloc.getScores(snapshot.data.documents));
              break;
            case ConnectionState.active:
              return listViewScores(userBloc.getScores(snapshot.data.documents));
              break;
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.white));
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
          margin: EdgeInsets.only(
            bottom: 10
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
                      fontSize: 16,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.greenAccent[700]
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
                      fontSize: 16,
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
}