import 'package:flutter/material.dart';




class MensaView extends StatelessWidget {
  const MensaView({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MensaView'),
      ),
      body: const SizedBox(
        child: Center(
            child: Text(
          'Mensa_view_working',
          style: TextStyle(fontSize: 18),
        )),
      ),
    );
  }
}





