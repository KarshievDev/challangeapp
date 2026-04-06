import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/colors.dart';
import '../../blocs/auth_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient / Cyber Aesthetic
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.background, Color(0xFF1A1A1D)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    // Logo/Title
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(50),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 2),
                        ),
                        child: Icon(Icons.rocket_launch, size: 64, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'LevelUp Challenge',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        letterSpacing: 2,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'Gamify your growth.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 60),
                    // Email Field
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        prefixIcon: Icon(Icons.email_outlined, color: AppColors.textCaption),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline, color: AppColors.textCaption),
                        suffixIcon: Icon(Icons.visibility_off_outlined, color: AppColors.textCaption),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Sign In Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleEmailSignIn,
                      child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Sign In'),
                    ),
                    const SizedBox(height: 24),
                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.textCaption.withAlpha(50))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR', style: TextStyle(color: AppColors.textCaption)),
                        ),
                        Expanded(child: Divider(color: AppColors.textCaption.withAlpha(50))),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Social Sign In
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _isLoading ? null : _handleGoogleSignIn,
                            icon: Icon(Icons.g_mobiledata, size: 24),
                            label: Text('Google'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: AppColors.textCaption.withAlpha(50)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _isLoading ? null : _handleAppleSignIn,
                            icon: Icon(Icons.apple, size: 24),
                            label: Text('Apple'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: AppColors.textCaption.withAlpha(50)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: TextButton(
                        onPressed: () {}, // Navigate to Sign Up
                        child: Text("Don't have an account? Sign Up"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleEmailSignIn() async {
    setState(() => _isLoading = true);
    try {
      final user = await context.read<AuthRepository>().signInWithEmail(_emailController.text, _passwordController.text);
      if (user != null) {
        context.read<AuthBloc>().add(AuthLoggedIn(user: user));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: ${e.toString()}')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final user = await context.read<AuthRepository>().signInWithGoogle();
      if (user != null) {
        context.read<AuthBloc>().add(AuthLoggedIn(user: user));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google Sign In failed: ${e.toString()}')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleAppleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final user = await context.read<AuthRepository>().signInWithApple();
      if (user != null) {
        context.read<AuthBloc>().add(AuthLoggedIn(user: user));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Apple Sign In failed: ${e.toString()}')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
