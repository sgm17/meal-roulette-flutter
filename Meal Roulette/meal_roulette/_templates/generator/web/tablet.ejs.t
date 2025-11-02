---
to: lib/modules/<%= h.changeCase.snake(name) %>/presentation/view/tablet/tablet.dart
---
<% namePascalCase = h.changeCase.pascal(name) %>
part of "../<%= h.changeCase.snake(name) %>_view.dart";




class Tablet extends StatelessWidget {
  const Tablet({super.key});

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
          'tablet_view_working',
          style: TextStyle(fontSize: 18),
        )),
      ),
    );
  }
}