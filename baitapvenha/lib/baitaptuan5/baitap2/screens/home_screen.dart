
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';
import '../services/firebase_service.dart';
import 'add_task_screen.dart';
import 'profile_screen.dart';

const Color blue = Color(0xFF3D5FE6);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String welcomeMessage = 'Đã hơn nửa chặng, cố lên!';
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    initializeServices();
  }

  Future<void> initializeServices() async {
    final message =
        await FirebaseService.getWelcomeMessage();

    if (mounted) {
      setState(() => welcomeMessage = message);
    }

    await FirebaseService.setupMessaging();
    await FirebaseService.logEvent('home_opened');
  }

  void showError(Object e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lỗi: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void openTask([TaskModel? task]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddTaskScreen(task: task),
      ),
    );
  }

  void openProfile(int done, int total) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          completedTasks: done,
          totalTasks: total,
        ),
      ),
    );
  }

  Future<void> deleteTask(TaskModel task) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Xóa công việc'),
        content: Text(
          'Bạn muốn xóa "${task.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, true),
            child: const Text(
              'Xóa',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await FirebaseService.deleteTask(task.id);
    } catch (e) {
      showError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final name =
        user?.displayName?.isNotEmpty == true
            ? user!.displayName!
            : user?.email?.split('@').first ?? 'Bạn';

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<TaskModel>>(
          stream: FirebaseService.getTasks(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Không tải được Firestore:\n'
                    '${snapshot.error}\n\n'
                    'Hãy kiểm tra Firestore Rules và Internet.',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final tasks = snapshot.data!;
            final done =
                tasks.where((t) => t.completed).length;
            final total = tasks.length;
            final progress =
                total == 0 ? 0.0 : done / total;

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      // HEADER
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                openProfile(done, total),
                            child: CircleAvatar(
                              radius: 23,
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
                                      style:
                                          const TextStyle(
                                        color: blue,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hôm nay',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Chào $name!',
                                  overflow:
                                      TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Thông báo đẩy được '
                                    'quản lý bởi Firebase Messaging.',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.notifications_none,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // TIẾN ĐỘ
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: blue,
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tiến độ hôm nay',
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Text(
                                  '$done/$total việc',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${(progress * 100).round()}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            LinearProgressIndicator(
                              value: progress,
                              minHeight: 8,
                              color: Colors.white,
                              backgroundColor:
                                  Colors.white24,
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              welcomeMessage,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // DANH MỤC
                      Row(
                        children: [
                          Expanded(
                            child: categoryCard(
                              Icons.school_outlined,
                              'Học tập',
                              tasks
                                  .where((t) =>
                                      t.category == 'Học tập' &&
                                      !t.completed)
                                  .length,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: categoryCard(
                              Icons.home_outlined,
                              'Cuộc sống',
                              tasks
                                  .where((t) =>
                                      t.category == 'Cuộc sống' &&
                                      !t.completed)
                                  .length,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 26),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Việc hôm nay',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$total công việc',
                            style:
                                const TextStyle(color: blue),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      if (tasks.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            'Chưa có công việc nào.\n'
                            'Nhấn nút + để thêm công việc!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),

                      ...tasks.map(
                        (task) => Card(
                          color: Colors.white,
                          elevation: 0,
                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: CheckboxListTile(
                            value: task.completed,
                            activeColor: blue,
                            controlAffinity:
                                ListTileControlAffinity
                                    .leading,
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.completed
                                    ? TextDecoration
                                        .lineThrough
                                    : null,
                                color: task.completed
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              '${task.category} · ${task.time}',
                            ),
                            secondary: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  openTask(task);
                                } else if (value == 'delete') {
                                  deleteTask(task);
                                }
                              },
                              itemBuilder: (_) => const [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Sửa'),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Xóa'),
                                ),
                              ],
                            ),
                            onChanged: (value) async {
                              try {
                                await FirebaseService.toggleTask(
                                  task.id,
                                  value ?? false,
                                );
                              } catch (e) {
                                showError(e);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                NavigationBar(
                  selectedIndex: currentTab,
                  onDestinationSelected: (index) {
                    if (index == 3) {
                      openProfile(done, total);
                    } else {
                      setState(() => currentTab = index);
                    }
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      label: 'Trang chủ',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.list_alt_outlined),
                      label: 'Danh sách',
                    ),
                    NavigationDestination(
                      icon: Icon(
                          Icons.notifications_none),
                      label: 'Thông báo',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.settings_outlined),
                      label: 'Cài đặt',
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        foregroundColor: Colors.white,
        onPressed: () => openTask(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget categoryCard(
    IconData icon,
    String name,
    int count,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(icon, color: blue, size: 28),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '$count việc còn lại',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
