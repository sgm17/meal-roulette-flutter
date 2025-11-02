import 'package:flutter/material.dart';




class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('NotificationsView'),
      ),
      body: const SizedBox(
        child: Center(
            child: Text(
          'Notifications_view_working',
          style: TextStyle(fontSize: 18),
        )),
      ),
    );
  }
}





