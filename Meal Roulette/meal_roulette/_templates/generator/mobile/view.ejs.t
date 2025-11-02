---
to: lib/modules/<%= h.changeCase.snake(name) %>/presentation/view/<%= h.changeCase.snake(name) %>_view.dart
---
import 'package:flutter/material.dart';

<% namePascalCase = h.changeCase.pascal(name) %>


class <%= namePascalCase %>View extends StatelessWidget {
  const <%= namePascalCase %>View({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('<%= namePascalCase %>View'),
      ),
      body: const SizedBox(
        child: Center(
            child: Text(
          '<%= namePascalCase %>_view_working',
          style: TextStyle(fontSize: 18),
        )),
      ),
    );
  }
}





