import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart';
import 'password_recovery_screen.dart';
import 'sign_up_screen.dart';
import 'user_role.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _rememberedEmailKey = 'remembered_email';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedEmail();
  }

  Future<void> _loadRememberedEmail() async {
    final preferences = await SharedPreferences.getInstance();
    final email = preferences.getString(_rememberedEmailKey);

    if (!mounted || email == null || email.isEmpty) return;

    setState(() {
      _emailController.text = email;
      _rememberMe = true;
    });
  }

  Future<void> _saveRememberedEmail(String email) async {
    final preferences = await SharedPreferences.getInstance();

    if (_rememberMe) {
      await preferences.setString(_rememberedEmailKey, email);
    } else {
      await preferences.remove(_rememberedEmailKey);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) return;

      await _saveRememberedEmail(email);
      await _goToDashboard(user);
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Login failed'),
        ),
      );
    } on FirebaseException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Database error'),
        ),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final provider = GoogleAuthProvider();

      final credential = await FirebaseAuth.instance
          .signInWithPopup(provider);

      final user = credential.user;
      if (user == null) return;

      await _saveRememberedEmail(user.email ?? '');

      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      final userDoc = await userRef.get();

      if (!userDoc.exists) {
        await FirebaseAuth.instance.signOut();
        _showMessage('No account found. Please sign up first and choose a role.');
        return;
      }

      await _goToDashboard(user);
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Google login failed'),
        ),
      );
    } on FirebaseException catch (error) {
      _showMessage(error.message ?? 'Database error');
    }
  }

  Future<void> _openPasswordRecovery() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showMessage('Enter your email address first.');
      return;
    }

    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (result.docs.isEmpty) {
        _showMessage('No account found for this email address.');
        return;
      }

      final role = _roleFromValue(result.docs.first.data()['role']);
      if (role == null) {
        _showMessage('User role not found.');
        return;
      }

      if (!mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PasswordRecoveryScreen(role: role),
        ),
      );
    } on FirebaseException catch (error) {
      _showMessage(error.message ?? 'Database error');
    }
  }

  UserRole? _roleFromValue(Object? value) {
    switch (value) {
      case 'student':
        return UserRole.student;
      case 'faculty':
        return UserRole.faculty;
      default:
        return null;
    }
  }

  Future<void> _goToDashboard(User user) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final role = _roleFromValue(userDoc.data()?['role']);

    if (role == null) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User role not found')),
      );
      return;
    }

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DashboardScreen(role: role),
      ),
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
                'Welcome Back',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Centralize your course modules, student rosters, and academic scheduling effortlessly.',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 48),

              _CustomTextField(
                label: 'Institutional Email Address',
                hint: 'john.doe@aust.edu',
                controller: _emailController,
              ),
              const SizedBox(height: 20),

              _CustomTextField(
                label: 'Password',
                hint: '••••••••',
                controller: _passwordController,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black45,
                    size: 18,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: (value) =>
                              setState(() => _rememberMe = value ?? false),
                          activeColor: const Color(0xFF2F8DF6),
                          side: const BorderSide(color: Colors.black26),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          fontFamily: 'Inter Display',
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PasswordRecoveryScreen(
                          role: _emailController.text.trim() == 'test2@aust.edu'
                              ? UserRole.faculty
                              : UserRole.student,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: 'Inter Display',
                        fontSize: 14,
                        color: Color(0xFF2F8DF6),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF2F8DF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: _signIn,
                  child: const Text(
                    'Sign In',
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
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  icon: const Image(
                    image: AssetImage('brandings/misc/google_icon.png'),
                    height: 20,
                  ),
                  label: const Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  onPressed: _signInWithGoogle,
                ),
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Inter Display',
                      fontSize: 13,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF2F8DF6),
                        fontFamily: 'Inter Display',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;

  const _CustomTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
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
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
