import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

/// Header with gradient banner and avatar. Avatar uses Hero tag to allow shared transitions
/// if you later make a separate edit screen. Includes small animation on tap for tactile feel.
class AvatarHeader extends StatefulWidget {
  final String username;
  final String subtitle;
  final VoidCallback? onAvatarTap;

  const AvatarHeader({super.key, required this.username, required this.subtitle, this.onAvatarTap});

  @override
  State<AvatarHeader> createState() => _AvatarHeaderState();
}

class _AvatarHeaderState extends State<AvatarHeader> with SingleTickerProviderStateMixin {
  // small animation controller for avatar micro-interaction
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
      lowerBound: 0.0,
      upperBound: 0.08, // small scale delta
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    // quick press animation
    _controller.forward().then((_) => _controller.reverse());
    widget.onAvatarTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Gradient banner - provides brand color & soft rounded corners
        Container(
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12.h), topRight: Radius.circular(12.h)),
            gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [R.colors.splashGrad1, R.colors.splashGrad3]),
            boxShadow: [BoxShadow(color: R.colors.splashGrad1.withValues(alpha: 0.12), blurRadius: 12, offset: const Offset(0, 6))],
          ),
        ),

        // Card overlay with avatar and details
        Positioned(
          top: 10.h,
          left: 0,
          right: 0,
          child: Material(
            elevation: 0,
            color: R.colors.transparent,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.h, 18.h, 16.h, 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Avatar with Hero (prepares shared element transitions later)
                  GestureDetector(
                    onTap: _onTap,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        final scale = 1.0 - _controller.value;
                        return Transform.scale(scale: scale, child: child);
                      },
                      child: Hero(
                        tag: 'profile-avatar-hero',
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: R.colors.veryLightGrey,
                          child: Text(
                            'DU', // initials placeholder
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),

                  // Name and subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gradient text for username (subtle)
                        Text(
                          widget.username,
                          style: R.textStyles.font18B.copyWith(color: R.colors.textBlack),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                        Row(
                          children: [
                            Icon(Icons.school_outlined, size: 14.sp, color: R.colors.textGrey),
                            SizedBox(width: 6.w),
                            Text(
                              widget.subtitle,
                              style: R.textStyles.font10M.copyWith(color: R.colors.textGrey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                      ],
                    ),
                  ),

                  // small settings / badges
                  /* Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.settings, size: 18, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ),*/
                ],
              ),
            ),
          ),
        ),

       /* Positioned(
          top: 95.h,
          left: 0,
          right: 220.w,
          child: CircleAvatar(
            backgroundColor: R.colors.red,
            radius: 12.h,
            child: GestureDetector(
              onTap: _onTap,
              child: Icon(Icons.auto_awesome_outlined, size: 12.sp, color: R.colors.white),
            ),
          ),
        ),*/
      ],
    );
  }
}
