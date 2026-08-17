import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestor_de_estados/classes/class_book.dart';
import 'package:gestor_de_estados/providers/book_provider.dart';
import 'package:go_router/go_router.dart';

class BookDetailScreen extends ConsumerWidget {
  const BookDetailScreen({super.key, required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(bookListProvider);
    Book? selectedBook;

    for (final book in books) {
      if (book.id == bookId) {
        selectedBook = book;
      }
    }

    if (selectedBook == null) {
      return const Scaffold(
        body: Center(child: Text('No se encontró el libro')),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 223, 163),
      body: _BookDetailView(book: selectedBook),
    );
  }
}

class _BookDetailView extends ConsumerWidget {
  const _BookDetailView({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 223, 163),
      appBar: AppBar(
        title: Text(
          'Book details: ${book.name}',
          style: const TextStyle(color: Color.fromARGB(255, 227, 171, 0)),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 223, 163),
        shadowColor: const Color.fromARGB(255, 244, 223, 163),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 227, 171, 0)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      book.cover,
                      width: 300,
                      height: 500,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          width: 300,
                          height: 500,
                          child: ColoredBox(
                            color: Color.fromARGB(255, 220, 205, 160),
                            child: Icon(Icons.menu_book, size: 100),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book.name, style: const TextStyle(fontSize: 40)),
                        Text(
                          book.author,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 68, 68, 68),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${book.year}',
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(height: 50),
                        const Text(
                          'Descripción:',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          book.desc,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 104, 104, 104),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  227,
                                  171,
                                  0,
                                ),
                              ),
                              onPressed: () {
                                context.push('/books/${book.id}/edit');
                              },
                              icon: const Icon(Icons.edit),
                              label: const Text('Editar'),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton.icon(
                              onPressed: () async {
                                final delete = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Eliminar libro'),
                                    content: Text(
                                      '¿Desea eliminar ${book.name}?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: const Text('Eliminar'),
                                      ),
                                    ],
                                  ),
                                );

                                if (delete == true) {
                                  ref
                                      .read(bookListProvider.notifier)
                                      .deleteBook(book.id);
                                  if (context.mounted) {
                                    context.go('/books');
                                  }
                                }
                              },
                              icon: const Icon(Icons.delete),
                              label: const Text('Eliminar'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 200),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
