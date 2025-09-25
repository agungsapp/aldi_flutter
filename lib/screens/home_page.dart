import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  // Data yang akan diisi dari API
  String employeeName = "Loading...";
  String position = "Loading...";
  double currentScore = 0.0;
  int weekNumber = 0;
  String lastEvaluationDate = "";
  List<Map<String, dynamic>> performanceCategories = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Ambil token dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token tidak ditemukan. Silakan login kembali.');
      }

      final response = await http.get(
        Uri.parse('http://dika.sehatea.my.id/api/evaluasi-score'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Data user
          employeeName = data['user']['name'];
          position = _getPositionDisplay(data['user']['position']);

          // Data evaluasi terbaru
          if (data['evaluasi'].isNotEmpty) {
            final latestEvaluation = data['evaluasi'][0];
            currentScore = double.parse(
              latestEvaluation['total_score'].toString(),
            );

            // Hitung minggu dari tanggal
            DateTime weekStart = DateTime.parse(latestEvaluation['week_start']);
            weekNumber = _getWeekNumber(weekStart);
            lastEvaluationDate = _formatDate(weekStart);

            // Transform evaluasi answers ke performance categories
            performanceCategories = [];
            for (var answer in latestEvaluation['evaluasi_ans']) {
              String categoryName = _getCategoryName(
                answer['question_snapshot'],
              );
              IconData icon = _getCategoryIcon(categoryName);

              performanceCategories.add({
                'name': categoryName,
                'score': answer['score'].toDouble(),
                'icon': icon,
              });
            }
          } else {
            // Jika belum ada evaluasi → tampilkan empty state
            currentScore = -1; // pakai -1 supaya gampang cek di UI
            performanceCategories = [];
          }

          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        // Set default values jika error
        employeeName = "John Doe";
        position = "Staff IT";
        currentScore = 8.5;
        weekNumber = 38;
        lastEvaluationDate = "18 Sep 2024";
        performanceCategories = [
          {'name': 'Sikap', 'score': 8.0, 'icon': Icons.sentiment_satisfied},
          {'name': 'Disiplin', 'score': 9.0, 'icon': Icons.access_time},
          {
            'name': 'Kreativitas',
            'score': 8.5,
            'icon': Icons.lightbulb_outline,
          },
          {
            'name': 'Komunikasi',
            'score': 8.0,
            'icon': Icons.chat_bubble_outline,
          },
        ];
      });
      print('Error loading data: $e');
    }
  }

  String _getPositionDisplay(String pos) {
    switch (pos.toLowerCase()) {
      case 'staff':
        return 'Staff';
      case 'manager':
        return 'Manager';
      case 'supervisor':
        return 'Supervisor';
      default:
        return pos;
    }
  }

  int _getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return ((daysSinceFirstDay + firstDayOfYear.weekday) / 7).ceil();
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _getCategoryName(String questionSnapshot) {
    final question = questionSnapshot.toLowerCase();
    if (question.contains('sikap')) {
      return 'Sikap';
    } else if (question.contains('disiplin')) {
      return 'Disiplin';
    } else if (question.contains('kreativitas')) {
      return 'Kreativitas';
    } else if (question.contains('komunikasi')) {
      return 'Komunikasi';
    } else {
      return 'Lainnya';
    }
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'sikap':
        return Icons.sentiment_satisfied;
      case 'disiplin':
        return Icons.access_time;
      case 'kreativitas':
        return Icons.lightbulb_outline;
      case 'komunikasi':
        return Icons.chat_bubble_outline;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF2563EB)),
              )
            : currentScore == -1
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Belum ada evaluasi untuk Anda",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildCurrentScoreCard(),
                    const SizedBox(height: 20),
                    _buildPerformanceCategories(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                employeeName.split(' ').map((e) => e[0]).join(''),
                style: const TextStyle(
                  color: Color(0xFF2563EB),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selamat Datang,',
                  style: TextStyle(
                    color: Color(0xBFFFFFFF), // Colors.white70 equivalent
                    fontSize: 14,
                  ),
                ),
                Text(
                  employeeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  position,
                  style: const TextStyle(
                    color: Color(0xE6FFFFFF), // Colors.white90 equivalent
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentScoreCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Evaluasi Minggu Ini',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Minggu ke-$weekNumber • $lastEvaluationDate',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getScoreColor(currentScore).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getScoreLabel(currentScore),
                  style: TextStyle(
                    fontSize: 12,
                    color: _getScoreColor(currentScore),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currentScore.toString(),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _getScoreColor(currentScore),
                  height: 1,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  ' / 10',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFFF3F4F6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: currentScore / 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: _getScoreColor(currentScore),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performa per Aspek',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: performanceCategories.length,
          itemBuilder: (context, index) {
            final category = performanceCategories[index];
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getScoreColor(
                        category['score'],
                      ).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      category['icon'],
                      size: 28,
                      color: _getScoreColor(category['score']),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['score'].toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getScoreColor(category['score']),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 8.5) return const Color(0xFF10B981);
    if (score >= 7.0) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  String _getScoreLabel(double score) {
    if (score >= 8.5) return 'Sangat Baik';
    if (score >= 7.0) return 'Baik';
    if (score >= 6.0) return 'Cukup';
    return 'Perlu Perbaikan';
  }
}
