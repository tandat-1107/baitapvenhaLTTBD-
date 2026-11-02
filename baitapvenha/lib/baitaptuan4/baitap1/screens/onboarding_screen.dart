import 'package:flutter/material.dart';

import '../models/onboarding_model.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final List<OnboardingModel> onboardingData = [
    OnboardingModel(
      image: 'assets/images/onboarding1.png',
      title: 'Mọi việc, gọn trong một chỗ',
      description:
          'Ghi lại bài tập, việc nhà, lịch hẹn. Không còn quên việc nào.',
      buttonText: 'Tiếp tục',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding2.png',
      title: 'Chia theo Học tập và Cuộc sống',
      description:
          'Mỗi việc có nhóm riêng, nhìn là biết hôm nay cần lo gì.',
      buttonText: 'Tiếp tục',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding3.png',
      title: 'Nhắc đúng lúc',
      description:
          'Bật thông báo để UTH Todo nhắc bạn trước hạn chót.',
      buttonText: 'Bắt đầu ngay',
    ),
  ];

  void nextPage() {
    if (currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      goToHome();
    }
  }

  void skipOnboarding() {
    goToHome();
  }

  void goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.checklist_rounded,
                        color: Color(0xFF3F5FEA),
                        size: 25,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'UTH Todo',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF25335A),
                        ),
                      ),
                    ],
                  ),

                  TextButton(
                    onPressed: skipOnboarding,
                    child: const Text(
                      'Bỏ qua',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return buildPage(
                    onboardingData[index],
                    index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage(
    OnboardingModel data,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          Expanded(
            flex: 5,
            child: Center(
              child: buildIllustration(index),
            ),
          ),

          const SizedBox(height: 30),

          Text(
            data.title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF202020),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            data.description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 28),

          buildIndicator(),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F5FEA),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                data.buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return Row(
      children: List.generate(
        onboardingData.length,
        (index) {
          final bool active = currentPage == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.only(right: 6),
            width: active ? 22 : 7,
            height: 7,
            decoration: BoxDecoration(
              color: active
                  ? const Color(0xFF3F5FEA)
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }

  Widget buildIllustration(int index) {
    if (index == 0) {
      return Container(
        width: 210,
        height: 210,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F3FF),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTaskRow(true),
              const SizedBox(height: 12),
              buildTaskRow(false),
              const SizedBox(height: 12),
              buildTaskRow(false),
            ],
          ),
        ),
      );
    }

    if (index == 1) {
      return Container(
        width: 210,
        height: 210,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F3FF),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCategory(
              'Học tập',
              const Color(0xFFDCE5FF),
              const Color(0xFF3F5FEA),
            ),

            const SizedBox(height: 15),

            buildCategory(
              'Cuộc sống',
              const Color(0xFFFFF1DA),
              Colors.orange,
            ),
          ],
        ),
      );
    }

    return Container(
      width: 210,
      height: 210,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3FF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 38,
                color: Color(0xFF3F5FEA),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Ôn bài Toán lúc 19:00',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTaskRow(bool checked) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            checked
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: checked
                ? const Color(0xFF3F5FEA)
                : Colors.grey.shade400,
            size: 19,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory(
    String title,
    Color backgroundColor,
    Color textColor,
  ) {
    return Container(
      width: double.infinity,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}