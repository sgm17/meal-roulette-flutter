import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatchListenerService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final String mensaId;
 // final _notifications = FlutterLocalNotificationsPlugin();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  MatchListenerService(this.mensaId) {
    _initNotifications();
    initMatchListener();
  }

  void _initNotifications() async {
    // Android settings
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    // iOS (Darwin) settings
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    // Combined settings
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings, // ✅ for iOS
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // handle tap
      },
    );

    // 1️⃣ Create the channel first (Android 8+)
    const channel = AndroidNotificationChannel(
      'match_channel',
      'Match Notifications',
      description: 'Notifications when a new match is found',
      importance: Importance.max,
    );

    final androidPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(channel);
      await androidPlugin.requestNotificationsPermission();
    }


    // Explicitly request iOS permissions (optional but recommended)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

  }

  // Call this to start listening
  void initMatchListener() {
    final user = _auth.currentUser;
    if (user == null) {
      print('User not authenticated. Cannot listen for matches.');
      return;
    }
    final uid = user.uid;

    // Listen to all "matches" subcollections under any mensa_places
    _firestore.collection('mensa_places')
        .doc(mensaId)
        .collection('matches')
        .orderBy('createdAt', descending: true)
        .snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final data = change.doc.data();
          if (data == null) continue;

          final user1 = data['user1'] as String?;
          final user2 = data['user2'] as String?;

          // Only notify if the current user is part of the match
          if (user1 == uid || user2 == uid) {
            _handleNewMatch(data, uid);
          }
        }
      }
    }, onError: (error) {
      print('Error listening for matches: $error');
    });
  }

  Future<void> _handleNewMatch(Map<String, dynamic> match, String currentUid) async {
    final user1Ref = _firestore.collection('users').doc(match['user1']);
    final user2Ref = _firestore.collection('users').doc(match['user2']);

    final user1Data = (await user1Ref.get()).data()!;
    final user2Data = (await user2Ref.get()).data()!;

    final currentUserData = currentUid == match['user1Id'] ? user1Data : user2Data;
    final otherUserData = currentUid == match['user1Id'] ? user2Data : user1Data;

    final message =
        "🎉 Hurray! We found a match for you, ${currentUserData['name']}! Your buddy is ${otherUserData['name']}.";

    await flutterLocalNotificationsPlugin.show(
      0,
      "New Lunch Buddy Found!",
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'match_channel', // Must match channel ID
          'Match Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );

    // Optional: send email using free service (below)
    sendEmail(toEmail: otherUserData['email'], myName: currentUserData['name'], otherUserName: otherUserData['name']);
  }

  Future<void> sendEmail({
    required String toEmail,
    required String myName,
    required String otherUserName,
  }) async {
    const serviceId = 'service_0eptsc3';
    const templateId = 'template_youm8t4';
    const publicKey = 'fUKHkESaJzxmiix5w';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': publicKey,
          'template_params': {
            'to_name': myName,
            'message':
            'Hey $myName! Your new lunch buddy is $otherUserName 🍽️',
            'to_email': toEmail,
          }
        }));

    print('Email sent: ${response.statusCode}');
  }
}
