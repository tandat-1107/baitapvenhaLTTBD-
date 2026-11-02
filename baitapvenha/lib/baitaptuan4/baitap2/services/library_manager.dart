
import '../models/book.dart';

class LibraryManager {
  final List<Book> _books = [];

  // Danh sách sách
  List<Book> get books => List.unmodifiable(_books);

  // Thêm sách
  bool addBook(Book book) {
    if (book.title.trim().isEmpty) {
      return false;
    }

    if (_books.any((b) => b.id == book.id)) {
      return false;
    }

    _books.add(book);
    return true;
  }

  // Tìm sách
  Book? findBook(int id) {
    for (final book in _books) {
      if (book.id == id) {
        return book;
      }
    }
    return null;
  }

  // Mượn sách
  bool borrowBook(int id) {
    final book = findBook(id);

    if (book == null || book.isBorrowed) {
      return false;
    }

    book.borrowBook();
    return true;
  }

  // Trả sách
  bool returnBook(int id) {
    final book = findBook(id);

    if (book == null || !book.isBorrowed) {
      return false;
    }

    book.returnBook();
    return true;
  }

  // Cập nhật tên sách
  bool updateBook(int id, String newTitle) {
    final book = findBook(id);

    if (book == null || newTitle.trim().isEmpty) {
      return false;
    }

    book.changeTitle(newTitle);
    return true;
  }

  // Xóa sách
  bool removeBook(int id) {
    final book = findBook(id);

    if (book == null || book.isBorrowed) {
      return false;
    }

    _books.remove(book);
    return true;
  }

  // Thống kê tổng số sách
  int get totalBooks => _books.length;

  // Số sách đang được mượn
  int get borrowedBooks =>
      _books.where((book) => book.isBorrowed).length;

  // Số sách còn lại
  int get availableBooks =>
      totalBooks - borrowedBooks;
}
