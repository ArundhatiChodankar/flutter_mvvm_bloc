import 'package:flutter/material.dart';

import '../../view/view.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    final routes = <String, WidgetBuilder>{
      RouteNames.splash: (_) => const SplashScreen(),
      RouteNames.home: (_) => const HomeScreen(),
      RouteNames.login: (_) => const LoginScreen(),
      RouteNames.signup: (_) => const SignUpScreen(),
    };

    WidgetBuilder? builder = routes[routeSettings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: routeSettings);
    } else {
      // Log or handle the unknown route case more effectively if needed
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("No route is configured"),
          ),
        ),
        settings: routeSettings,
      );
    }
  }
}
