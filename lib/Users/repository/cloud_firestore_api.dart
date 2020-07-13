
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virusapp/Users/model/score.dart';

class CloudFirestoreAPI {
  final String SCORES = "scores";
  final Firestore _db = Firestore.instance;

  Future<void> updateScores(Score score) async{
    DocumentReference ref = _db.collection(SCORES).document(score.id);
    return await ref.setData({
      'id': score.id,
      'nickname': score.nickname,
      'userScore': score.userScore,
      'timeScore': score.timeScore,
      'dateScore': DateTime.now()
    }, merge: true);
  }
  List<Score> getScores(List<DocumentSnapshot> listSnapshots){
    List<Score> listScores = List<Score>();
    listSnapshots.forEach((snapshot){
      Score score = Score(
        id: snapshot.documentID,
        nickname: snapshot.data["nickname"], 
        userScore:  snapshot.data["userScore"],
        timeScore: snapshot.data["timeScore"]
      );
      listScores.add(score);
    });
    return listScores;
  }
}