import 'package:flutter/material.dart';

class StyledDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final void Function(T?) onChanged;
  final Widget Function(T)? iconBuilder;
  const StyledDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.iconBuilder,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF0B5E1C)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF0B5E1C)),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Row(
                children: [
                  if (iconBuilder != null) iconBuilder!(item),
                  if (iconBuilder != null) const SizedBox(width: 8),
                  Text(
                    item.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
} 