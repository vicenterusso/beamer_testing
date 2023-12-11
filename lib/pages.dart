// DATA
import 'package:beamer/beamer.dart';
import 'package:beamer_testing/beamer_locations.dart';
import 'package:beamer_testing/drawer.dart';
import 'package:beamer_testing/router.dart';
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
      drawer: const CustomDrawer(),
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

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  final Book? book;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  void initState() {
    super.initState();
    routerDelegate.addListener(_routeListener);
  }

  void _routeListener() {
    // Should work if all locations are separated. Test Later
    // var beamLocation = routerDelegate.currentBeamLocation;
    // if (beamLocation is BooksLocation) {
    //   // The HomePage is now the top-most route
    //   // Perform your data refresh logic here
    //   _refreshData();
    // }

    var currentPath = routerDelegate.configuration.uri.toString();
    if (currentPath == '/books') {
      // The HomePage is now the top-most route
      // Perform your data refresh logic here
      _refreshData();
    }
  }

  void _refreshData() {
    // Implement your data refresh logic
    print("Data refreshed!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book?.title ?? 'Not Found'),
      ),
      body: widget.book != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => context.beamToNamed('/books/${widget.book!.id}/${widget.book!.author}'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Author: ${widget.book!.author}'),
                  ),
                ),
                const Text('BookDetailsScreen')
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  void dispose() {
    routerDelegate.removeListener(_routeListener);
    super.dispose();
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
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Book: ${book!.title}'),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () => context.beamToNamed('/'),
                    child: const Text('Home'),
                  ),
                )
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
