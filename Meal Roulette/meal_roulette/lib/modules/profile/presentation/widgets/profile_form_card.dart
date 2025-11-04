import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/modules/profile/presentation/widgets/profile_form_textfield.dart';

/// Profile form card that toggles between read-only view and editable fields.
/// Uses AnimatedSize and AnimatedOpacity to animate layout changes smoothly.
class ProfileFormCard extends StatefulWidget {
  final bool editing;
  final Future<void> Function() onSave;
  final bool isSaving;

  const ProfileFormCard({super.key, required this.editing, required this.onSave, required this.isSaving});

  @override
  State<ProfileFormCard> createState() => _ProfileFormCardState();
}

class _ProfileFormCardState extends State<ProfileFormCard> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // form fields for demo
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Demo User');
    _emailController = TextEditingController(text: '');
    _phoneController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSaveTap() {
    if (widget.editing) {
      if (_formKey.currentState?.validate() ?? false) {
        widget.onSave();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeInOut,
      child: Card(
        color: R.colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header row
                Row(
                  children: [
                    Icon(Icons.person_outlined, color: R.colors.red, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text('Profile Information', style: R.textStyles.font14M.copyWith(color: R.colors.textBlack)),
                  ],
                ),

                Text(
                  'Keep your details up to date',
                  style: R.textStyles.font10M.copyWith(color: R.colors.textGrey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),

                SizedBox(height: 12.h),

                // Stats cards row (adaptive)
                LayoutBuilder(
                  builder: (context, constraints) {
                    // If narrow, display scrollable row, else grid-like row
                    final showAsRow = constraints.maxWidth < 720;
                    if (showAsRow) {
                      return Column(
                        children: [
                          ProfileTextField(title: 'Full Name', hint: '', controller: _nameController, icon: Icons.person_outlined, validator: (v) => v == null || v.isEmpty ? 'Enter name' : null),
                          SizedBox(height: 16.h),
                          ProfileTextField(title: 'Email', hint: 'demo@university.edu', controller: _emailController, icon: Icons.email_outlined, validator: (v) => v == null || !v.contains('@') ? 'Enter valid email' : null),
                        ],
                      );
                    } else {
                      // wide layout: 4 equal cards
                      return Row(
                        children: [
                          Expanded(
                            child: ProfileTextField(title: 'Full Name', hint: '', controller: _nameController, icon: Icons.person_outlined, validator: (v) => v == null || v.isEmpty ? 'Enter name' : null),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ProfileTextField(title: 'Email', hint: 'demo@university.edu', controller: _emailController, icon: Icons.email_outlined, validator: (v) => v == null || !v.contains('@') ? 'Enter valid email' : null),
                          ),
                        ],
                      );
                    }
                  },
                ),

                SizedBox(height: 16.h),
                ProfileTextField(title: 'Phone Number', hint: '+41 XX XXX XX XX', controller: _phoneController, icon: Icons.phone_outlined, validator: (v) => null),

                SizedBox(height: 16.h),
                Divider(height: 1.h, thickness: 1.h, color: R.colors.veryLightGrey),
                SizedBox(height: 16.h),

                // Save button with loading state
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.local_dining_outlined, color: R.colors.transparent),
                        label: Text(
                          'Save Changes',
                          style: R.textStyles.font11M.copyWith(color: R.colors.white),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        style: FilledButton.styleFrom(
                          minimumSize: Size.fromHeight(40.h),
                          backgroundColor: R.colors.primaryColor,
                          disabledBackgroundColor: R.colors.veryLightGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Reduced from default (~20)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logout (demo)')),
                        );
                      },
                      icon: Icon(Icons.logout, color: R.colors.textBlack),
                      label: Text(
                        'Logout',
                        style: R.textStyles.font11M.copyWith(color: R.colors.textBlack),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: R.colors.veryLightGrey,
                        disabledBackgroundColor: R.colors.textGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Reduced from default (~20)
                        ),
                        side: BorderSide(
                          color: R.colors.textGrey.withValues(alpha: 0.2), // your custom border color
                          width: 0.5, // optional: adjust thickness
                        ),
                      ),

                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
