
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virusapp/Users/model/score.dart';
import 'package:virusapp/Users/repository/cloud_firestore_api.dart';

class CloudFirestoreRepository{
  final _cloudFirestoreAPI = CloudFirestoreAPI();
  
  Future<void> updateScores(Score score) => _cloudFirestoreAPI.updateScores(score);
  List<Score> getScores(List<DocumentSnapshot> listScoresSnapshots) => _cloudFirestoreAPI.getScores(listScoresSnapshots);
}