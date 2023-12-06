import 'package:beamer/beamer.dart';
import 'package:beamer_testing/beamer_locations.dart';

final routerDelegate = BeamerDelegate(
  locationBuilder: BeamerLocationBuilder(
    beamLocations: [BooksLocation()],
  ),
  notFoundRedirectNamed: '/books',
);
