

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meal_roulette/modules/mensa/data/models/mensa_models.dart';

class MensaProvider extends ChangeNotifier{
  final List<MensaModel> _mensas = [];
  bool _isLoading = false;

  List<MensaModel> get mensas => [..._mensas];
  bool get isLoading => _isLoading;

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
}
