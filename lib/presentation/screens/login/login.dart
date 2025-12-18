import 'package:elysian_user/presentation/screens/login/Divider_with_text.dart';
import 'package:elysian_user/presentation/screens/login/widget/email_inputfield.dart';
import 'package:elysian_user/presentation/screens/login/widget/forgot_password_link.dart';
import 'package:elysian_user/presentation/screens/login/widget/google_signin_button.dart';
import 'package:elysian_user/presentation/screens/login/widget/logo_selection.dart';
import 'package:elysian_user/presentation/screens/login/widget/password_inputfield.dart';
import 'package:elysian_user/presentation/screens/login/widget/sign_in_button.dart';
import 'package:elysian_user/presentation/screens/login/widget/sign_up_prompt.dart';
import 'package:elysian_user/presentation/screens/login/widget/subtitle_text.dart';
import 'package:elysian_user/presentation/screens/login/widget/topindicator.dart';
import 'package:elysian_user/presentation/screens/login/widget/welcome_text.dart';

import 'package:elysian_user/core/utils/validators.dart';
import 'package:elysian_user/features/auth/logic/bloc/login/login_bloc.dart';
import 'package:elysian_user/features/auth/logic/bloc/login/login_event.dart';
import 'package:elysian_user/features/auth/logic/bloc/login/login_state.dart';
import 'package:elysian_user/features/auth/logic/bloc/profile/profile_bloc.dart';
import 'package:elysian_user/features/auth/logic/bloc/profile/profile_event.dart';
import 'package:elysian_user/features/navigation/logic/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:elysian_user/features/navigation/logic/bloc/bottom_nav/bottom_nav_event.dart';
import 'package:elysian_user/presentation/screens/main_nav/main_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.read<BottomNavBloc>().add(const ChangeTab(0));
          context.read<ProfileBloc>().add(const LoadProfile());

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainNavScreen()),
          );
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const TopIndicator(),
                  const SizedBox(height: 40),
                  const LogoSection(),
                  const SizedBox(height: 40),
                  const WelcomeText(),
                  const SizedBox(height: 8),
                  const SubtitleText(),
                  const SizedBox(height: 40),
                  EmailInputField(controller: emailController),
                  const SizedBox(height: 16),
                  PasswordInputField(controller: passwordController),
                  const SizedBox(height: 8),
                  const ForgotPasswordLink(),
                  const SizedBox(height: 32),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return SignInButton(
                        isLoading: state is LoginLoading,
                        onPressed: () {
                          final email = emailController.text.trim();
                          final password = passwordController.text;

                          final validationErrors = Validators.validateLogin(
                            email: email,
                            password: password,
                          );

                          final emailError = validationErrors['email'];
                          final passwordError = validationErrors['password'];

                          if (emailError != null || passwordError != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  emailError ??
                                      passwordError ??
                                      'Please fix the errors',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          context.read<LoginBloc>().add(
                            LoginSubmitted(email: email, password: password),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const SignUpPrompt(),
                  const SizedBox(height: 24),
                  const DividerWithText(),
                  const SizedBox(height: 24),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return GoogleSignInButton(
                        isLoading: state is LoginLoading,
                        onTap: () {
                          context.read<LoginBloc>().add(
                            const GoogleLoginRequested(),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
