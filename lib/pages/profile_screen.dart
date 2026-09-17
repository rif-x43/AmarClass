import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'user_role.dart';

class ProfileScreen extends StatelessWidget {
  final UserRole role;

  const ProfileScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final isFaculty = role == UserRole.faculty;
    final name = isFaculty ? 'Dr. Farhana Rahman' : 'Partho Yag Paul';
    final subtitle = isFaculty
        ? 'Faculty · Computer Science'
        : 'Student · B.Sc in CSE';
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      children: [
        const Image(
          image: AssetImage('brandings/logo_black.png'),
          height: 24,
          alignment: Alignment.centerLeft,
        ),
        const SizedBox(height: 42),
        const CircleAvatar(
          radius: 38,
          backgroundImage: AssetImage('brandings/icon.png'),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 36),
        _ProfileGroup(
          children: [
            _ProfileItem(
              icon: Icons.email_outlined,
              label: 'Institutional email',
              value: isFaculty
                  ? 'farhana.rahman@aust.edu'
                  : 'partho.yag@aust.edu',
            ),
            _ProfileItem(
              icon: Icons.badge_outlined,
              label: 'Account type',
              value: isFaculty ? 'Faculty account' : 'Student account',
            ),
            _ProfileItem(
              icon: Icons.school_outlined,
              label: isFaculty ? 'Department' : 'Program',
              value: isFaculty
                  ? 'Computer Science and Engineering'
                  : 'B.Sc in Computer Science',
            ),
          ],
        ),
        const SizedBox(height: 20),
        _ProfileGroup(
          children: [
            const _ProfileItem(
              icon: Icons.notifications_none,
              label: 'Notifications',
              value: 'Manage preferences',
              showArrow: true,
            ),
            const _ProfileItem(
              icon: Icons.lock_outline,
              label: 'Security',
              value: 'Password and access',
              showArrow: true,
            ),
          ],
        ),
        const SizedBox(height: 24),
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          },
          icon: const Icon(Icons.logout_outlined, size: 18),
          label: const Text('Log out'),
          style: TextButton.styleFrom(foregroundColor: const Color(0xFF2F8DF6)),
        ),
      ],
    );
  }
}

class _ProfileGroup extends StatelessWidget {
  final List<Widget> children;
  const _ProfileGroup({required this.children});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.black12),
    ),
    child: Column(children: children),
  );
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showArrow;
  const _ProfileItem({
    required this.icon,
    required this.label,
    required this.value,
    this.showArrow = false,
  });
  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: const Color(0xFF2F8DF6)),
    title: Text(
      label,
      style: const TextStyle(
        fontFamily: 'Inter Display',
        fontSize: 12,
        color: Colors.black54,
      ),
    ),
    subtitle: Text(
      value,
      style: const TextStyle(
        fontFamily: 'Inter Display',
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    ),
    trailing: showArrow
        ? const Icon(Icons.chevron_right, color: Colors.black38)
        : null,
  );
}
