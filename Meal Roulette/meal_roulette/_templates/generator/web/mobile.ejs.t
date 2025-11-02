---
to: lib/modules/<%= h.changeCase.snake(name) %>/presentation/view/mobile/mobile.dart
---
<% namePascalCase = h.changeCase.pascal(name) %>

part of "../<%= h.changeCase.snake(name) %>_view.dart";



class Mobile extends StatelessWidget {
  const Mobile({super.key});

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
          'mobile_view_working',
          style: TextStyle(fontSize: 18),
        )),
      ),
    );
  }
}