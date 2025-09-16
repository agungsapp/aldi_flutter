import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skripsi App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF0770CD), // Traveloka Blue
              brightness: Brightness.light,
            ).copyWith(
              primary: const Color(0xFF0770CD),
              secondary: const Color(0xFF0099FF),
              surface: Colors.white,
              background: const Color(0xFFF8FAFE),
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0770CD),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0770CD),
            foregroundColor: Colors.white,
            elevation: 8,
            shadowColor: const Color(0xFF0770CD).withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF0770CD),
              brightness: Brightness.dark,
            ).copyWith(
              primary: const Color(0xFF4DA6FF),
              secondary: const Color(0xFF66B3FF),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0770CD), Color(0xFF0099FF), Color(0xFF4DA6FF)],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: const Icon(
                          Icons.badge_outlined,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        "Absensi Digital",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Sistem Modern untuk Era Digital",
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Login Page
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nipController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity, // memastikan tinggi full
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0770CD), Color(0xFFF8FAFE)],
            stops: [0.0, 0.4],
          ),
        ),
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
                          // Logo Section
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.badge_outlined,
                                  size: 60,
                                  color: Color(0xFF0770CD),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Selamat Datang",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0770CD),
                                  ),
                                ),
                                Text(
                                  "Silakan masuk ke akun Anda",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Form Section
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // NIP Field
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFE),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFE1E8ED),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: nipController,
                                    decoration: const InputDecoration(
                                      labelText: "NIP",
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: Color(0xFF0770CD),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(20),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Password Field
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFE),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFE1E8ED),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: _isObscure,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: Color(0xFF0770CD),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: const Color(0xFF0770CD),
                                        ),
                                        onPressed: () => setState(
                                          () => _isObscure = !_isObscure,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(20),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Login Button
                                Container(
                                  width: double.infinity,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF0770CD),
                                        Color(0xFF0099FF),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF0770CD,
                                        ).withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder:
                                              (
                                                context,
                                                animation,
                                                secondaryAnimation,
                                              ) => const MainPage(),
                                          transitionsBuilder:
                                              (
                                                context,
                                                animation,
                                                secondaryAnimation,
                                                child,
                                              ) {
                                                return SlideTransition(
                                                  position: Tween<Offset>(
                                                    begin: const Offset(
                                                      1.0,
                                                      0.0,
                                                    ),
                                                    end: Offset.zero,
                                                  ).animate(animation),
                                                  child: child,
                                                );
                                              },
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: const Text(
                                      "Masuk",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(), // agar konten tetap di tengah jika tinggi layar lebih besar
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
}

// Register Page
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

  final List<String> _divisiList = [
    'Teknologi Informasi',
    'Human Resources',
    'Keuangan',
    'Operasional',
    'Marketing',
    'Administrasi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0770CD), Color(0xFFF8FAFE)],
            stops: [0.0, 0.4],
          ),
        ),
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

                          // Header Section
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.person_add_outlined,
                                  size: 60,
                                  color: Color(0xFF0770CD),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Daftar Akun Baru",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0770CD),
                                  ),
                                ),
                                Text(
                                  "Lengkapi data diri untuk mendaftar",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Form Section
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // NIP Field
                                _buildTextField(
                                  controller: nipController,
                                  labelText: "NIP",
                                  prefixIcon: Icons.badge_outlined,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 16),

                                // Nama Field
                                _buildTextField(
                                  controller: namaController,
                                  labelText: "Nama Lengkap",
                                  prefixIcon: Icons.person_outline,
                                ),
                                const SizedBox(height: 16),

                                // Email Field
                                _buildTextField(
                                  controller: emailController,
                                  labelText: "Email",
                                  prefixIcon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 16),

                                // Divisi Dropdown
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFE),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFE1E8ED),
                                    ),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedDivisi,
                                    decoration: const InputDecoration(
                                      labelText: "Divisi",
                                      prefixIcon: Icon(
                                        Icons.business_outlined,
                                        color: Color(0xFF0770CD),
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
                                      setState(() {
                                        _selectedDivisi = newValue;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Password Field
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFE),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFE1E8ED),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: _isObscurePassword,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: Color(0xFF0770CD),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: const Color(0xFF0770CD),
                                        ),
                                        onPressed: () => setState(
                                          () => _isObscurePassword =
                                              !_isObscurePassword,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(20),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Confirm Password Field
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFE),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFE1E8ED),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: confirmPasswordController,
                                    obscureText: _isObscureConfirm,
                                    decoration: InputDecoration(
                                      labelText: "Konfirmasi Password",
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: Color(0xFF0770CD),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscureConfirm
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: const Color(0xFF0770CD),
                                        ),
                                        onPressed: () => setState(
                                          () => _isObscureConfirm =
                                              !_isObscureConfirm,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(20),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Register Button
                                Container(
                                  width: double.infinity,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF4CAF50),
                                        Color(0xFF66BB6A),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF4CAF50,
                                        ).withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _handleRegister();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: const Text(
                                      "Daftar",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Back to Login Button
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: RichText(
                                    text: const TextSpan(
                                      text: "Sudah punya akun? ",
                                      style: TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "Masuk di sini",
                                          style: TextStyle(
                                            color: Color(0xFF0770CD),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E8ED)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefixIcon, color: const Color(0xFF0770CD)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  void _handleRegister() {
    // Validasi form
    if (nipController.text.isEmpty ||
        namaController.text.isEmpty ||
        emailController.text.isEmpty ||
        _selectedDivisi == null ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      _showSnackBar("Harap lengkapi semua field", Colors.red);
      return;
    }

    // Validasi password match
    if (passwordController.text != confirmPasswordController.text) {
      _showSnackBar("Password dan konfirmasi password tidak sama", Colors.red);
      return;
    }

    // Validasi password length
    if (passwordController.text.length < 6) {
      _showSnackBar("Password minimal 6 karakter", Colors.red);
      return;
    }

    // Simulasi registrasi berhasil
    _showSnackBar("Registrasi berhasil! Silakan login", Colors.green);

    // Kembali ke login page setelah delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

// Main Page with Bottom Navigation
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [AbsensiPage(), MemoPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) =>
              setState(() => _currentIndex = index),
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFF0770CD).withOpacity(0.1),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.camera_alt_outlined),
              selectedIcon: Icon(Icons.camera_alt, color: Color(0xFF0770CD)),
              label: "Absensi",
            ),
            NavigationDestination(
              icon: Icon(Icons.mail_outline),
              selectedIcon: Icon(Icons.mail, color: Color(0xFF0770CD)),
              label: "Memo",
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: Color(0xFF0770CD)),
              label: "Profil",
            ),
          ],
        ),
      ),
    );
  }
}

// Absensi Page
class AbsensiPage extends StatelessWidget {
  const AbsensiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0770CD), Color(0xFFF8FAFE)],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      "Absensi Hari Ini",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Status Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 48,
                                color: Color(0xFF0770CD),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Status Absensi",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Belum Absen Hari Ini",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Absen Buttons
                        _buildAbsenButton(
                          "Absen Masuk",
                          Icons.login,
                          const Color(0xFF4CAF50),
                          () {},
                        ),
                        const SizedBox(height: 20),
                        _buildAbsenButton(
                          "Absen Pulang",
                          Icons.logout,
                          const Color(0xFFFF9800),
                          () {},
                        ),

                        const Spacer(),

                        // History Button
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.history),
                          label: const Text("Lihat Riwayat Absensi"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbsenButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

// Memo Page
class MemoPage extends StatelessWidget {
  const MemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> memos = [
      {
        "title": "Pengumuman Rapat Bulanan",
        "content":
            "Rapat evaluasi bulanan akan dilaksanakan pada tanggal 25 September 2024",
        "date": "15 Sep 2024",
        "priority": "high",
        "icon": Icons.meeting_room,
      },
      {
        "title": "Update Sistem Absensi",
        "content":
            "Sistem absensi telah diperbarui dengan fitur pengenalan wajah",
        "date": "14 Sep 2024",
        "priority": "medium",
        "icon": Icons.system_update,
      },
      {
        "title": "Libur Nasional",
        "content": "Tanggal 17 Agustus 2024 adalah hari libur nasional",
        "date": "10 Sep 2024",
        "priority": "low",
        "icon": Icons.event_available,
      },
      {
        "title": "Pelatihan Karyawan",
        "content": "Pelatihan digital transformation untuk semua karyawan",
        "date": "8 Sep 2024",
        "priority": "medium",
        "icon": Icons.school,
      },
      {
        "title": "Evaluasi Kinerja Q3",
        "content": "Periode evaluasi kinerja triwulan ketiga telah dimulai",
        "date": "5 Sep 2024",
        "priority": "high",
        "icon": Icons.assessment,
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0770CD), Color(0xFFF8FAFE)],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              const Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  "Memo & Pengumuman",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: memos.length,
                    itemBuilder: (context, index) {
                      final memo = memos[index];
                      return _buildMemoCard(memo, context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemoCard(Map<String, dynamic> memo, BuildContext context) {
    Color priorityColor;
    switch (memo['priority']) {
      case 'high':
        priorityColor = const Color(0xFFE53E3E);
        break;
      case 'medium':
        priorityColor = const Color(0xFFFF9800);
        break;
      default:
        priorityColor = const Color(0xFF4CAF50);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0770CD).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    memo['icon'],
                    color: const Color(0xFF0770CD),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              memo['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: priorityColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              memo['priority'].toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: priorityColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        memo['content'],
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        memo['date'],
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Profile Page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0770CD), Color(0xFFF8FAFE)],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Profile
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.3),
                                Colors.white.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Color(0xFF0770CD),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Ahmad Fauzi",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Staff IT Department",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Info Cards
                        _buildInfoCard("NIP", "198901234567890", Icons.badge),
                        const SizedBox(height: 16),
                        _buildInfoCard(
                          "Email",
                          "ahmad.fauzi@company.com",
                          Icons.email,
                        ),
                        const SizedBox(height: 16),
                        _buildInfoCard(
                          "Telepon",
                          "+62 812-3456-7890",
                          Icons.phone,
                        ),
                        const SizedBox(height: 16),
                        _buildInfoCard(
                          "Divisi",
                          "Teknologi Informasi",
                          Icons.business,
                        ),
                        const SizedBox(height: 32),

                        // Stats Row
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                "22",
                                "Hari Hadir",
                                const Color(0xFF4CAF50),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildStatCard(
                                "2",
                                "Hari Izin",
                                const Color(0xFFFF9800),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildStatCard(
                                "0",
                                "Hari Alpha",
                                const Color(0xFFE53E3E),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Action Buttons
                        _buildActionButton(
                          "Edit Profil",
                          Icons.edit_outlined,
                          const Color(0xFF0770CD),
                          () {},
                        ),
                        const SizedBox(height: 16),
                        _buildActionButton(
                          "Ganti Password",
                          Icons.lock_outline,
                          const Color(0xFF6B46C1),
                          () {},
                        ),
                        const SizedBox(height: 16),
                        _buildActionButton(
                          "Pengaturan",
                          Icons.settings_outlined,
                          const Color(0xFF059669),
                          () {},
                        ),
                        const SizedBox(height: 32),

                        // Logout Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFE53E3E), Color(0xFFDC2626)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE53E3E).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: const Text("Konfirmasi Logout"),
                                    content: const Text(
                                      "Apakah Anda yakin ingin keluar dari aplikasi?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("Batal"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder:
                                                  (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                  ) => const LoginPage(),
                                              transitionsBuilder:
                                                  (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child,
                                                  ) {
                                                    return FadeTransition(
                                                      opacity: animation,
                                                      child: child,
                                                    );
                                                  },
                                            ),
                                            (route) => false,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFFE53E3E,
                                          ),
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text("Logout"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.logout, color: Colors.white),
                            label: const Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF0770CD).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF0770CD), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
