import 'package:flutter/material.dart';

import 'user_role.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final isFaculty = role == UserRole.faculty;

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
      children: [
        const Text(
          'Courses',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isFaculty ? 'Manage your courses.' : 'Browse your enrolled courses.',
          style: const TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
