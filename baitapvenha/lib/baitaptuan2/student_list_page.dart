import 'package:flutter/material.dart';

void main() {
  runApp(const StudentApp());
}

// ==============================
// MODEL STUDENT
// ==============================
class Student {
  final String name;
  final String? email;
  final String? phone;

  Student({
    required this.name,
    this.email,
    this.phone,
  });
}

// ==============================
// APP
// ==============================
class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentListPage(),
    );
  }
}

// ==============================
// STUDENT LIST PAGE
// ==============================
class StudentListPage extends StatelessWidget {
  const StudentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Student> students = [
      Student(
        name: 'Nguyễn Văn An',
        email: 'an@sv.edu.vn',
        phone: '0901 234 567',
      ),
      Student(
        name: 'Trần Thị Bình',
        email: null,
        phone: '0912 888 999',
      ),
      Student(
        name: 'Lê Minh Chi',
        email: 'chi@sv.edu.vn',
        phone: null,
      ),
      Student(
        name: 'Phạm Quốc Dũng',
        email: null,
        phone: null,
      ),
      Student(
        name: 'Võ Thanh Em',
        email: 'em@sv.edu.vn',
        phone: '0933 111 222',
      ),
    ];

    // Đếm số sinh viên thiếu email
    int missingEmailCount = 0;

    for (final student in students) {
      if (student.email == null) {
        missingEmailCount++;
      }
    }

    // Dùng for tạo các thẻ sinh viên
    final List<Widget> studentCards = [];

    for (final student in students) {
      studentCards.add(
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                student.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 5),

              Row(
                children: [
                  const Text(
                    'Email: ',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    student.email ?? 'Chưa cập nhật',
                    style: TextStyle(
                      fontSize: 13,
                      color: student.email == null
                          ? Colors.red
                          : Colors.grey,
                      fontStyle: student.email == null
                          ? FontStyle.italic
                          : FontStyle.normal,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 3),

              Row(
                children: [
                  const Text(
                    'SĐT: ',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    student.phone ?? 'Chưa cập nhật',
                    style: TextStyle(
                      fontSize: 13,
                      color: student.phone == null
                          ? Colors.red
                          : Colors.grey,
                      fontStyle: student.phone == null
                          ? FontStyle.italic
                          : FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),

      body: Center(
        child: Container(
          width: 360,
          height: 740,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(45),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 18,
                spreadRadius: 3,
                offset: Offset(0, 8),
              ),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.all(10),

            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6FA),
                borderRadius: BorderRadius.circular(36),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(36),

                child: Column(
                  children: [
                    // ==============================
                    // THANH TRẠNG THÁI GIẢ
                    // ==============================
                    Container(
                      color: const Color(0xFF315A91),
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
                      color: const Color(0xFF315A91),
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        8,
                        16,
                        14,
                      ),
                      child: const Text(
                        'Danh sách sinh viên',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // ==============================
                    // BODY
                    // ==============================
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),

                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: studentCards,
                                ),
                              ),
                            ),

                            // ==============================
                            // THỐNG KÊ CUỐI
                            // ==============================
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 13,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE6EEFA),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tổng: ${students.length} sinh viên',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF315A91),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      const Text(
                                        'Thiếu email: ',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        '$missingEmailCount',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Thanh home giả phía dưới
                    Container(
                      color: const Color(0xFFF5F6FA),
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 8,
                      ),
                      child: Center(
                        child: Container(
                          width: 110,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}