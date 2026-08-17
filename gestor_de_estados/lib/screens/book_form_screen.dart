import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestor_de_estados/classes/class_book.dart';
import 'package:gestor_de_estados/providers/book_provider.dart';
import 'package:go_router/go_router.dart';

class BookFormScreen extends ConsumerStatefulWidget {
  final String? bookId;

  const BookFormScreen({super.key, this.bookId});

  @override
  ConsumerState<BookFormScreen> createState() => _BookFormScreenState();
}

class _BookFormScreenState extends ConsumerState<BookFormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController coverController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Book? bookToEdit;

  @override
  void initState() {
    super.initState();

    if (widget.bookId != null) {
      final books = ref.read(bookListProvider);

      for (final book in books) {
        if (book.id == widget.bookId) {
          bookToEdit = book;
        }
      }

      if (bookToEdit != null) {
        nameController.text = bookToEdit!.name;
        authorController.text = bookToEdit!.author;
        yearController.text = bookToEdit!.year.toString();
        coverController.text = bookToEdit!.cover;
        descriptionController.text = bookToEdit!.desc;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool editing = bookToEdit != null;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 223, 163),
      appBar: AppBar(
        title: Text(editing ? 'Editar libro' : 'Crear libro'),
        backgroundColor: const Color.fromARGB(255, 244, 223, 163),
        foregroundColor: const Color.fromARGB(255, 227, 171, 0),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),

        children: [
          SizedBox(
            width: 500,
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 500,
            child: TextField(
              controller: authorController,
              decoration: const InputDecoration(
                labelText: 'Autor',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 500,
            child: TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Año de publicación',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 500,
            child: TextField(
              controller: coverController,
              decoration: const InputDecoration(
                labelText: 'URL de la portada',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 500,
            child: TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 227, 171, 0),
            ),
            onPressed: () {
              final name = nameController.text;
              final author = authorController.text;
              final year = int.tryParse(yearController.text);
              final cover = coverController.text;
              final description = descriptionController.text;

              if (name.isEmpty ||
                  author.isEmpty ||
                  yearController.text.isEmpty ||
                  cover.isEmpty ||
                  description.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Complete todos los campos')),
                );
              } else if (year == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ingrese un año válido')),
                );
              } else {
                late Book savedBook;

                if (editing) {
                  savedBook = bookToEdit!.copyWith(
                    name: name,
                    author: author,
                    year: year,
                    cover: cover,
                    desc: description,
                  );
                  ref.read(bookListProvider.notifier).updateBook(savedBook);
                } else {
                  savedBook = Book(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                    author: author,
                    year: year,
                    cover: cover,
                    desc: description,
                  );
                  ref.read(bookListProvider.notifier).addBook(savedBook);
                }

                context.go('/books/${savedBook.id}');
              }
            },
            child: Text(
              editing ? 'Guardar cambios' : 'Crear libro',
              style: const TextStyle(color: Color.fromARGB(255, 244, 223, 163)),
            ),
          ),
        ],
      ),
    );
  }
}
