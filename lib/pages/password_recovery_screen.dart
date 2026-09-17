import 'package:flutter/material.dart';

import 'otp_verification_screen.dart';
import 'user_role.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  final UserRole role;

  const PasswordRecoveryScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: Colors.black87,
                ),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 48),
              const Image(
                image: AssetImage('brandings/logo_black.png'),
                height: 30,
              ),
              const SizedBox(height: 32),
              const Text(
                'Password Recovery',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your institutional email address to receive a password reset link.',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Institutional Email Address',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontFamily: 'Inter Display', fontSize: 15),
                cursorColor: Color(0xFF2F8DF6),
                decoration: InputDecoration(
                  hintText: 'partho.yag@aust.edu',
                  hintStyle: TextStyle(color: Colors.black26),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: Color(0xFF2F8DF6),
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF2F8DF6),
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Send Reset Link',
                    style: TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => OtpVerificationScreen(role: role),
                      ),
                    );
                  },
                  child: const Text(
                    'Login with OTP',
                    style: TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 13,
                      color: Color(0xFF2F8DF6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
