
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firebase_service.dart';

class ProfileScreen extends StatefulWidget {
  final int completedTasks;
  final int totalTasks;

  const ProfileScreen({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
  });

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool uploading = false;
  bool loggingOut = false;

  Future<void> changeAvatar() async {
    try {
      if (kIsWeb) {
        throw UnsupportedError(
          'Mẫu upload ảnh hiện hỗ trợ Android/iOS.',
        );
      }

      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (image == null) return;

      setState(() => uploading = true);

      await FirebaseService.uploadAvatar(image.path);

      if (!mounted) return;

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cập nhật ảnh thành công!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Không upload được ảnh: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => uploading = false);
      }
    }
  }

  Future<void> logout() async {
    setState(() => loggingOut = true);

    try {
      await FirebaseAuth.instance.signOut();

      if (!kIsWeb) {
        await GoogleSignIn.instance.initialize();
        await GoogleSignIn.instance.signOut();
      }

      if (!mounted) return;

      Navigator.of(context).popUntil(
        (route) => route.isFirst,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng xuất thất bại: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => loggingOut = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final name = user?.displayName?.isNotEmpty == true
        ? user!.displayName!
        : user?.email?.split('@').first ?? 'Người dùng';

    final email = user?.email ?? 'Chưa có email';

    final provider =
        user?.providerData.any(
              (p) => p.providerId == 'google.com',
            ) == true
            ? 'Google'
            : 'Email/Password';

    final percent = widget.totalTasks == 0
        ? 0
        : (widget.completedTasks /
                widget.totalTasks *
                100)
            .round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),

          Center(
            child: GestureDetector(
              onTap: uploading ? null : changeAvatar,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor:
                        const Color(0xFFE4EBFF),
                    backgroundImage:
                        user?.photoURL != null
                            ? NetworkImage(
                                user!.photoURL!,
                              )
                            : null,
                    child: user?.photoURL == null
                        ? Text(
                            name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 32,
                            ),
                          )
                        : null,
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          Color(0xFF3D5FE6),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          if (uploading)
            const Center(
              child: CircularProgressIndicator(),
            ),

          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '✓ Đã liên kết tài khoản $provider',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 26),

          Row(
            children: [
              statCard(
                '${widget.completedTasks}',
                'Việc đã xong',
              ),
              statCard(
                '${widget.totalTasks}',
                'Tổng số',
              ),
              statCard('$percent%', 'Hoàn thành'),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            'Thông tin tài khoản',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading:
                      const Icon(Icons.person_outline),
                  title: const Text('Họ và tên'),
                  subtitle: Text(name),
                ),
                const Divider(),
                ListTile(
                  leading:
                      const Icon(Icons.email_outlined),
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
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.fingerprint),
                  title: const Text('Firebase UID'),
                  subtitle: Text(user?.uid ?? ''),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          OutlinedButton.icon(
            onPressed: loggingOut ? null : logout,
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            label: Text(
              loggingOut
                  ? 'Đang đăng xuất...'
                  : 'Đăng xuất',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget statCard(String value, String label) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 2,
          ),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
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
