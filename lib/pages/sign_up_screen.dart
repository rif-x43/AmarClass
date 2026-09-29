import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'user_role.dart';

class _RoleSelector extends StatelessWidget {
  const _RoleSelector({required this.selectedRole, required this.onChanged});

  final UserRole selectedRole;
  final ValueChanged<UserRole> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _RoleOption(
            label: 'Student',
            icon: Icons.school_outlined,
            selected: selectedRole == UserRole.student,
            onTap: () => onChanged(UserRole.student),
          ),
          _RoleOption(
            label: 'Faculty',
            icon: Icons.co_present_outlined,
            selected: selectedRole == UserRole.faculty,
            onTap: () => onChanged(UserRole.faculty),
          ),
        ],
      ),
    );
  }
}

class _RoleOption extends StatelessWidget {
  const _RoleOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFF3F8FF) : Colors.transparent,
              border: selected
                  ? Border.all(color: const Color(0xFF9CCBFA), width: 1)
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: selected ? const Color(0xFF4D9BF5) : Colors.black45,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: selected ? const Color(0xFF4D9BF5) : Colors.black54,
                  ),
                ),
              ],
            ),
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
    required TextEditingController controller,
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
        TextField(
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
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 56, 24, 32),
          child: Column(
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
              _RoleSelector(
                selectedRole: _selectedRole,
                onChanged: (role) => setState(() => _selectedRole = role),
              ),
              const SizedBox(height: 24),
              _signUpField(
                label: 'Full Name',
                hint: 'e.g. John Doe',
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              _signUpField(
                label: 'Institutional Email Address',
                hint: 'john.doe@aust.edu',
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
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
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
                  onPressed: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Inter Display',
                      fontSize: 13,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Sign In',
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

  Future<void> _signUpWithGoogle() async {
    try {
      final provider = GoogleAuthProvider();

      final credential = await FirebaseAuth.instance.signInWithPopup(provider);
      final user = credential.user;

      if (user == null) return;

      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);
      final userDoc = await userRef.get();

      if (!userDoc.exists) {
        await userRef.set({
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'role': _selectedRole.name,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      final role = userDoc.exists
          ? _roleFromValue(userDoc.data()?['role'])
          : _selectedRole;

      if (role == null) {
        _showMessage('User role not found');
        return;
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen(role: role)),
      );
    } on FirebaseAuthException catch (error) {
      _showMessage(error.message ?? 'Google signup failed');
    } on FirebaseException catch (error) {
      _showMessage(error.message ?? 'Firestore error');
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
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      if (user == null) return;

      await user.updateDisplayName(name);

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'role': _selectedRole.name,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen(role: _selectedRole)),
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
