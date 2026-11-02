
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

const Color primaryColor = Color(0xFF3D5FE6);

class ProfileScreen extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;

  const ProfileScreen({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
  });

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      if (!kIsWeb) {
        await GoogleSignIn.instance.initialize();
        await GoogleSignIn.instance.signOut();
      }

      if (context.mounted) {
        Navigator.of(context).popUntil(
          (route) => route.isFirst,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi đăng xuất: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final name = user?.displayName?.isNotEmpty == true
        ? user!.displayName!
        : user?.email?.split('@').first ?? 'Người dùng';

    final email = user?.email ?? 'Chưa có Email';

    final isGoogle = user?.providerData.any(
          (p) => p.providerId == 'google.com',
        ) ?? false;

    final provider =
        isGoogle ? 'Google' : 'Email/Password';

    final percentage = totalTasks == 0
        ? 0
        : (completedTasks / totalTasks * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 25),

          CircleAvatar(
            radius: 45,
            backgroundColor:
                const Color(0xFFE4EBFF),
            child: Text(
              name[0].toUpperCase(),
              style: const TextStyle(
                fontSize: 34,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 15),

          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            '✓ Đã liên kết tài khoản $provider',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              statCard('$completedTasks', 'Việc đã xong'),
              statCard('$totalTasks', 'Đang có'),
              statCard('$percentage%', 'Hoàn thành'),
            ],
          ),

          const SizedBox(height: 35),

          const Text(
            'Thông tin cá nhân',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Card(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Họ và tên'),
                  subtitle: Text(name),
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(email),
                ),

                const Divider(),

                ListTile(
                  leading:
                      const Icon(Icons.verified_user),
                  title: const Text('Đăng nhập bằng'),
                  subtitle: Text(provider),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          OutlinedButton.icon(
            onPressed: () => logout(context),
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            label: const Text(
              'Đăng xuất',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget statCard(String number, String label) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 4,
          ),
          child: Column(
            children: [
              Text(
                number,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
