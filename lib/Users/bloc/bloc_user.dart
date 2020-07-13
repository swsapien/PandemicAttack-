import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:virusapp/Users/model/score.dart';
import 'package:virusapp/Users/repository/cloud_firestore_api.dart';
import 'package:virusapp/Users/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc{

  final _cloudFirestoreRepository = CloudFirestoreRepository();
  Future<void> updateScores(Score score) => _cloudFirestoreRepository.updateScores(score);
  List<Score> getScores(List<DocumentSnapshot> listScoresSnapshots) => _cloudFirestoreRepository.getScores(listScoresSnapshots);
  Stream<QuerySnapshot> scoresListStream() => 
    Firestore.instance.collection(CloudFirestoreAPI().SCORES)
    .orderBy('userScore', descending: true)
    .limit(10)
    .snapshots();

  @override
  void dispose() {
  }

}
