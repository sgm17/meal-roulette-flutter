import 'package:cloud_firestore/cloud_firestore.dart';

class MatchModel {
  final String id;
  final String userId1;
  final String userId2;
  final Timestamp timestamp;

  MatchModel({
    required this.id,
    required this.userId1,
    required this.userId2,
    required this.timestamp,
  });

  factory MatchModel.fromMap(Map<String, dynamic> data, String docId) {
    return MatchModel(
      id: docId,
      userId1: data['user1'] ?? '',
      userId2: data['user2'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user1': userId1,
      'user2': userId2,
      'timestamp': timestamp,
    };
  }
}
