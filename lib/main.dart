import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
