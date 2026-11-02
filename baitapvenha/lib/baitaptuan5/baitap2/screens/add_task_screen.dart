
import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../services/firebase_service.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskModel? task;

  const AddTaskScreen({
    super.key,
    this.task,
  });

  @override
  State<AddTaskScreen> createState() =>
      _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final timeController = TextEditingController();

  String category = 'Học tập';
  bool saving = false;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      titleController.text = widget.task!.title;
      timeController.text = widget.task!.time;
      category = widget.task!.category;
    }
  }

  Future<void> saveTask() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() => saving = true);

    try {
      if (widget.task == null) {
        await FirebaseService.addTask(
          title: titleController.text.trim(),
          category: category,
          time: timeController.text.trim(),
        );
      } else {
        await FirebaseService.updateTask(
          widget.task!.id,
          title: titleController.text.trim(),
          category: category,
          time: timeController.text.trim(),
        );
      }

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Không thể lưu công việc: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => saving = false);
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Sửa công việc' : 'Thêm công việc',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              const Icon(
                Icons.task_alt,
                color: Color(0xFF3D5FE6),
                size: 65,
              ),

              const SizedBox(height: 25),

              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Tên công việc',
                  hintText: 'Ví dụ: Học Flutter',
                  prefixIcon: Icon(Icons.edit_note),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Vui lòng nhập tên công việc';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: category,
                decoration: const InputDecoration(
                  labelText: 'Danh mục',
                  prefixIcon:
                      Icon(Icons.category_outlined),
                  border: OutlineInputBorder(),
                ),
                items: [
                  ...{'Học tập', 'Cuộc sống', 'Cá nhân',
                    category}
                      .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    category = value ?? 'Học tập';
                  });
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: timeController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Giờ thực hiện',
                  hintText: 'Chọn giờ',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  final selected = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (selected == null) return;

                  timeController.text =
                      '${selected.hour.toString().padLeft(2, '0')}:'
                      '${selected.minute.toString().padLeft(2, '0')}';
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: saving ? null : saveTask,
                  icon: const Icon(Icons.save),
                  label: Text(
                    saving
                        ? 'Đang lưu...'
                        : isEdit
                            ? 'Cập nhật công việc'
                            : 'Thêm công việc',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF3D5FE6),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
