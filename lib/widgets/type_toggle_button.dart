import 'package:flutter/material.dart';

class TypeToggleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const TypeToggleButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF0B5E1C) : Colors.white,
          border: Border.all(color: const Color(0xFF0B5E1C)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : const Color(0xFF0B5E1C),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : const Color(0xFF0B5E1C),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 