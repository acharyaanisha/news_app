import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../../constants/app_constants.dart';
import '../widgets/custom_text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpSent = false;
  // bool _isLogin = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        // _isLogin = _tabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.of(context).pushReplacementNamed('/home');
            } else if (state is OtpSent) {
              setState(() {
                _isOtpSent = true;
              });
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(localizations.otpSent)));
            } else if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.article,
                              size: 80,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              AppConstants.appName,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Tab Bar
                    TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(text: localizations.login),
                        Tab(text: localizations.signup),
                      ],
                    ),

                    // Form
                    Expanded(
                      flex: 3,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildAuthForm(context, true),
                          _buildAuthForm(context, false),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAuthForm(BuildContext context, bool isLogin) {
    final localizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          // Phone Number Field
          CustomTextField(
            controller: _phoneController,
            hintText: localizations.phone,
            labelText: localizations.phone,
            keyboardType: TextInputType.phone,
            prefixIcon: const Icon(Icons.phone),
          ),

          const SizedBox(height: 24),

          // Send OTP Button
          if (!_isOtpSent) ...[
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _sendOtp,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.defaultBorderRadius,
                    ),
                  ),
                ),
                child: Text(localizations.verify),
              ),
            ),
          ] else ...[
            // OTP Field
            Text(
              localizations.enterOtp,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            OtpTextField(
              onCompleted: (otp) {
                _verifyOtp(otp, isLogin);
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _resendOtp,
              child: Text(localizations.resendOtp),
            ),
          ],

          const SizedBox(height: 32),

          // Loading Indicator
          if (context.watch<AuthBloc>().state is AuthLoading)
            const CircularProgressIndicator(),
        ],
      ),
    );
  }

  void _sendOtp() {
    final phone = _phoneController.text.trim();
    if (phone.isNotEmpty) {
      context.read<AuthBloc>().add(SendOtp(phoneNumber: phone));
    }
  }

  void _verifyOtp(String otp, bool isLogin) {
    if (isLogin) {
      context.read<AuthBloc>().add(
        LoginWithPhone(phoneNumber: _phoneController.text),
      );
    } else {
      context.read<AuthBloc>().add(
        SignupWithPhone(phoneNumber: _phoneController.text),
      );
    }
  }

  void _resendOtp() {
    setState(() {
      _isOtpSent = false;
    });
    _sendOtp();
  }
}
