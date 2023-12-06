// DATA
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class Book {
  const Book(this.id, this.title, this.author);

  final int id;
  final String title;
  final String author;
}

const List<Book> books = [
  Book(1, 'Stranger in a Strange Land', 'Robert A. Heinlein'),
  Book(2, 'Foundation', 'Isaac Asimov'),
  Book(3, 'Fahrenheit 451', 'Ray Bradbury'),
];

// SCREENS
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.beamToNamed('/books'),
          child: const Text('See books'),
        ),
      ),
    );
  }
}

class BooksScreen extends StatelessWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: ListView(
        children: books
            .map(
              (book) => ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
                onTap: () => context.beamToNamed('/books/${book.id}'),
              ),
            )
            .toList(),
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  final Book? book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book?.title ?? 'Not Found'),
      ),
      body: book != null
          ? InkWell(
              onTap: () => context.beamToNamed('/books/${book!.id}/${book!.author}'),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Author: ${book!.author}'),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class AuthorDetailsScreen extends StatelessWidget {
  const AuthorDetailsScreen({Key? key, required this.book}) : super(key: key);

  final Book? book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book?.author ?? 'Not Found'),
      ),
      body: book != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Book: ${book!.title}'),
            )
          : const SizedBox.shrink(),
    );
  }
}
