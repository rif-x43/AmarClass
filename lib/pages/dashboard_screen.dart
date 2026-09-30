<<<<<<< HEAD
import 'dart:ui';
import 'package:amarclass/pages/user_role.dart';
import 'package:amarclass/pages/tasks_screen.dart';
import 'package:amarclass/pages/schedule_screen.dart';
//import 'package:amarclass/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:amarclass/ProfileScreen.dart';
import 'package:amarclass/pages/calender.dart';
=======
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'courses_screen.dart';
import 'floating_nav_bar.dart';
import 'profile_screen.dart';
import 'schedule_screen.dart';
import 'tasks_screen.dart';
import 'user_role.dart';
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6

class DashboardScreen extends StatefulWidget {
  final UserRole role;
  const DashboardScreen({super.key, required this.role});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

<<<<<<< HEAD
=======
  late final displayName = user?.displayName?.trim();
  final List<String> _pageTitles = [
    'Dashboard',
    'Courses',
    'Tasks',
    'Schedule',
    'Profile',
  ];

>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
<<<<<<< HEAD
          // Main Body Content
          SafeArea(
            child: _selectedIndex == 0
                ? _buildDashboardContent()
                : _selectedIndex == 1
                ? const TasksScreen()
                : _selectedIndex == 2
                //? ScheduleScreen(role: widget.role)
                ?SimpleCalendar()

                : const ProfileScreen()
          ),

          // Floating Glassmorphism Navigation Bar
=======
          SafeArea(child: _buildCurrentPage()),
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
<<<<<<< HEAD
              child: _buildGlassNavigationBar(),
=======
              child: FloatingNavBar(
                selectedIndex: _selectedIndex,
                onItemSelected: (index) =>
                    setState(() => _selectedIndex = index),
              ),
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildDashboardContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        24,
        32,
        24,
        100,
      ), // Bottom padding prevents content hiding behind the nav bar
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage('brandings/logo_black.png'),
              height: 24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
=======
  Widget _buildCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return widget.role == UserRole.faculty
            ? _buildFacultyContent()
            : _buildDashboardContent();
      case 1:
        return CoursesScreen(role: widget.role);
      case 2:
        return const TasksScreen();
      case 3:
        return ScheduleScreen(role: widget.role);
      case 4:
        return ProfileScreen(role: widget.role);
      default:
        return Center(
          child: Text(
            _pageTitles[_selectedIndex],
            style: const TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        );
    }
  }

  Widget _buildFacultyContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
      children: [
        _buildHeader(user?.displayName ?? 'Faculty', 'Lecturer, Dept. of CSE'),
        const SizedBox(height: 28),
        Text(
          'Good Evening, ${user?.displayName ?? 'Faculty'}',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Here is your teaching overview for today.',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Active courses',
                value: '3',
                icon: Icons.menu_book_outlined,
                color: Color(0xFF2F8DF6),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'Total students',
                value: '86',
                icon: Icons.groups_outlined,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Pending reviews',
                value: '12',
                icon: Icons.assignment_late_outlined,
                color: Color(0xFFE58A25),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'Attendance',
                value: '91%',
                icon: Icons.query_stats_outlined,
                color: Color(0xFF2E9B75),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        _SectionTitle(
          title: 'Today\'s classes',
          action: 'View schedule',
          onAction: () => setState(() => _selectedIndex = 3),
        ),
        const SizedBox(height: 12),
        const _FacultyClassCard(
          time: '09:00 AM',
          code: 'CSE 1205',
          title: 'Object Oriented Programming',
          location: 'Room 402  ·  32 students',
          active: true,
        ),
        const SizedBox(height: 10),
        const _FacultyClassCard(
          time: '02:30 PM',
          code: 'CSE 1203',
          title: 'Discrete Math',
          location: 'Room 305  ·  28 students',
        ),
        const SizedBox(height: 32),
        _SectionTitle(
          title: 'Upcoming classes',
          action: 'See all',
          onAction: () => setState(() => _selectedIndex = 3),
        ),
        const SizedBox(height: 12),
        const _UpcomingClassRow(
          day: 'Tomorrow',
          time: '10:00 AM',
          title: 'Structured Programming Language',
          code: 'CSE 1101',
        ),
        const _UpcomingClassRow(
          day: 'Thu, 14 Mar',
          time: '09:00 AM',
          title: 'Object Oriented Programming',
          code: 'CSE 1205',
        ),
        const SizedBox(height: 32),
        const _SectionTitle(title: 'Teaching insights', action: 'This week'),
        const SizedBox(height: 12),
        const _FacultyInsightCard(
          icon: Icons.fact_check_outlined,
          title: 'Student attendance',
          detail: 'CSE 1205 has the highest attendance this week.',
          value: '94%',
          color: Color(0xFF2E9B75),
        ),
        const SizedBox(height: 10),
        const _FacultyInsightCard(
          icon: Icons.assignment_outlined,
          title: 'Assignment overview',
          detail: '12 submissions are waiting for your review.',
          value: '12',
          color: Color(0xFFE58A25),
        ),
        const SizedBox(height: 32),
        _SectionTitle(
          title: 'Course management',
          action: 'Manage',
          onAction: () => setState(() => _selectedIndex = 1),
        ),
        const SizedBox(height: 12),
        _FacultyCourseCard(
          code: 'CSE 1205',
          title: 'Object Oriented Programming',
          students: '32 students',
          onTap: () => _openFacultyCourse(
            code: 'CSE 1205',
            name: 'Object Oriented Programming',
            students: '32 students',
          ),
        ),
        const SizedBox(height: 10),
        _FacultyCourseCard(
          code: 'CSE 1203',
          title: 'Discrete Math',
          students: '28 students',
          onTap: () => _openFacultyCourse(
            code: 'CSE 1203',
            name: 'Discrete Math',
            students: '28 students',
          ),
        ),
        const SizedBox(height: 10),
        _FacultyCourseCard(
          code: 'CSE 1101',
          title: 'Structured Programming Language',
          students: '26 students',
          onTap: () => _openFacultyCourse(
            code: 'CSE 1101',
            name: 'Structured Programming Language',
            students: '26 students',
          ),
        ),
        const SizedBox(height: 24),
        const _SectionTitle(title: 'Quick tools'),
        const SizedBox(height: 8),
        const _FacultyTool(
          icon: Icons.fact_check_outlined,
          title: 'Attendance tracking',
        ),
        const _FacultyTool(
          icon: Icons.grading_outlined,
          title: 'Grade submissions',
        ),
        const _FacultyTool(
          icon: Icons.cast_for_education_outlined,
          title: 'Start online class',
        ),
      ],
    );
  }

  Widget _buildHeader(String name, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Image(image: AssetImage('brandings/logo_black.png'), height: 24),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Partho Paul',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Inter Display',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Student, B.Sc in CSE',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Inter Display',
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => setState(() => _selectedIndex = 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Image(
                      image: AssetImage('brandings/appicon_blue.png'),
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ],
            ),
<<<<<<< HEAD
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'Good Evening, Paul.',
=======
            const SizedBox(width: 10),
            _NotificationButton(
              onPressed: () => _showMessage('Notifications are coming soon.'),
            ),
            const SizedBox(width: 8),
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF2F8DF6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.person_outline,
                color: Color(0xA6FFFFFF),
                size: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildDashboardContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
      children: [
        _buildHeader(user?.displayName ?? 'Student', 'Student, B.Sc in CSE'),
        const SizedBox(height: 32),
        Text(
          'Good Evening, ${user?.displayName ?? 'Student'}',
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Active Courses',
                value: '4',
<<<<<<< HEAD
                color: const Color(0xFF2F8DF6),
                onTap: () => setState(() => _selectedIndex = 2),
=======
                icon: Icons.menu_book_outlined,
                color: Color(0xFF2F8DF6),
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'Pending Tasks',
                value: '2',
                icon: Icons.assignment_outlined,
                color: Colors.black87,
                onTap: () => setState(() => _selectedIndex = 1),
              ),
            ),
          ],
        ),
<<<<<<< HEAD
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pending Tasks',
              style: TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () => setState(() => _selectedIndex = 1),
              child: const Text(
                'View all',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  color: Color(0xFF2F8DF6),
                  fontSize: 13,
                ),
              ),
            ),
          ],
=======
        const SizedBox(height: 32),
        _SectionTitle(
          title: 'Next class',
          action: 'View schedule',
          onAction: () => setState(() => _selectedIndex = 3),
        ),
        const SizedBox(height: 12),
        const _FacultyClassCard(
          time: '11:00 AM',
          code: 'CSE 2103',
          title: 'Data Structures',
          location: 'Room 201  ·  Starts in 45 min',
          active: true,
        ),
        const SizedBox(height: 32),
        _SectionTitle(
          title: 'Pending tasks',
          action: 'View all',
          onAction: () => setState(() => _selectedIndex = 2),
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
        ),
        const SizedBox(height: 8),
        const _TaskCard(
          courseCode: 'CSE 2103',
          title: 'Binary Search Tree Lab Report',
          dueText: 'Due tomorrow · 11:59 PM',
          progress: 0.7,
          status: 'In progress',
          featured: true,
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: _TaskCard(
                courseCode: 'CSE 2105',
                title: 'Sequential Circuit Design',
                dueText: 'Due Sunday',
                progress: 0.25,
                status: 'Started',
                compact: true,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: _TaskCard(
                courseCode: 'MATH 2109',
                title: 'Laplace Transformation Worksheet',
                dueText: 'Due Tuesday',
                progress: 0,
                status: 'Due',
                compact: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        const Text(
          'Current Semester',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),

        // Sleek Course Cards
        const _CourseCard(
          courseCode: 'CSE 2103',
          courseName: 'Data Structures',
          instructor: 'Md. Siam Ansary',
        ),
        const SizedBox(height: 12),
        const _CourseCard(
          courseCode: 'CSE 2105',
          courseName: 'Digital Logic Design',
          instructor: 'Syeda Shabnam Hasan',
        ),
        const SizedBox(height: 12),
        const _CourseCard(
          courseCode: 'MATH 2109',
          courseName: 'Complex Variable, Laplace Transformation and Statistics',
          instructor: 'Md. Ekramul Haque Pathshala',
        ),
      ],
    );
  }

  Widget _buildGlassNavigationBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.dashboard_outlined,
                selectedIcon: Icons.dashboard,
                label: 'Dashboard',
                isSelected: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
              ),
              _NavItem(
                icon: Icons.task_alt_outlined,
                selectedIcon: Icons.task_alt,
                label: 'Tasks',
                isSelected: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
              ),
              _NavItem(
                icon: Icons.calendar_month_outlined,
                selectedIcon: Icons.calendar_month,
                label: 'Schedule',
                isSelected: _selectedIndex == 2,
                onTap: () => setState(() => _selectedIndex = 2),
              ),
              _NavItem(
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'Profile',
                isSelected: _selectedIndex == 3,
                onTap: () => setState(() => _selectedIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
=======

  void _openStudentCourse({
    required String code,
    required String name,
    required String instructor,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => ClassroomScreen(
          courseCode: code,
          courseName: name,
          instructor: instructor,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    super.key,
    required this.title,
    this.action,
    this.onAction,
  });

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              action!,
              style: const TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 12,
                color: Color(0xFF2F8DF6),
              ),
            ),
          ),
      ],
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          tooltip: 'Notifications',
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFFF3F8FF),
            foregroundColor: const Color(0xFF2F8DF6),
            fixedSize: const Size(36, 36),
            padding: EdgeInsets.zero,
          ),
          icon: const Icon(Icons.notifications_none_outlined, size: 20),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFE56B6F),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class _FacultyClassCard extends StatelessWidget {
  const _FacultyClassCard({
    super.key,
    required this.time,
    required this.code,
    required this.title,
    required this.location,
    this.active = false,
  });

  final String time;
  final String code;
  final String title;
  final String location;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF2F8DF6).withOpacity(0.06)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: active
              ? const Color(0xFF2F8DF6).withOpacity(0.2)
              : Colors.black12,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              time,
              style: const TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          Container(width: 1, height: 42, color: Colors.black12),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  code,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F8DF6),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  location,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          if (active)
            const Icon(
              Icons.play_circle_outline,
              color: Color(0xFF2F8DF6),
              size: 22,
            ),
        ],
      ),
    );
  }
}

class _UpcomingClassRow extends StatelessWidget {
  const _UpcomingClassRow({
    super.key,
    required this.day,
    required this.time,
    required this.title,
    required this.code,
  });

  final String day;
  final String time;
  final String title;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            width: 82,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  time,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  code,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 11,
                    color: Color(0xFF2F8DF6),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.black26),
        ],
      ),
    );
  }
}

class _FacultyInsightCard extends StatelessWidget {
  const _FacultyInsightCard({
    super.key,
    required this.icon,
    required this.title,
    required this.detail,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String detail;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
<<<<<<< HEAD
  final VoidCallback? onTap;
=======
  final IconData icon;
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6

  const _StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
<<<<<<< HEAD
    this.onTap,
=======
    required this.icon,
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return GestureDetector(
=======
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 17),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _FacultyCourseCard extends StatelessWidget {
  final String code;
  final String title;
  final String students;
  final VoidCallback onTap;

  const _FacultyCourseCard({
    super.key,
    required this.code,
    required this.title,
    required this.students,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
=======
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFF2F8DF6),
                ),
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

<<<<<<< HEAD
=======
class _FacultyTool extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FacultyTool({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: const Color(0xFF2F8DF6)),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Inter Display',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: const Text(
        'Coming soon',
        style: TextStyle(
          fontFamily: 'Inter Display',
          fontSize: 12,
          color: Colors.black45,
        ),
      ),
      trailing: const Icon(Icons.lock_outline, size: 17, color: Colors.black26),
    );
  }
}

>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
class _CourseCard extends StatelessWidget {
  final String courseCode;
  final String courseName;
  final String instructor;

  const _CourseCard({
    super.key,
    required this.courseCode,
    required this.courseName,
    required this.instructor,
<<<<<<< HEAD
=======
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12, width: 0.5),
        ),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFF2F8DF6),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseCode,
                    style: const TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F8DF6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    courseName,
                    style: const TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    instructor,
                    style: const TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassroomScreen extends StatelessWidget {
  final String courseCode;
  final String courseName;
  final String instructor;
  final String? studentCount;
  final bool isFaculty;

  const ClassroomScreen({
    super.key,
    required this.courseCode,
    required this.courseName,
    required this.instructor,
    this.studentCount,
    this.isFaculty = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8FF),
        foregroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          'Classroom',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        children: [
          Text(
            courseCode,
            style: const TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2F8DF6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            courseName,
            style: const TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isFaculty
                ? 'Your classroom${studentCount == null ? '' : ' · $studentCount'}'
                : instructor,
            style: const TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 28),
          _ClassroomSection(
            icon: Icons.menu_book_outlined,
            title: 'Class materials',
            detail: 'Materials and announcements will appear here.',
          ),
          _ClassroomSection(
            icon: Icons.assignment_outlined,
            title: isFaculty ? 'Course work' : 'Assignments',
            detail: 'This section is not available yet.',
          ),
          _ClassroomSection(
            icon: Icons.people_outline,
            title: isFaculty ? 'Students' : 'Class members',
            detail: 'Class members and participation will appear here.',
          ),
        ],
      ),
    );
  }
}

class _ClassroomSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  const _ClassroomSection({
    super.key,
    required this.icon,
    required this.title,
    required this.detail,
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF2F8DF6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.menu_book_rounded, color: Color(0xFF2F8DF6)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseCode,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F8DF6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  courseName,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  instructor,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final String courseCode;
  final String title;
  final String dueText;
  final double progress;
  final String status;
  final bool featured;
  final bool compact;

  const _TaskCard({
    super.key,
    required this.courseCode,
    required this.title,
    required this.dueText,
    required this.progress,
    required this.status,
    this.featured = false,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
<<<<<<< HEAD
        color: featured ? const Color(0xFFEAF3FF) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: featured ? const Color(0xFFB9D8FF) : Colors.black12,
=======
        color: featured
            ? const Color(0xFF2F8DF6).withOpacity(0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: featured
              ? const Color(0xFF2F8DF6).withOpacity(0.25)
              : Colors.black12,
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.assignment_outlined,
                color: Color(0xFF2F8DF6),
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                courseCode,
                style: const TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F8DF6),
                ),
              ),
              const Spacer(),
              Text(
                status,
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 12,
                  color: progress == 0
                      ? Colors.black45
                      : const Color(0xFF2F8DF6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: compact ? 3 : 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: compact ? 14 : 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            dueText,
            style: const TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: const Color(0xFFE9EEF7),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF2F8DF6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
<<<<<<< HEAD

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2F8DF6).withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          isSelected ? selectedIcon : icon,
          color: isSelected ? const Color(0xFF2F8DF6) : Colors.black45,
          size: 26,
        ),
      ),
    );
  }
}
=======
>>>>>>> 87de53201054a800337f9b5e9c391a30f2405fb6
