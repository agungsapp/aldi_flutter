import 'package:flutter/material.dart';
import 'package:notifikasi/widgets/custom_text_field.dart';
import 'package:notifikasi/widgets/custom_button.dart';
import 'package:notifikasi/constants/colors.dart';
import 'package:notifikasi/utils/helpers.dart';
import 'package:notifikasi/routes/app_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nipController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isObscurePassword = true;
  bool _isObscureConfirm = true;
  String? _selectedDivisi;
  bool _isLoading = false;

  final List<String> _divisiList = [
    'Teknologi Informasi',
    'Human Resources',
    'Keuangan',
    'Operasional',
    'Marketing',
    'Administrasi',
  ];

  void _handleRegister() {
    if (nipController.text.isEmpty ||
        namaController.text.isEmpty ||
        emailController.text.isEmpty ||
        _selectedDivisi == null ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showSnackBar(context, "Harap lengkapi semua field", Colors.red);
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showSnackBar(
        context,
        "Password dan konfirmasi password tidak sama",
        Colors.red,
      );
      return;
    }

    if (passwordController.text.length < 6) {
      showSnackBar(context, "Password minimal 6 karakter", Colors.red);
      return;
    }

    // Placeholder for API call
    showSnackBar(context, "Registrasi berhasil! Silakan login", Colors.green);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
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
                          const SizedBox(height: 40),
                          _buildHeader(),
                          const SizedBox(height: 30),
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
          const Icon(
            Icons.person_add_outlined,
            size: 60,
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          const Text(
            "Daftar Akun Baru",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            "Lengkapi data diri untuk mendaftar",
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
            controller: nipController,
            labelText: "NIP",
            prefixIcon: Icons.badge_outlined,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: namaController,
            labelText: "Nama Lengkap",
            prefixIcon: Icons.person_outline,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: emailController,
            labelText: "Email",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedDivisi,
              decoration: const InputDecoration(
                labelText: "Divisi",
                prefixIcon: Icon(
                  Icons.business_outlined,
                  color: AppColors.primary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
              ),
              items: _divisiList.map((String divisi) {
                return DropdownMenuItem<String>(
                  value: divisi,
                  child: Text(divisi),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() => _selectedDivisi = newValue);
              },
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: passwordController,
            labelText: "Password",
            prefixIcon: Icons.lock_outline,
            obscureText: _isObscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.primary,
              ),
              onPressed: () =>
                  setState(() => _isObscurePassword = !_isObscurePassword),
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: confirmPasswordController,
            labelText: "Konfirmasi Password",
            prefixIcon: Icons.lock_outline,
            obscureText: _isObscureConfirm,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscureConfirm ? Icons.visibility_off : Icons.visibility,
                color: AppColors.primary,
              ),
              onPressed: () =>
                  setState(() => _isObscureConfirm = !_isObscureConfirm),
            ),
          ),
          const SizedBox(height: 32),
          _isLoading
              ? const CircularProgressIndicator(color: AppColors.primary)
              : CustomButton(
                  text: "Daftar",
                  onPressed: _handleRegister,
                  gradient: AppColors.registerButtonGradient,
                ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: RichText(
              text: const TextSpan(
                text: "Sudah punya akun? ",
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                children: [
                  TextSpan(
                    text: "Masuk di sini",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
