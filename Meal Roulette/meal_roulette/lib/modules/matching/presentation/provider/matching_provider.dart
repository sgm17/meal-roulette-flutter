
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meal_roulette/modules/auth/data/models/user_model.dart';
import 'package:meal_roulette/modules/matching/data/data_sources/matching_service.dart';
import 'package:meal_roulette/modules/matching/data/models/match_model.dart';

class MatchingProvider extends ChangeNotifier{

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final MatchingService _matchService = MatchingService();
  late Stream<List<MatchModel>> _matchesStream;
  Stream<List<MatchModel>> get matchesStream => _matchesStream; // <-- Cached once

  void fetchMatchesData(){
    _matchesStream = _matchService.getMatchesStream(); // <--- Cache the stream
  }

/*  Future<String> _getOtherUserName(MatchModel match) async {
    final currentUid = _auth.currentUser!.uid;
    final otherUid = match.userId1 == currentUid ? match.userId2 : match.userId1;
    final userDoc = await _firestore.collection('users').doc(otherUid).get();
    return userDoc.data()?['name'] ?? 'Unknown User';
  }*/

  List<MatchModel>? fetchMatchesListFromSnapshot(AsyncSnapshot<List<MatchModel>> snapshot,  int selectedTab){

    try {
      final matches = snapshot.data!;
      final activeMatches = matches.where((m) => _matchService.isToday(m.timestamp)).toList();
      final pastMatches = matches.where((m) => !_matchService.isToday(m.timestamp)).toList();
      return selectedTab == 0 ? activeMatches : pastMatches;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  String? fetchUserIdOfOtherUser(MatchModel match) {
    if (match.userId1 == _auth.currentUser!.uid) {
      return match.userId2;
    }else{
      return match.userId1;
    }
  }

  Future<UserModel?> getUserFromID(String? uid) async {
    if (uid == null) return null;
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists || doc.data() == null) return null;
      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user: $e');
      }
      return null;
    }
  }

  String getDate(dynamic timeStamp){
    if (timeStamp == null) return '';

    // If it's already a Timestamp, convert it properly
    DateTime dateTime;

    if (timeStamp is Timestamp) {
      dateTime = timeStamp.toDate();
    } else if (timeStamp is DateTime) {
      dateTime = timeStamp;
    } else {
      // Fallback for string or unexpected format
      dateTime = DateTime.tryParse(timeStamp.toString()) ?? DateTime.now();
    }

    // Format to "dd MMM yyyy"
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

}
