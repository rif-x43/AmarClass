import 'dart:ui';

import 'package:flutter/material.dart';
import 'tasks_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<String> _pageTitles = [
    'Dashboard',
    'Tasks',
    'Schedule',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          // Main Body Content
          // NEW MINIMAL CODE
          SafeArea(
            child: _selectedIndex == 0
                ? _buildDashboardContent()
                : _selectedIndex == 1
                ? const TasksScreen()
                : Center(
              child: Text(
                _pageTitles[_selectedIndex],
                style: const TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // Floating Glassmorphism Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: _buildGlassNavigationBar(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        24,
        32,
        24,
        100,
      ), // Bottom padding prevents content hiding behind the nav bar
      children: [
        // Welcome Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage('brandings/logo_black.png'),
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Partho Yag Paul',
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
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Image(
                    image: AssetImage('brandings/appicon_blue.png'),
                    height: 42,
                    width: 42,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'Good Evening, Paul.',
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
                color: const Color(0xFF2F8DF6),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'Pending Tasks',
                value: '2',
                color: Colors.black87,
              ),
            ),
          ],
        ),
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
              onPressed: () {},
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
                status: 'Not started',
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
            color: Colors.white.withOpacity(0.7),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
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
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
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
    );
  }
}

class _CourseCard extends StatelessWidget {
  final String courseCode;
  final String courseName;
  final String instructor;

  const _CourseCard({
    required this.courseCode,
    required this.courseName,
    required this.instructor,
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
              color: const Color(0xFF2F8DF6).withOpacity(0.1),
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
        color: featured ? const Color(0xFFEAF3FF) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: featured ? const Color(0xFFB9D8FF) : Colors.black12,
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
              ? const Color(0xFF2F8DF6).withOpacity(0.1)
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
