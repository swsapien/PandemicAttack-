
import 'package:flutter/material.dart';

class Score{
  String id;
  final String nickname;
  final int userScore;
  final String timeScore;

  Score({
    Key key,
    @required this.id,
    @required this.nickname,
    @required this.userScore,
    @required this.timeScore
  });

}