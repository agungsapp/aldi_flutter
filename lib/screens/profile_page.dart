import 'package:flutter/material.dart';
import 'package:notifikasi/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final data = await authService.getUserProfile();
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  void _showEditProfileDialog() {
    if (userData == null) return;

    final nameController = TextEditingController(text: userData!['name']);
    final emailController = TextEditingController(text: userData!['email']);
    final positionController = TextEditingController(
      text: userData!['position'] ?? '',
    );
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Profil"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nama"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: positionController,
                decoration: const InputDecoration(labelText: "Jabatan"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password Baru"),
                obscureText: true,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: "Konfirmasi Password",
                ),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              final success = await authService.updateUserProfile({
                'id': userData!['id'],
                'name': nameController.text,
                'email': emailController.text,
                'position': positionController.text,
                'password': passwordController.text,
                'password_confirmation': confirmPasswordController.text,
              });

              Navigator.pop(context);

              if (success) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profil berhasil diperbarui")),
                  );
                }
                _loadUserProfile();
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Gagal update profil")),
                  );
                }
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi Logout"),
        content: const Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53E3E),
            ),
            onPressed: () async {
              await authService.logout();
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (userData == null) {
      return const Scaffold(body: Center(child: Text("Gagal memuat profil")));
    }

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
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Color(0xFF0770CD),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                userData!['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                userData!['position'] ?? "-",
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.email,
                          color: Color(0xFF0770CD),
                        ),
                        title: const Text("Email"),
                        subtitle: Text(userData!['email']),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.badge,
                          color: Color(0xFF0770CD),
                        ),
                        title: const Text("Role"),
                        subtitle: Text(userData!['role']),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0770CD),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: _showEditProfileDialog,
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Edit Profil",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE53E3E),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: _showLogoutDialog,
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
