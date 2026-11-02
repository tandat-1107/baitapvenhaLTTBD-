import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),

      body: Center(
        child: Container(
          width: 340,
          height: 700,

          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(48),

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
                color: Colors.white,
                borderRadius: BorderRadius.circular(38),
              ),

              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),

                  child: Column(
                    children: [
                      // ============================
                      // THANH TRÊN
                      // ============================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          // Nút quay lại
                          Container(
                            width: 40,
                            height: 40,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),

                          // Nút QR
                          Container(
                            width: 40,
                            height: 40,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.green.shade100,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: const Icon(
                              Icons.qr_code_scanner,
                              size: 20,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // ============================
                      // ẢNH ĐẠI DIỆN
                      // ============================
                      Container(
                        padding: const EdgeInsets.all(4),

                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFDCEEFF),
                        ),

                        child: const CircleAvatar(
                          radius: 58,

                          backgroundImage: AssetImage(
                            'assets/avatar.jpg',
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ============================
                      // HỌ VÀ TÊN
                      // ============================
                      const Text(
                        'NGUYEN TAN DAT',

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // ============================
                      // MSSV
                      // ============================
                      const Text(
                        '052206000886',

                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),

                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}