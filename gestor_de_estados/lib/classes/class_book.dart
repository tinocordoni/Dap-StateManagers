class Book {
  final String id;
  final String name;
  final String author;
  final String desc;
  final int year;
  final String cover;

  const Book({
    required this.id,
    required this.name,
    required this.author,
    required this.desc,
    required this.year,
    required this.cover,
  });

  Book copyWith({
    String? id,
    String? name,
    String? author,
    String? desc,
    int? year,
    String? cover,
  }) {
    return Book(
      id: id ?? this.id,
      name: name ?? this.name,
      author: author ?? this.author,
      desc: desc ?? this.desc,
      year: year ?? this.year,
      cover: cover ?? this.cover,
    );
  }
}
