import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final List<String>? options;
  final void Function(String)? onSelected;
  final bool noRightMargin;
  const FilterButton({
    required this.label,
    this.options,
    this.onSelected,
    this.noRightMargin = false,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: noRightMargin
          ? EdgeInsets.zero
          : const EdgeInsets.only(right: 12),
      child: PopupMenuButton<String>(
        tooltip: label,
        onSelected: onSelected ?? (value) => print('Selected: $value'),
        itemBuilder: (context) {
          if (options == null) return [];
          return options!
              .map((opt) => PopupMenuItem<String>(value: opt, child: Text(opt)))
              .toList();
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FB),
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.tune, color: Color(0xFF0B5E1C)),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: Color(0xFF0B5E1C))),
            ],
          ),
        ),
      ),
    );
  }
} 