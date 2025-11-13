

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_roulette/modules/mensa/data/data_sources/mensa_service.dart';

class MensaRepository {
  final MensaService _service;

  MensaRepository(this._service);

  Future<void> joinQueue(String mensaId, String uid) async {
    try {
      await _service.joinMensaQueue(mensaId, uid);
    } catch (e) {
      throw Exception('Failed to join queue: $e');
    }
  }

  Future<void> leaveQueue(String mensaId, String uid) async {
    try {
      await _service.leaveMensaQueue(mensaId, uid);
    } catch (e) {
      throw Exception('Failed to leave queue: $e');
    }
  }

  Future<bool> hasJoinedPool(String mensaId) async {
    try {
      return await _service.hasJoinedPool(mensaId);
    } catch (e) {
      throw Exception('Failed to leave queue: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMatches(String mensaId) {
    return _service.streamMatches(mensaId);
  }
}
