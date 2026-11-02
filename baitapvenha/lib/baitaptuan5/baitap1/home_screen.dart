
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_screen.dart';

const Color primaryColor = Color(0xFF3D5FE6);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> tasks = [
    'Tập thể dục 30 phút',
    'Nộp bài tập Lập trình di động',
    'Ôn chương 3 - Cấu trúc dữ liệu',
    'Đi chợ mua đồ cho tuần',
  ];

  final List<bool> completed = [
    true, true, false, false,
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final name = user?.displayName?.isNotEmpty == true
        ? user!.displayName!
        : user?.email?.split('@').first ?? 'Bạn';

    final done = completed.where((e) => e).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chào $name!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(
                    completedTasks: done,
                    totalTasks: tasks.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tiến độ hôm nay',
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 10),

                Text(
                  '$done/${tasks.length} việc',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                LinearProgressIndicator(
                  value: done / tasks.length,
                  minHeight: 8,
                  backgroundColor: Colors.white24,
                  color: Colors.white,
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'Việc hôm nay',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          ...List.generate(tasks.length, (index) {
            return Card(
              color: Colors.white,
              child: CheckboxListTile(
                activeColor: primaryColor,
                value: completed[index],
                title: Text(
                  tasks[index],
                  style: TextStyle(
                    decoration: completed[index]
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    completed[index] = value ?? false;
                  });
                },
              ),
            );
          }),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileScreen(
                  completedTasks: done,
                  totalTasks: tasks.length,
                ),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Danh sách',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}
