import 'package:flutter/material.dart';

void main() {
  runApp(const GradeBookApp());
}

// ==============================
// MODEL STUDENT
// ==============================
class Student {
  final String name;
  final double? score;

  Student({
    required this.name,
    this.score,
  });
}

// ==============================
// APP
// ==============================
class GradeBookApp extends StatelessWidget {
  const GradeBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GradeBookPage(),
    );
  }
}

// ==============================
// PAGE
// ==============================
class GradeBookPage extends StatelessWidget {
  const GradeBookPage({super.key});

  // Hàm xếp loại
  String classifyScore(double score) {
    if (score < 0 || score > 10) {
      return 'Không hợp lệ';
    } else if (score >= 8.0) {
      return 'Giỏi';
    } else if (score >= 6.5) {
      return 'Khá';
    } else if (score >= 5.0) {
      return 'Trung bình';
    } else {
      return 'Yếu';
    }
  }

  Color getRankColor(String rank) {
    if (rank == 'Giỏi') {
      return Colors.green;
    } else if (rank == 'Khá') {
      return Colors.blue;
    } else if (rank == 'Trung bình') {
      return Colors.orange;
    } else if (rank == 'Yếu') {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ==============================
    // DỮ LIỆU
    // ==============================
    final List<Student> students = [
      Student(
        name: 'Nguyễn Văn An',
        score: 9.0,
      ),
      Student(
        name: 'Trần Thị Bình',
        score: 7.2,
      ),
      Student(
        name: 'Lê Minh Chi',
        score: null,
      ),
      Student(
        name: 'Phạm Quốc Dũng',
        score: 4.5,
      ),
      Student(
        name: 'Võ Thanh Em',
        score: 5.8,
      ),
    ];

    // ==============================
    // TÍNH TOÁN BẰNG FOR + IF
    // ==============================
    double totalScore = 0;
    int scoredCount = 0;
    int excellentCount = 0;
    int missingScoreCount = 0;
    double highestScore = 0;

    for (final student in students) {
      if (student.score == null) {
        missingScoreCount++;
      } else {
        totalScore += student.score!;
        scoredCount++;

        if (student.score! >= 8.0) {
          excellentCount++;
        }

        if (student.score! > highestScore) {
          highestScore = student.score!;
        }
      }
    }

    final double average =
        scoredCount > 0 ? totalScore / scoredCount : 0;

    // ==============================
    // TẠO CÁC CARD SINH VIÊN BẰNG FOR
    // ==============================
    final List<Widget> studentCards = [];

    for (final student in students) {
      String rank = '';
      Color rankColor = Colors.grey;

      if (student.score != null) {
        rank = classifyScore(student.score!);
        rankColor = getRankColor(rank);
      }

      studentCards.add(
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tên + xếp loại
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    student.score == null
                        ? 'Chưa có điểm'
                        : rank,
                    style: TextStyle(
                      fontSize: 12,
                      color: student.score == null
                          ? Colors.grey
                          : rankColor,
                    ),
                  ),
                ],
              ),

              // Điểm
              Text(
                student.score?.toStringAsFixed(1) ?? '—',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: student.score == null
                      ? Colors.grey
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ==============================
    // GIAO DIỆN
    // ==============================
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),

      body: Center(
        child: Container(
          width: 360,
          height: 740,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(48),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),

          padding: const EdgeInsets.all(10),

          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5FA),
              borderRadius: BorderRadius.circular(38),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(38),

              child: Column(
                children: [
                  // ==============================
                  // STATUS BAR
                  // ==============================
                  Container(
                    color: const Color(0xFF35568D),
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      12,
                      16,
                      8,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '9:41',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.signal_cellular_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.wifi,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.battery_full,
                              color: Colors.white,
                              size: 17,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ==============================
                  // APP BAR
                  // ==============================
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF35568D),
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      14,
                    ),
                    child: const Text(
                      'Bảng điểm lớp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // ==============================
                          // CARD THỐNG KÊ
                          // ==============================
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF35568D),
                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Điểm trung bình lớp',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  average.toStringAsFixed(2),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 14),

                                const Divider(
                                  color: Colors.white24,
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildStat(
                                      'Giỏi',
                                      '$excellentCount',
                                    ),
                                    buildStat(
                                      'Chưa có điểm',
                                      '$missingScoreCount',
                                    ),
                                    buildStat(
                                      'Cao nhất',
                                      highestScore.toStringAsFixed(1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'DANH SÁCH · ${students.length} SINH VIÊN',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: studentCards,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Thanh home giả
                  Container(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                    ),
                    child: Container(
                      width: 100,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStat(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}