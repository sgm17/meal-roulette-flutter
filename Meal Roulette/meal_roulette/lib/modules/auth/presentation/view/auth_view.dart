import 'package:flutter/material.dart';




class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('AuthView'),
      ),
      body: const SizedBox(
        child: Center(
            child: Text(
          'Auth_view_working',
          style: TextStyle(fontSize: 18),
        )),
      ),
    );
  }
}





