import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/modules/auth/data/models/user_model.dart';
import 'package:meal_roulette/modules/auth/presentation/provider/auth_provider.dart';
import 'package:meal_roulette/routes/app_routes.dart';
import 'package:meal_roulette/routes/app_routes_constants.dart';
import 'package:provider/provider.dart';
import '../widgets/segmented_toggle.dart';
import '../widgets/animated_input.dart';
import '../widgets/primary_button.dart';

/// Main auth screen with animated Login / Register flows.
/// - Uses AnimatedSwitcher for toggling between forms
/// - Form validation is handled via TextFormField validators
/// - Hero is used on the logo to allow future shared transitions
class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with SingleTickerProviderStateMixin {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();

  // controllers
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  // simple loading state for the primary button
  bool _loading = false;

  // animation controller to slightly stagger elements on mount
  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext ctx) async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    final provider = Provider.of<AuthProvider>(ctx, listen: false);

    setState(() => _loading = true);

    try {
      UserModel? user = (_isLogin) ? await provider.login(email: _emailCtrl.text.trim(), password: _passCtrl.text) : await provider.register(name: _nameCtrl.text.trim(), phone: _phoneCtrl.text.trim(), email: _emailCtrl.text.trim(), password: _passCtrl.text);

      // On success, you likely navigate to your app's home — we pop for demo.
      if (user != null) {
        if(_isLogin){
          if (context.mounted) {
            getContext().goNamed(AppRouteConstants.home);
            return;
          }
        }else{
          ScaffoldMessenger.of(getContext()).showSnackBar(SnackBar(content: Text("Verify your email first and login again.")));
        }
      }else{
        ScaffoldMessenger.of(getContext()).showSnackBar(SnackBar(content: Text("No Data found for this user")));
      }
    } catch (e) {
      // error already set in provider; you can show a snackbar too
      final msg = provider.error ?? 'Auth failed';
      ScaffoldMessenger.of(getContext()).showSnackBar(SnackBar(content: Text(msg)));
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 520;

    return Scaffold(
      backgroundColor: R.colors.splashGrad1.withValues(alpha: 0.5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isWide ? 520 : 420),
              child: Card(
                color: R.colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: R.colors.textGrey.withValues(alpha: 0.2), // subtle themed border
                    width: 1,
                  ),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Logo with hero so it can animate to other screens
                        FadeTransition(
                          opacity: CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.35)),
                          child: Column(
                            children: [
                              Hero(
                                tag: 'app_logo',
                                child: Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        R.colors.splashGrad1,
                                        R.colors.splashGrad2, // optional: add a second theme color for vibrance
                                      ],
                                    ),
                                    boxShadow: [BoxShadow(color: R.colors.textGrey.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(2, 4))],
                                  ),
                                  child: Icon(Icons.local_dining_outlined, color: Colors.white, size: 32.h),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text('Mystery Meal Roulette', style: R.textStyles.font26B, textAlign: TextAlign.center),
                              SizedBox(height: 6.h),
                              Text('Connect with fellow students over lunch', style: R.textStyles.font10M.copyWith(color: R.colors.textGrey)),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),

                        // Segmented toggle (Login / Register)
                        SegmentedToggle(
                          isLogin: _isLogin,
                          onChanged: (v) {
                            setState(() {
                              _isLogin = v;
                              // reset form fields when switching
                              _formKey.currentState?.reset();
                            });
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Animated form area switches height/content smoothly
                        AnimatedSize(
                          duration: const Duration(milliseconds: 360),
                          curve: Curves.easeInOutCubic,
                          child: Column(
                            children: [
                              // Name field only visible on Register
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 260),
                                transitionBuilder: (child, anim) => SizeTransition(sizeFactor: anim, child: child),
                                child: _isLogin
                                    ? const SizedBox.shrink()
                                    : Padding(
                                        key: const ValueKey('name_field'),
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: AnimatedInput(controller: _nameCtrl, label: 'Full name', hint: 'Your name', validator: (v) => (v == null || v.trim().isEmpty) ? 'Name cannot be empty' : null),
                                      ),
                              ),

                              // Name field only visible on Register
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 260),
                                transitionBuilder: (child, anim) => SizeTransition(sizeFactor: anim, child: child),
                                child: _isLogin
                                    ? const SizedBox.shrink()
                                    : Padding(
                                        key: const ValueKey('phone_field'),
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: AnimatedInput(controller: _phoneCtrl, label: 'Phone #', hint: 'Your Phone', validator: (v) => (v == null || v.trim().isEmpty) ? 'Name cannot be empty' : null),
                                      ),
                              ),

                              // Email
                              AnimatedInput(
                                controller: _emailCtrl,
                                label: 'Email',
                                hint: 'you@uzh.ch',
                                keyboardType: TextInputType.emailAddress,
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) return 'Email required';
                                  if (!v.contains('@')) return 'Enter a valid email';
                                  if (!v.contains('@uzh.ch')) return 'Only university Email is allowed';
                                  return null;
                                },
                              ),
                              SizedBox(height: 12.h),

                              // Password
                              AnimatedInput(
                                controller: _passCtrl,
                                label: 'Password',
                                hint: 'Your password',
                                obscureText: true,
                                validator: (v) {
                                  if (v == null || v.length < 6) return 'Password must be at least 6 characters';
                                  return null;
                                },
                              ),
                              SizedBox(height: 16.h),

                              // Primary action
                              PrimaryButton(label: _isLogin ? 'Login' : 'Register', loading: _loading, onPressed: () => _submit(context)),

                              const SizedBox(height: 18),

                              // OR separator
                              // Row(
                              //   children: [
                              //     const Expanded(child: Divider(thickness: 1)),
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 8),
                              //       child: Text('OR CONTINUE WITH', style: Theme.of(context).textTheme.labelSmall),
                              //     ),
                              //     const Expanded(child: Divider(thickness: 1)),
                              //   ],
                              // ),
                              //
                              // const SizedBox(height: 14),
                              //
                              // // Social button (Google)
                              // SocialButton(
                              //   label: 'Google',
                              //   icon: Icons.mail_outline,
                              //   onPressed: () {
                              //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Google auth is demo only')));
                              //   },
                              // ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
