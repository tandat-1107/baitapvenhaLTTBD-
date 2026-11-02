import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

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
      backgroundColor: const Color(0xFFEFEFEF),

      body: Center(
        child: Container(
          width: 430,
          height: 820,

          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(60),
          ),

          padding: const EdgeInsets.all(12),

          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(48),
            ),

            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 25,
            ),

            child: Column(
              children: [
                // Nút Back và QR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 22,
                      ),
                    ),

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green.shade200,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.qr_code_scanner,
                        color: Colors.green,
                        size: 25,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 155),

                // Ảnh đại diện
                Container(
                  padding: const EdgeInsets.all(5),

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

                const SizedBox(height: 28),

                // Tên
                const Text(
                  'NGUYEN TAN DAT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 12),

                // MSSV
                const Text(
                  '052206000886',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 25),

                // Nội dung phía dưới
                const Text(
                  'Mong muốn và định hướng của.Bạn là gì\n'
                  'sau khi học xong môn học là gì?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.5,
                    color: Colors.black87,
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