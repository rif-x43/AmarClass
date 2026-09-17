import 'package:flutter/material.dart';

import 'user_role.dart';

class ScheduleScreen extends StatefulWidget {
  final UserRole role;

  const ScheduleScreen({super.key, required this.role});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late DateTime _visibleMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _visibleMonth = DateTime(today.year, today.month);
    _selectedDate = DateTime(today.year, today.month, today.day);
  }

  void _changeMonth(int offset) {
    setState(() {
      _visibleMonth = DateTime(
        _visibleMonth.year,
        _visibleMonth.month + offset,
      );
      _selectedDate = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFaculty = widget.role == UserRole.faculty;
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
      children: [
        _ScheduleHeader(isFaculty: isFaculty),
        const SizedBox(height: 32),
        const Text(
          'Schedule',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        _buildCalendar(),
        const SizedBox(height: 28),
        Text(
          _formatDate(_selectedDate),
          style: const TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ..._buildEvents(isFaculty),
      ],
    );
  }

  Widget _buildCalendar() {
    final daysInMonth = DateTime(
      _visibleMonth.year,
      _visibleMonth.month + 1,
      0,
    ).day;
    final firstWeekday = DateTime(
      _visibleMonth.year,
      _visibleMonth.month,
      1,
    ).weekday;
    final cells = <Widget>[];

    for (var index = 1; index < firstWeekday; index++) {
      cells.add(const SizedBox(height: 34));
    }
    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_visibleMonth.year, _visibleMonth.month, day);
      final isSelected = date == _selectedDate;
      final hasEvent = day == 3 || day == 8 || day == 12 || day == 17;
      cells.add(
        GestureDetector(
          onTap: () => setState(() => _selectedDate = date),
          child: SizedBox(
            height: 34,
            child: Column(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF2F8DF6)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  height: 3,
                  width: 3,
                  decoration: BoxDecoration(
                    color: hasEvent
                        ? const Color(0xFF2F8DF6)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _monthName(_visibleMonth),
                style: const TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  _MonthButton(
                    icon: Icons.chevron_left,
                    onTap: () => _changeMonth(-1),
                  ),
                  _MonthButton(
                    icon: Icons.chevron_right,
                    onTap: () => _changeMonth(1),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _WeekdayLabel('M'),
              _WeekdayLabel('T'),
              _WeekdayLabel('W'),
              _WeekdayLabel('T'),
              _WeekdayLabel('F'),
              _WeekdayLabel('S'),
              _WeekdayLabel('S'),
            ],
          ),
          const SizedBox(height: 4),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.3,
            children: cells,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildEvents(bool isFaculty) {
    if (_selectedDate.day == 17) {
      return [
        _ScheduleEvent(
          time: '09:00 - 10:30',
          course: isFaculty ? 'CSE 1205' : 'CSE 2103',
          title: isFaculty ? 'Object Oriented Programming' : 'Data Structures',
          detail: isFaculty
              ? 'Room 402 · Lecture'
              : 'Room 402 · Dr. Siam Ansary',
        ),
        _ScheduleEvent(
          time: '14:00 - 15:30',
          course: isFaculty ? 'CSE 1203' : 'CSE 2105',
          title: isFaculty ? 'Discrete Math' : 'Digital Logic Design',
          detail: isFaculty
              ? 'Room 305 · Lecture'
              : 'Room 305 · Syeda Shabnam Hasan',
        ),
      ];
    }
    return [const _EmptyScheduleEvent()];
  }

  String _monthName(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  String _formatDate(DateTime date) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }
}

class _ScheduleHeader extends StatelessWidget {
  final bool isFaculty;

  const _ScheduleHeader({required this.isFaculty});

  @override
  Widget build(BuildContext context) {
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
                  isFaculty ? 'Dr. Farhana Rahman' : 'Partho Yag Paul',
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isFaculty ? 'Lecturer, Dept. of CSE' : 'Student, B.Sc in CSE',
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
}

class _WeekdayLabel extends StatelessWidget {
  final String label;

  const _WeekdayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Inter Display',
          fontSize: 11,
          color: Colors.black45,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MonthButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MonthButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 19),
      color: Colors.black54,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      padding: EdgeInsets.zero,
    );
  }
}

class _ScheduleEvent extends StatelessWidget {
  final String time;
  final String course;
  final String title;
  final String detail;

  const _ScheduleEvent({
    required this.time,
    required this.course,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  time,
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  course,
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
                  style: const TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
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

class _EmptyScheduleEvent extends StatelessWidget {
  const _EmptyScheduleEvent();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: const Text(
        'No classes scheduled for this day.',
        style: TextStyle(
          fontFamily: 'Inter Display',
          fontSize: 13,
          color: Colors.black54,
        ),
      ),
    );
  }
}
