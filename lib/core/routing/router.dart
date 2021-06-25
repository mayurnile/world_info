import 'package:flutter/material.dart';

import './route_names.dart';
import '../../presentation/screens/screens.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _getPageRoute(HomeScreen(), settings);
    case HOME_ROUTE:
      return _getPageRoute(HomeScreen(), settings);
    case COUNTRIES_ROUTE:
      return _getPageRoute(CountriesScreen(), settings);
    case COUNTRY_DETAILS_ROUTE:
      return _getPageRoute(CountryDetailsScreen(), settings);
    default:
      return _getPageRoute(HomeScreen(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _SlideRoute(child: child, routeName: settings.name!);
}

class _SlideRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;

  _SlideRoute({required this.child, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            var curve = Curves.easeInOut;
            var curveTween = CurveTween(curve: curve);

            var begin = Offset(1.0, 0.0);
            var end = Offset.zero;
            var tween = Tween(begin: begin, end: end).chain(curveTween);
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
