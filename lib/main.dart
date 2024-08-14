import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc/utils/routes/routes.dart';
import 'package:flutter_mvvm_bloc/utils/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          onPrimary: Colors.white,
          secondary: Colors.deepOrange,
          onSecondary: Colors.black,
        ),
        useMaterial3: true, // Material 3 is generally preferred unless specific reasons dictate otherwise
      ),
      initialRoute: RouteNames.splash,
      onGenerateRoute: Routes.generateRoutes,
      debugShowCheckedModeBanner: false, // Optionally hide the debug banner
    );
  }
}
