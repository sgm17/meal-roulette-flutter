import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/modules/profile/presentation/widgets/profile_form_card.dart';
import '../widgets/avatar_header.dart';
import '../widgets/stat_card.dart';

/// Full screen implementing the profile dashboard displayed in the mock.
/// Uses adaptive layout, implicit animations and small micro-interactions.
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // Demo state for stats
  int active = 3;
  int totalLunches = 5;
  int interests = 0;
  int completion = 100;

  // toggles edit mode for the form (animated)
  bool _editing = false;

  // control saving animation
  bool _isSaving = false;

  // method to mimic a save action (shows micro-interaction)
  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);
    // simulated network/save delay
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() {
      _isSaving = false;
      _editing = false;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profile saved'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Layout breakpoints for responsiveness
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 820;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isWide ? 1100 : 780),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top banner + avatar card
                  AvatarHeader(
                    username: 'Demo User',
                    subtitle: 'Demo University',
                    onAvatarTap: () {
                      // small bounce scale on tap handled inside AvatarHeader
                    },
                  ),

                  SizedBox(height: 80.h),

                  // Stats cards row (adaptive)
                  LayoutBuilder(builder: (context, constraints) {
                    // If narrow, display scrollable row, else grid-like row
                    final showAsRow = constraints.maxWidth < 720;
                    if (showAsRow) {
                      return SizedBox(
                        height: 120.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            StatCard(title: 'Active', value: '$active', color: R.colors.red, icon: Icons.emoji_events_outlined,),
                             SizedBox(width: 6.h),
                            StatCard(title: 'Total Lunches', value: '$totalLunches', color: R.colors.green, icon: Icons.calendar_month_outlined),
                             SizedBox(width: 6.h),
                            StatCard(title: 'Interests', value: '$interests', color: R.colors.secondaryColor, icon: Icons.auto_awesome_outlined),
                             SizedBox(width: 6.h),
                            StatCard(title: 'Complete', value: '$completion%', color: R.colors.textBlack  , icon: Icons.person_outline),
                          ],
                        ),
                      );
                    } else {
                      // wide layout: 4 equal cards
                      return Row(
                        children: [
                          Expanded(child: StatCard(title: 'Active', value: '$active', color: R.colors.red, icon: Icons.emoji_events_outlined,),),
                           SizedBox(width: 12.h),
                          Expanded(child: StatCard(title: 'Total Lunches', value: '$totalLunches', color: R.colors.green, icon: Icons.calendar_month_outlined),),
                           SizedBox(width: 12.h),
                          Expanded(child: StatCard(title: 'Interests', value: '$interests', color:  R.colors.secondaryColor, icon: Icons.auto_awesome_outlined),),
                           SizedBox(width: 12.h),
                          Expanded(child: StatCard(title: 'Complete', value: '$completion%', color: R.colors.textBlack  , icon: Icons.person_outline),),
                        ],
                      );
                    }
                  }),

                  SizedBox(height: 16.h),

                  // Profile information form/card (expandable editing)
                  ProfileFormCard(
                      key: ValueKey(_editing),
                      editing: _editing,
                      onSave: _saveProfile,
                      isSaving: _isSaving,
                    ),


                  SizedBox(height: 20.h),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





