
import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/library_manager.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final LibraryManager manager = LibraryManager();

  final TextEditingController idController =
      TextEditingController();

  final TextEditingController titleController =
      TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    titleController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void addBook() {
    final int? id = int.tryParse(idController.text.trim());
    final String title = titleController.text.trim();

    if (id == null || id <= 0 || title.isEmpty) {
      showMessage('Vui lòng nhập ID hợp lệ và tên sách!');
      return;
    }

    final bool success = manager.addBook(
      Book(id: id, title: title),
    );

    if (success) {
      setState(() {
        idController.clear();
        titleController.clear();
      });

      showMessage('Thêm sách thành công!');
    } else {
      showMessage('ID đã tồn tại hoặc tên sách không hợp lệ!');
    }
  }

  void borrowBook(int id) {
    final success = manager.borrowBook(id);

    setState(() {});

    showMessage(
      success
          ? 'Mượn sách thành công!'
          : 'Không thể mượn sách này!',
    );
  }

  void returnBook(int id) {
    final success = manager.returnBook(id);

    setState(() {});

    showMessage(
      success
          ? 'Trả sách thành công!'
          : 'Không thể trả sách này!',
    );
  }

  void deleteBook(int id) {
    final success = manager.removeBook(id);

    setState(() {});

    showMessage(
      success
          ? 'Xóa sách thành công!'
          : 'Không thể xóa sách đang được mượn!',
    );
  }

  void editBook(Book book) {
    final controller = TextEditingController(
      text: book.title,
    );

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Chỉnh sửa tên sách'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Tên sách mới',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTitle = controller.text.trim();

                if (newTitle.isEmpty) {
                  return;
                }

                setState(() {
                  manager.updateBook(book.id, newTitle);
                });

                Navigator.pop(dialogContext);
                showMessage('Cập nhật thành công!');
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  Widget buildStatistic(
    String label,
    int value,
    Color color,
  ) {
    return Expanded(
      child: Card(
        color: color.withValues(alpha: 0.10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                '$value',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBookCard(Book book) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.menu_book,
                  color: Colors.indigo,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Sửa tên',
                  icon: const Icon(Icons.edit),
                  onPressed: () => editBook(book),
                ),
                IconButton(
                  tooltip: 'Xóa',
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () => deleteBook(book.id),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Mã sách: ${book.id}'),
            const SizedBox(height: 4),
            Text(
              book.isBorrowed
                  ? 'Trạng thái: Đang được mượn'
                  : 'Trạng thái: Có sẵn',
              style: TextStyle(
                color: book.isBorrowed
                    ? Colors.orange
                    : Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (book.isBorrowed) {
                    returnBook(book.id);
                  } else {
                    borrowBook(book.id);
                  }
                },
                icon: Icon(
                  book.isBorrowed
                      ? Icons.assignment_return
                      : Icons.bookmark_add,
                ),
                label: Text(
                  book.isBorrowed ? 'Trả sách' : 'Mượn sách',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý thư viện'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thống kê thư viện',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  buildStatistic(
                    'Tổng sách',
                    manager.totalBooks,
                    Colors.indigo,
                  ),
                  buildStatistic(
                    'Có sẵn',
                    manager.availableBooks,
                    Colors.green,
                  ),
                  buildStatistic(
                    'Đang mượn',
                    manager.borrowedBooks,
                    Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Thêm sách mới',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Mã sách',
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Tên sách',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: addBook,
                  icon: const Icon(Icons.add),
                  label: const Text('Thêm sách'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Danh sách sách',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              if (manager.books.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Chưa có sách nào trong thư viện.',
                    ),
                  ),
                )
              else
                ...manager.books.map(buildBookCard),
            ],
          ),
        ),
      ),
    );
  }
}
