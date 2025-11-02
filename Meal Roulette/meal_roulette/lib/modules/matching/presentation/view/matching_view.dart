import 'package:flutter/material.dart';




class MatchingView extends StatelessWidget {
  const MatchingView({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MatchingView'),
      ),
      body: const SizedBox(
        child: Center(
            child: Text(
          'Matching_view_working',
          style: TextStyle(fontSize: 18),
        )),
      ),
    );
  }
}





