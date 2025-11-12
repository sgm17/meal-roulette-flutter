

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meal_roulette/configs/utils/singleton.dart';
import 'package:meal_roulette/modules/mensa/data/models/mensa_models.dart';
import 'package:meal_roulette/modules/mensa/data/repository/mensa_repository.dart';
import 'package:meal_roulette/modules/notifications/data/data_sources/match_listener_service.dart';

enum MensaState { idle, loading, matched, completed, error }

class MensaProvider extends ChangeNotifier{
  final MensaRepository _repository;

  final Map<String, bool> joinStatus = {}; // mensaId -> joined?
  final List<MensaModel> _mensas = [];
  List<MensaModel> get mensas => [..._mensas];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MensaState _state = MensaState.idle;
  MensaState get state => _state;


  MensaProvider(this._repository);

  Future<void> fetchMensas() async {
    _isLoading = true;
    notifyListeners();

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

  Future<void> initializeJoinStatuses() async {
    for (var mensa in mensas) {
      joinStatus[mensa.id] = await hasJoinedPool(mensa.id);
    }
    notifyListeners();
  }

  Future<void> toggleJoinPool(String mensaId) async {
    final current = joinStatus[mensaId] ?? false;
    joinStatus[mensaId] = !current;
    notifyListeners(); // immediate UI update

    // Then update backend asynchronously
    if (!current) {
      await joinPool(mensaId);
      Singleton.selectedMensaId = mensaId;
      MatchListenerService(mensaId);
    } else {
      await leavePool(mensaId);
    }
  }


  Future<void> joinPool(String mensaId) async {
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

 Future<void> leavePool(String mensaId) async {
    _state = MensaState.loading;
    notifyListeners();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }

    try {
      await _repository.leaveQueue(mensaId, user?.uid ?? "");
      _state = MensaState.matched;
    } catch (e) {
      _errorMessage = e.toString();
      _state = MensaState.error;
    } finally {
      notifyListeners();
    }
  }

 Future<bool> hasJoinedPool(String mensaId) async {
    try {
      return await _repository.hasJoinedPool(mensaId);
     } catch (e) {
      _errorMessage = e.toString();
      print(e);
      rethrow;
    }
  }



  Stream<QuerySnapshot<Map<String, dynamic>>> getMatches(String mensaId) {
    return _repository.getMatches(mensaId);
  }

  void resetState() {
    _state = MensaState.idle;
    notifyListeners();
  }
}
