import 'package:flutter/material.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  static const _items = [
    (icon: Icons.dashboard_outlined, selectedIcon: Icons.dashboard),
    (icon: Icons.menu_book_outlined, selectedIcon: Icons.menu_book),
    (icon: Icons.task_alt_outlined, selectedIcon: Icons.task_alt),
    (icon: Icons.calendar_month_outlined, selectedIcon: Icons.calendar_month),
    (icon: Icons.person_outline, selectedIcon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var index = 0; index < _items.length; index++)
            _NavItem(
              icon: _items[index].icon,
              selectedIcon: _items[index].selectedIcon,
              isSelected: selectedIndex == index,
              onTap: () => onItemSelected(index),
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF2F8DF6).withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            isSelected ? selectedIcon : icon,
            color: isSelected ? const Color(0xFF2F8DF6) : Colors.black45,
            size: 26,
          ),
        ),
      ),
    );
  }
}
