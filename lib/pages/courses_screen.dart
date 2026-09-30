import 'package:flutter/material.dart';

import 'user_role.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key, required this.role});

  final UserRole role;

  static const _studentCourses = [
    _Course(
      code: 'CSE 2103',
      title: 'Data Structures',
      instructor: 'Md. Siam Ansary',
    ),
    _Course(
      code: 'CSE 2105',
      title: 'Digital Logic Design',
      instructor: 'Syeda Shabnam Hasan',
    ),
    _Course(
      code: 'MATH 2109',
      title: 'Complex Variable, Laplace Transformation and Statistics',
      instructor: 'Md. Ekramul Haque Pathshala',
    ),
  ];

  static const _facultyCourses = [
    _Course(
      code: 'CSE 1205',
      title: 'Object Oriented Programming',
      instructor: 'You',
      studentCount: 32,
    ),
    _Course(
      code: 'CSE 1203',
      title: 'Discrete Math',
      instructor: 'You',
      studentCount: 28,
    ),
    _Course(
      code: 'CSE 1101',
      title: 'Structured Programming Language',
      instructor: 'You',
      studentCount: 26,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isFaculty = role == UserRole.faculty;
    final courses = isFaculty ? _facultyCourses : _studentCourses;

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
      children: [
        const Text(
          'Current Semester',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isFaculty ? 'Your teaching courses' : 'Your enrolled courses',
          style: const TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 24),
        for (final course in courses) ...[
          _CourseCard(course: course, isFaculty: isFaculty),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _Course {
  const _Course({
    required this.code,
    required this.title,
    required this.instructor,
    this.studentCount,
  });

  final String code;
  final String title;
  final String instructor;
  final int? studentCount;
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.course,
    required this.isFaculty,
  });

  final _Course course;
  final bool isFaculty;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.black12),
      ),
      child: ExpansionTile(
        leading: const Icon(
          Icons.menu_book_outlined,
          color: Color(0xFF2F8DF6),
        ),
        title: Text(
          course.title,
          style: const TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          course.code,
          style: const TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 12,
            color: Color(0xFF2F8DF6),
          ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(72, 0, 16, 16),
        children: [
          _CourseDetail(
            label: isFaculty ? 'Course role' : 'Instructor',
            value: course.instructor,
          ),
          _CourseDetail(
            label: 'Schedule',
            value: 'Not set',
          ),
          if (isFaculty && course.studentCount != null)
            _CourseDetail(
              label: 'Students',
              value: '${course.studentCount}',
            ),
        ],
      ),
    );
  }
}

class _CourseDetail extends StatelessWidget {
  const _CourseDetail({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
