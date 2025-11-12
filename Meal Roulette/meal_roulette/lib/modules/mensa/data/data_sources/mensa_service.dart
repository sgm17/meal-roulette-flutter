import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MensaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;


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
        'status': 'offered',
        'mensaID': mensaId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      transaction.update(mensaRef, {
        'pool': pool,
      });
    });
  }

  /// Removes user from queue and pairing is halted.
  Future<void> leaveMensaQueue(String mensaId, String uid) async {
    final mensaRef = _firestore.collection('mensa_places').doc(mensaId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(mensaRef);

      List<dynamic> pool = snapshot.data()?['pool']?.cast<String>() ?? [];

      // If no one waiting, just add the current user
      if (pool.isNotEmpty && pool.first == uid) {
        pool.remove(pool.first);        // Remove first or matched user
        transaction.update(mensaRef, {  // Update transaction in database
          'pool': pool,
        });
        return;
      }

    });
  }

  Future<bool> hasJoinedPool(String mensaId) async {
    final uid = _auth.currentUser!.uid;
    final doc = await _firestore.collection('mensa_places').doc(mensaId).get();
    final pool = List<String>.from(doc.data()?['pool'] ?? []);
    return pool.contains(uid);
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
