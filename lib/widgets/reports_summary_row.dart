import 'package:flutter/material.dart';

class ReportsSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const ReportsSummaryRow({required this.label, required this.value, super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ' 0label  -  ',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
} 