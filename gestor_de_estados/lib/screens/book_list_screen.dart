import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestor_de_estados/data/session.dart';
import 'package:gestor_de_estados/providers/book_provider.dart';
import 'package:gestor_de_estados/widgets/book_view.dart';
import 'package:go_router/go_router.dart';

class BookListScreen extends ConsumerWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(bookListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Library - ${currentUser?.name ?? 'Invitado'}',
          style: const TextStyle(color: Color.fromARGB(255, 227, 171, 0)),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 223, 163),
        shadowColor: const Color.fromARGB(255, 244, 223, 163),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 227, 171, 0)),
        actions: [
          IconButton(
            onPressed: () {
              currentUser = null;
              context.go('/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return BookItem(
            book: book,
            onTap: () => context.push('/books/${book.id}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/books/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
