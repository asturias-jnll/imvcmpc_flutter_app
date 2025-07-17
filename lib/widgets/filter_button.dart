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
    final screenWidth = MediaQuery.of(context).size.width;
    double calcDropdownWidth() {
      if (options == null || options!.isEmpty) return 140.0;
      final textStyle = const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
      );
      double maxWidth = 0;
      final textScale = MediaQuery.of(context).textScaleFactor;
      for (final opt in options!) {
        final tp = TextPainter(
          text: TextSpan(text: opt, style: textStyle),
          maxLines: 1,
          textDirection: TextDirection.ltr,
          textScaleFactor: textScale,
        )..layout();
        if (tp.width > maxWidth) maxWidth = tp.width;
      }
      double width = maxWidth + 80;
      if (screenWidth < 600) {
        double maxAllowed = screenWidth - 32;
        if (width > maxAllowed) width = maxAllowed;
        if (width < 140) width = 140;
      } else {
        if (width > 400) width = 400;
        if (width < 180) width = 180;
      }
      return width;
    }

    final dropdownWidth = calcDropdownWidth();
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
              .map(
                (opt) => PopupMenuItem<String>(
                  value: opt,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: dropdownWidth),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      color: label == opt
                          ? Color(0xFFB8D53D).withOpacity(0.18)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Text(
                      opt,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: label == opt
                            ? Color(0xFF0B5E1C)
                            : Colors.black87,
                        fontWeight: label == opt
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              )
              .toList();
        },
        constraints: BoxConstraints(
          maxHeight: 260,
          minWidth: dropdownWidth,
          maxWidth: dropdownWidth,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.white,
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
