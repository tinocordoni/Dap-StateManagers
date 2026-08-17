import 'package:flutter/material.dart';
import 'package:gestor_de_estados/classes/class_book.dart';

class BookItem extends StatelessWidget {
  const BookItem({super.key, required this.book, required this.onTap});

  final Book book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: SizedBox(
          width: 54,
          height: 72,
          child: Image.network(
            book.cover,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const ColoredBox(
              color: Color(0xFFE0E0E0),
              child: Icon(Icons.menu_book),
            ),
          ),
        ),
        title: Text(book.name),
        subtitle: Text('${book.author} · ${book.year}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
