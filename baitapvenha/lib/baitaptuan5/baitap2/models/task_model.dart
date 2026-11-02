
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String category;
  final String time;
  final bool completed;

  const TaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.time,
    required this.completed,
  });

  factory TaskModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    return TaskModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      category: data['category'] as String? ?? 'Cá nhân',
      time: data['time'] as String? ?? '',
      completed: data['completed'] as bool? ?? false,
    );
  }
}
