import 'dart:async';

import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F5FEA),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.checklist_rounded,
                size: 45,
                color: Color(0xFF3F5FEA),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'UTH Todo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Việc học, việc nhà – gọn gàng mỗi ngày',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const Spacer(),

            Container(
              width: 70,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Phiên bản 2.1.0',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}