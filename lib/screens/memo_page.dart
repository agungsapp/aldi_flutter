import 'package:flutter/material.dart';

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
