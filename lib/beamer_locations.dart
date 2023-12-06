import 'package:beamer_testing/pages.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:collection/collection.dart';

// LOCATIONS
class BooksLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/books/:bookId/:author'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pages = [
      const BeamPage(
        key: ValueKey('home'),
        title: 'Home',
        child: HomeScreen(),
      ),
      if (state.uri.pathSegments.contains('books'))
        const BeamPage(
          key: ValueKey('books'),
          title: 'Books',
          child: BooksScreen(),
        ),
    ];
    final String? bookIdParameter = state.pathParameters['bookId'];
    if (bookIdParameter != null) {
      final bookId = int.tryParse(bookIdParameter);
      final book = books.firstWhereOrNull((book) => book.id == bookId);
      pages.add(
        BeamPage(
          key: ValueKey('book-$bookIdParameter'),
          title: 'Book #$bookIdParameter',
          child: BookDetailsScreen(book: book),
        ),
      );
    }
    final String? author = state.pathParameters['author'];
    if (author != null) {
      final book = books.firstWhereOrNull((book) => book.author == author);
      pages.add(
        BeamPage(
          key: ValueKey('author-$author'),
          title: 'Author #$author',
          child: AuthorDetailsScreen(book: book),
        ),
      );
    }
    return pages;
  }
}
