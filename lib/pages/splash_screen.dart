import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

@override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF8F8FF),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Color(0x332F8DF6)],
          ),
        ),
        child: Align(
          alignment: Alignment(0, -0.07),
          child: Image(
            image: AssetImage('brandings/icon.png'),
            height: 120,
          ),
        ),
      ),
    );
  }
}
