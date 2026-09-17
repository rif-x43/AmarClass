import 'package:flutter/material.dart';

import 'pages/splash_screen.dart';

void main() {
  runApp(const AmarClassApp());
}

class AmarClassApp extends StatelessWidget {
  const AmarClassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AmarClass',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F8FF),
        primaryColor: const Color(0xFF2F8DF6),
      ),
      home: const SplashScreen(),
    );
  }
}
