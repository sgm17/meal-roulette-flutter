

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getMatches(String mensaId) {
    return _service.streamMatches(mensaId);
  }
}
