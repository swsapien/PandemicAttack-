import 'package:flutter/material.dart';
import 'package:virusapp/Users/ui/add_score.dart';
import 'package:virusapp/Users/ui/best_scores..dart';
import 'package:virusapp/Users/ui/view_scores.dart';
import 'package:virusapp/views/views.dart';
import 'package:virusapp/widgets/button_personal.dart';


class VirusGameUI extends StatefulWidget{
  final VirusGameUIState state = VirusGameUIState();

  State<StatefulWidget> createState() => state;
}

class VirusGameUIState extends State<VirusGameUI> with WidgetsBindingObserver {
  Views activeView = Views.home;
  int score;
  String timeScore;
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    
    final saveScore = Container(
          height: 350,
          child: Container(
          child: Padding(
            padding: EdgeInsets.only(
              top:100,
              left: 10,
              right: 10
            ),
            child: Card(
              color: Colors.white,
              elevation: 1,
              child: AddScore(score, timeScore, this)
              )
            ),
          )
        );
    final viewScores = Container(
            height: 610,
            child: Padding(
              padding: EdgeInsets.only(
                top:100,
                left: 10,
                right: 10
              ),
              child: Opacity(
                opacity: 0.99,
                child: Card(
                  color: Colors.white,
                  elevation: 1,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Center(
                          child: Text(
                            "Best Scores",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "8bitpusab",
                              fontSize: 25,
                              color: Colors.green[900]
                            ),
                          ),
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 5,
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
                                  "NickName",
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
                                  "Time",
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
                                  "Score",
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
                      ),
                      BestScores(this),
                      Container(
                        margin: EdgeInsets.only(top:10),
                        child: ButtonPersonal(
                          titleText: "Close", 
                          height: 40, 
                          width: 100, 
                          onPressed: () {
                            activeView = Views.lost;
                            update();
                          }
                        )
                      )
                    ],
                  )
                ),
              )
            ),
          );

    switch(activeView){
      case Views.saveScore:
        return saveScore;
      case Views.viewScores:
        return viewScores;
      case Views.lost:
        return BestScores(this);
      default:
        return Container();
    }
  }
}