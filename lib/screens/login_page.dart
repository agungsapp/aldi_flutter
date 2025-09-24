import 'package:flutter/material.dart';
import 'package:notifikasi/widgets/custom_text_field.dart';
import 'package:notifikasi/widgets/custom_button.dart';
import 'package:notifikasi/constants/colors.dart';
import 'package:notifikasi/services/auth_service.dart';
import 'package:notifikasi/utils/helpers.dart';
import 'package:notifikasi/routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    final authService = AuthService();
    final success = await authService.login(
      emailController.text,
      passwordController.text,
    );

    // hanya debug only
    // Future.delayed(const Duration(seconds: 3));
    // final success = true;

    setState(() => _isLoading = false);
    // print("sukses bos isinya ${success}");
    if (success) {
      showSnackBar(context, "Login berhasil!", Colors.green);
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    } else {
      showSnackBar(context, "Email atau password salah", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.loginGradient),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const SizedBox(height: 80),
                          _buildHeader(),
                          const SizedBox(height: 40),
                          _buildForm(),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          const Icon(Icons.badge_outlined, size: 60, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text(
            "Selamat Datang",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            "Silahkan login disini",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            labelText: "Email",
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.number,
            textStyle: const TextStyle(
              color: Colors.black,
            ), // Teks akan berwarna hitam
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: passwordController,
            labelText: "Password",
            prefixIcon: Icons.lock_outline,
            obscureText: _isObscure,
            textStyle: const TextStyle(color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
                color: AppColors.primary,
              ),
              onPressed: () => setState(() => _isObscure = !_isObscure),
            ),
          ),
          const SizedBox(height: 32),
          _isLoading
              ? const CircularProgressIndicator(color: AppColors.primary)
              : CustomButton(
                  text: "Masuk",
                  onPressed: _handleLogin,
                  gradient: AppColors.buttonGradient,
                ),
        ],
      ),
    );
  }
}
