import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/modules/mensa/presentation/provider/mensa_provider.dart';
import 'package:provider/provider.dart';

import 'mensa_card.dart';

class MensaList extends StatelessWidget {
  const MensaList({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive column count
    final crossAxisCount = MediaQuery.of(context).size.width < 600 ? 2 : 4;
    final provider = Provider.of<MensaProvider>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          physics: const BouncingScrollPhysics(),
          itemCount: provider.mensas.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.w,
            childAspectRatio: 0.6, // Try between 0.6–0.8
          ),
          itemBuilder: (context, index) {
            final mensa = provider.mensas[index];
            final hasJoined = provider.joinStatus[mensa.id] ?? false;
            // Smooth animated entry when scrolling
            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 250 + (index * 60)),
              curve: Curves.easeOutCubic,
              tween: Tween(begin: 0, end: 1),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 30 * (1 - value)),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: MensaCard(mensaModel: mensa, index: index, joinedStatus: hasJoined),
              ),
            );
          },
        );
      },
    );
  }
}
