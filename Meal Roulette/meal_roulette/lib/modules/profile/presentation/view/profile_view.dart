import 'package:flutter/material.dart';




class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ProfileView'),
      ),
      body: const SizedBox(
        child: Center(
            child: Text(
          'Profile_view_working',
          style: TextStyle(fontSize: 18),
        )),
      ),
    );
  }
}





