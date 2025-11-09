

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meal_roulette/modules/mensa/data/models/mensa_models.dart';
import 'package:meal_roulette/modules/mensa/data/repository/mensa_repository.dart';

enum MensaState { idle, loading, matched, completed, error }

class MensaProvider extends ChangeNotifier{
  final MensaRepository _repository;
  final List<MensaModel> _mensas = [];
  bool _isLoading = false;

  List<MensaModel> get mensas => [..._mensas];
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MensaState _state = MensaState.idle;
  MensaState get state => _state;

  MensaProvider(this._repository);

  Future<void> fetchMensas() async {
    _isLoading = true;
    //notifyListeners();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }

    try {
      final snapshot = await FirebaseFirestore.instance.collection('mensa_places').get();
      final List<MensaModel> loaded = snapshot.docs.map((doc) {
        return MensaModel.fromMap(doc.data(), doc.id);
      }).toList();

      _mensas.clear();
      _mensas.addAll(loaded);
    } catch (error) {
      debugPrint('Error fetching mensas: $error');
    }

    _isLoading = false;
    notifyListeners();
  }


  Future<void> findBuddy(String mensaId) async {
    _state = MensaState.loading;
    notifyListeners();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }

    try {
      await _repository.joinQueue(mensaId, user?.uid ?? "");
      _state = MensaState.matched;
    } catch (e) {
      _errorMessage = e.toString();
      _state = MensaState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> completeMatch(String mensaId, String matchId) async {
    await _repository.completeMatch(mensaId, matchId);
  }

  Future<void> deleteMatch(String mensaId, String matchId) async {
    await _repository.deleteMatch(mensaId, matchId);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMatches(String mensaId) {
    return _repository.getMatches(mensaId);
  }

  void resetState() {
    _state = MensaState.idle;
    notifyListeners();
  }
}
