---
to: lib/modules/<%= h.changeCase.snake(name) %>/presentation/view/desktop/desktop.dart
---
<% namePascalCase = h.changeCase.pascal(name) %>

part of "../<%= h.changeCase.snake(name) %>_view.dart";



class Desktop extends StatelessWidget {
  const Desktop({super.key});

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
          'desktop_view_working',
          style: TextStyle(fontSize: 18),
        )),
      ),
    );
  }
}