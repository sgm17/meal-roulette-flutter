---
to: lib/modules/<%= h.changeCase.snake(name) %>/presentation/view/<%= h.changeCase.snake(name) %>_view.dart
---
import 'package:flutter/material.dart';
import 'package:serve_u/utils/widgets/reponsive.dart';

part '../new/mobile/mobile.dart';
part '../new/tablet/tablet.dart';
part '../new/desktop/desktop.dart';

<% namePascalCase = h.changeCase.pascal(name) %>


class <%= namePascalCase %>View extends StatelessWidget {
  const <%= namePascalCase %>View({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
        mobile: Mobile(), tablet: Tablet(), desktop: Desktop());
  }
}