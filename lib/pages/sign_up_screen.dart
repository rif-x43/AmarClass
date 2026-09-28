import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'user_role.dart';

class _RoleButton extends StatelessWidget {
  const _RoleButton({
    required this.title,
    required this.selected,
    required this.onPressed,
  });

  final String title;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: selected ? Colors.black87 : Colors.white,
          splashFactory: NoSplash.splashFactory,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: selected ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  UserRole _selectedRole = UserRole.student;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Widget _signUpField({
    required String label,
    required String hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(fontFamily: 'Inter Display', fontSize: 15),
          cursorColor: const Color(0xFF2F8DF6),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black26),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF2F8DF6),
                width: 0.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage('brandings/logo_black.png'),
                height: 30,
              ),
              const SizedBox(height: 32),
              const Text(
                'Join AmarClass',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Establish your academic profile to synchronize courses, schedules, and assessments.',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 36),
              const Text(
                'Account Type',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _RoleButton(
                    title: 'Student',
                    selected: _selectedRole == UserRole.student,
                    onPressed: () {
                      setState(() => _selectedRole = UserRole.student);
                    },
                  ),
                  const SizedBox(width: 12),
                  _RoleButton(
                    title: 'Faculty',
                    selected: _selectedRole == UserRole.faculty,
                    onPressed: () {
                      setState(() => _selectedRole = UserRole.faculty);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _signUpField(
                label: 'Full Name',
                hint: 'e.g. Partho Yag Paul',
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              _signUpField(
                label: 'Institutional Email Address',
                hint: 'partho.yag@aust.edu',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              _signUpField(
                label: 'Password',
                hint: '••••••••',
                obscureText: _obscurePassword,
                controller: _passwordController,
                suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black45,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              _signUpField(
                label: 'Confirm Password',
                hint: '••••••••',
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black45,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton(
                  onPressed: _signUpWithEmail,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF2F8DF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton.icon(
                  onPressed: _signUpWithGoogle,
                  icon: const Image(
                    image: AssetImage('brandings/misc/google_icon.png'),
                    height: 20,
                  ),
                  label: const Text('Sign up with Google'),
                ),
              ),
              //const SizedBox(height: 24),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text(
              //       'Already have an account?',
              //       style: TextStyle(
              //         color: Colors.black54,
              //         fontFamily: 'Inter Display',
              //         fontSize: 13,
              //       ),
              //     ),
                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //     splashFactory: NoSplash.splashFactory,
                  //     padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  //     minimumSize: Size.zero,
                  //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //   ),
                  //   onPressed: () => Navigator.pop(context),
                  //   child: const Text(
                  //     'Sign In',
                  //     style: TextStyle(
                  //       color: Color(0xFF2F8DF6),
                  //       fontFamily: 'Inter Display',
                  //       fontSize: 13,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  //   ),
                  // ),
                //],
              //),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUpWithGoogle() async {
    try {
      final provider = GoogleAuthProvider();

      final credential = await FirebaseAuth.instance.signInWithPopup(provider);
      final user = credential.user;

      if (user == null) return;

      final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userDoc = await userRef.get();

      if (!userDoc.exists) {
        await userRef.set({
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'role': _selectedRole == UserRole.faculty ? 'faculty' : 'student',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardScreen(role: _selectedRole),
        ),
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('Google signup failed: ${error.code}');
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup failed: ${error.message ?? error.code}'),
        ),
      );
    }
  }

  Future<void> _signUpWithEmail() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage('সবগুলো field পূরণ করুন');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('Password দুটো একই নয়');
      return;
    }

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) return;

      await user.updateDisplayName(name);

      final role = _selectedRole == UserRole.faculty
          ? 'faculty'
          : 'student';

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
        'name': name,
        'email': email,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardScreen(role: _selectedRole),
        ),
      );
    } on FirebaseAuthException catch (error) {
      _showMessage(error.message ?? error.code);
    } on FirebaseException catch (error) {
      _showMessage(error.message ?? 'Firestore error');
    } catch (error) {
      _showMessage(error.toString());
    }
  }
}