import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_roulette/configs/utils/singleton.dart';
import '../models/match_model.dart';

class MatchingService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<MatchModel>> getMatchesStream() {
    final currentUserId = _auth.currentUser!.uid;

    return _firestore.collection('mensa_places')
        .doc(Singleton.selectedMensaId)
        .collection('matches')
        .where('user1', isEqualTo: currentUserId)
        .snapshots()
        .asyncMap((snapshot) async {
      final user1Matches = snapshot.docs
          .map((doc) => MatchModel.fromMap(doc.data(), doc.id))
          .toList();

      final otherMatches = await _firestore.collection('mensa_places')
          .doc(Singleton.selectedMensaId)
          .collection('matches')
          .where('user2', isEqualTo: currentUserId)
          .get();

      final user2Matches = otherMatches.docs
          .map((doc) => MatchModel.fromMap(doc.data(), doc.id))
          .toList();

      final allMatches = [...user1Matches, ...user2Matches];
      allMatches.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return allMatches;
    });
  }

  bool isToday(Timestamp ts) {
    final now = DateTime.now();
    final date = ts.toDate();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
