import 'person.dart';
import 'book.dart';

class Student extends Person {
  final List<Book> borrowedBooks = [];

  Student({
    required super.id,
    required super.name,
  });

  void borrowBook(Book book) {
    if (!book.isBorrowed) {
      borrowedBooks.add(book);
      book.borrowBook();
    }
  }

  void returnBook(Book book) {
    borrowedBooks.remove(book);
    book.returnBook();
  }

  @override
  String getRole() {
    return 'Sinh viên';
  }

  @override
  String getInfo() {
    return '$name - Đã mượn ${borrowedBooks.length} sách';
  }
}