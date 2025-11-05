import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';

/// Header with hero image, rounded corners, and slight parallax on scroll.
/// The parent SliverAppBar will size this appropriately; this widget focuses on visuals & animation.
class HeaderImage extends StatelessWidget {
  final String imageUrl;
  final String heroTag;
  final double borderRadius;

  const HeaderImage({
    super.key,
    required this.imageUrl,
    required this.heroTag,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    // Wrap image with Hero for potential shared-element navigation
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Hero(
        tag: heroTag,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: R.colors.veryLightGrey,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stack) {
                  return Container(
                    color: R.colors.veryLightGrey,
                    child: const Center(child: Icon(Icons.broken_image)),
                  );
                },
              ),

              // Soft gradient to ensure title contrast
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 120,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        R.colors.textBlack.withValues(alpha: 0.35),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
