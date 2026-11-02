abstract class Person {
  final int id;
  String name;

  Person({
    required this.id,
    required this.name,
  });

  String getRole();

  String getInfo();
}