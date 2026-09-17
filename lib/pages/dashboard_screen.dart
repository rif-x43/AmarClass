import 'package:flutter/material.dart';

import 'profile_screen.dart';
import 'schedule_screen.dart';
import 'user_role.dart';

class DashboardScreen extends StatefulWidget {
  final UserRole role;

  const DashboardScreen({super.key, required this.role});

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
          SafeArea(
            child: _selectedIndex == 0
                ? (widget.role == UserRole.faculty
                      ? _buildFacultyContent()
                      : _buildDashboardContent())
                : _selectedIndex == 3
                ? ProfileScreen(role: widget.role)
                : _selectedIndex == 2
                ? ScheduleScreen(role: widget.role)
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: _buildNavigationBar(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacultyContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
      children: [
        _buildHeader('Dr. Farhana Rahman', 'Lecturer, Dept. of CSE'),
        const SizedBox(height: 32),
        const Text(
          'Good Evening, Rahman.',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Active Courses',
                value: '3',
                color: Color(0xFF2F8DF6),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'Total Students',
                value: '86',
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
              'Your Courses',
              style: TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 17),
              label: const Text('New course'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2F8DF6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
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
        const SizedBox(height: 32),
        const Text(
          'Course Tools',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const _FacultyTool(
          icon: Icons.fact_check_outlined,
          title: 'Attendance tracking',
        ),
        const _FacultyTool(
          icon: Icons.cast_for_education_outlined,
          title: 'Online class',
        ),
        const _FacultyTool(icon: Icons.grading_outlined, title: 'Grading'),
        const _FacultyTool(icon: Icons.draw_outlined, title: 'Whiteboard'),
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
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
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

  Widget _buildDashboardContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
      children: [
        _buildHeader('Partho Yag Paul', 'Student, B.Sc in CSE'),
        const SizedBox(height: 32),
        const Text(
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
        const Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Active Courses',
                value: '4',
                color: Color(0xFF2F8DF6),
              ),
            ),
            SizedBox(width: 16),
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
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _TaskCard(
                courseCode: 'CSE 2105',
                title: 'Sequential Circuit Design',
                dueText: 'Due Sunday',
                progress: 0.25,
                status: 'Started',
                compact: true,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
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
        _CourseCard(
          courseCode: 'CSE 2103',
          courseName: 'Data Structures',
          instructor: 'Md. Siam Ansary',
          onTap: () => _openStudentCourse(
            code: 'CSE 2103',
            name: 'Data Structures',
            instructor: 'Md. Siam Ansary',
          ),
        ),
        const SizedBox(height: 12),
        _CourseCard(
          courseCode: 'CSE 2105',
          courseName: 'Digital Logic Design',
          instructor: 'Syeda Shabnam Hasan',
          onTap: () => _openStudentCourse(
            code: 'CSE 2105',
            name: 'Digital Logic Design',
            instructor: 'Syeda Shabnam Hasan',
          ),
        ),
        const SizedBox(height: 12),
        _CourseCard(
          courseCode: 'MATH 2109',
          courseName: 'Complex Variable, Laplace Transformation and Statistics',
          instructor: 'Md. Ekramul Haque Pathshala',
          onTap: () => _openStudentCourse(
            code: 'MATH 2109',
            name: 'Complex Variable, Laplace Transformation and Statistics',
            instructor: 'Md. Ekramul Haque Pathshala',
          ),
        ),
      ],
    );
  }

  void _openFacultyCourse({
    required String code,
    required String name,
    required String students,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => ClassroomScreen(
          courseCode: code,
          courseName: name,
          instructor: 'Dr. Farhana Rahman',
          studentCount: students,
          isFaculty: true,
        ),
      ),
    );
  }

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

  Widget _buildNavigationBar() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.dashboard_outlined,
            selectedIcon: Icons.dashboard,
            isSelected: _selectedIndex == 0,
            onTap: () => setState(() => _selectedIndex = 0),
          ),
          _NavItem(
            icon: Icons.task_alt_outlined,
            selectedIcon: Icons.task_alt,
            isSelected: _selectedIndex == 1,
            onTap: () => setState(() => _selectedIndex = 1),
          ),
          _NavItem(
            icon: Icons.calendar_month_outlined,
            selectedIcon: Icons.calendar_month,
            isSelected: _selectedIndex == 2,
            onTap: () => setState(() => _selectedIndex = 2),
          ),
          _NavItem(
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
            isSelected: _selectedIndex == 3,
            onTap: () => setState(() => _selectedIndex = 3),
          ),
        ],
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
    required this.code,
    required this.title,
    required this.students,
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
                color: const Color(0xFF2F8DF6),
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
                    code,
                    style: const TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F8DF6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
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
                    students,
                    style: const TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 12,
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

class _FacultyTool extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FacultyTool({required this.icon, required this.title});

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

class _CourseCard extends StatelessWidget {
  final String courseCode;
  final String courseName;
  final String instructor;
  final VoidCallback onTap;

  const _CourseCard({
    required this.courseCode,
    required this.courseName,
    required this.instructor,
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
    required this.icon,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2F8DF6)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 12,
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
        color: featured
            ? const Color(0xFF2F8DF6).withValues(alpha: 0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: featured
              ? const Color(0xFF2F8DF6).withValues(alpha: 0.25)
              : Colors.black12,
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
              backgroundColor: Colors.black12,
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
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
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
