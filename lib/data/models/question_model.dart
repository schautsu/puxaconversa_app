// Representação das entidades existentes no banco de dados em Dart.
class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});
}

class Question {
  final int id;
  final String content;
  final int category;

  Question({required this.id, required this.content, required this.category});
}
