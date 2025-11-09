import 'package:cloud_firestore/cloud_firestore.dart';

class MensaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Adds user to queue and pairs them if another user is waiting.
  Future<void> joinMensaQueue(String mensaId, String uid) async {
    final mensaRef = _firestore.collection('mensa_places').doc(mensaId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(mensaRef);

      List<dynamic> pool = snapshot.data()?['pool']?.cast<String>() ?? [];

      // If no one waiting, just add the current user
      if (pool.isEmpty || pool.first == "" || pool == [] || pool == [""]) {
        transaction.update(mensaRef, {
          'pool': FieldValue.arrayUnion([uid]),
        });
        return;
      }

      // If one or more waiting — pick first user, create match
      final String matchedUid = pool.first;
      pool.remove(matchedUid);

      final matchesRef = mensaRef.collection('matches').doc();

      transaction.set(matchesRef, {
        'user1': matchedUid,
        'user2': uid,
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
      });

      transaction.update(mensaRef, {
        'pool': pool,
      });
    });
  }

  /// Deletes a match document.
  Future<void> deleteMatch(String mensaId, String matchId) async {
    await _firestore
        .collection('mensa_places')
        .doc(mensaId)
        .collection('matches')
        .doc(matchId)
        .delete();
  }

  /// Marks a match as completed.
  Future<void> completeMatch(String mensaId, String matchId) async {
    await _firestore
        .collection('mensa_places')
        .doc(mensaId)
        .collection('matches')
        .doc(matchId)
        .update({'status': 'completed'});
  }

  /// Returns real-time stream of all matches for a Mensa
  Stream<QuerySnapshot<Map<String, dynamic>>> streamMatches(String mensaId) {
    return _firestore
        .collection('mensa_places')
        .doc(mensaId)
        .collection('matches')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
