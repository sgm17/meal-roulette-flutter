import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

/// Rounded segmented toggle (Login / Register).
/// Uses AnimatedContainer to animate the active pill sliding between options.
class SegmentedToggle extends StatelessWidget {
  final bool isLogin;
  final ValueChanged<bool> onChanged;
  const SegmentedToggle({super.key, required this.isLogin, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: R.colors.veryLightGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: R.colors.textGrey.withValues(alpha: 0.2), width: 1)
      ),
      child: Stack(
        children: [
          // Sliding active pill
          AnimatedAlign(
            alignment: isLogin ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            child: Container(
              width: (MediaQuery.of(context).size.width > 520) ? 220 : (MediaQuery.of(context).size.width / 2 - 32),
              margin: EdgeInsets.all(4.h),
              decoration: BoxDecoration(
                color: R.colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: R.colors.textGrey.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))],
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => onChanged(true),
                  borderRadius: BorderRadius.circular(12),
                  child: Center(
                    child: Text('Login', style: TextStyle(fontWeight: isLogin ? FontWeight.w700 : FontWeight.w500, color: isLogin ? R.colors.textBlack : R.colors.textGrey)),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => onChanged(false),
                  borderRadius: BorderRadius.circular(12),
                  child: Center(
                    child: Text('Register', style: TextStyle(fontWeight: isLogin ? FontWeight.w500 : FontWeight.w700, color: isLogin ? R.colors.textGrey : R.colors.textBlack)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
