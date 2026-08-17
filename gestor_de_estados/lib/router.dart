import 'package:gestor_de_estados/screens/book_detail_screen.dart';
import 'package:gestor_de_estados/screens/book_form_screen.dart';
import 'package:gestor_de_estados/screens/book_list_screen.dart';
import 'package:gestor_de_estados/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/books',
      builder: (context, state) => const BookListScreen(),
    ),
    GoRoute(
      path: '/books/new',
      builder: (context, state) => const BookFormScreen(),
    ),
    GoRoute(
      path: '/books/:id/edit',
      builder: (context, state) =>
          BookFormScreen(bookId: state.pathParameters['id']),
    ),
    GoRoute(
      path: '/books/:id',
      builder: (context, state) =>
          BookDetailScreen(bookId: state.pathParameters['id']!),
    ),
  ],
);
