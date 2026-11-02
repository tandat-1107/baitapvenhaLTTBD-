class Book {
  final int id;
  String _title;
  bool _isBorrowed = false;

  Book({
    required this.id,
    required String title,
  }) : _title = title;

  // Encapsulation - đóng gói
  String get title => _title;

  bool get isBorrowed => _isBorrowed;

  void changeTitle(String newTitle) {
    if (newTitle.trim().isNotEmpty) {
      _title = newTitle;
    }
  }

  void borrowBook() {
    _isBorrowed = true;
  }

  void returnBook() {
    _isBorrowed = false;
  }
}