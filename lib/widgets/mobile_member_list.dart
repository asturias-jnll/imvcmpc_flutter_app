import 'package:flutter/material.dart';

class MobileMemberList extends StatelessWidget {
  final List<Map<String, dynamic>> contributors;
  final void Function(Map<String, dynamic> member, int idx)? onEdit;
  final void Function(int idx)? onDelete;
  final bool edgeToEdgeHeader;
  const MobileMemberList({
    required this.contributors,
    this.onEdit,
    this.onDelete,
    this.edgeToEdgeHeader = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...contributors.asMap().entries.map((entry) {
          final c = entry.value;
          final idx = entry.key;
          final total = (c['savings'] as num) - (c['disbursement'] as num);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFF0B5E1C),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              c['branch']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF0B5E1C)),
                        onPressed: onEdit != null
                            ? () => onEdit!(c, idx)
                            : null,
                        tooltip: 'Edit',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: onDelete != null
                            ? () => onDelete!(idx)
                            : null,
                        tooltip: 'Delete',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: ${c['location']!.toString()}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6D6D6D),
                    ),
                  ),
                  Text(
                    'Savings: ₱${(c['savings'] as num).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                  Text(
                    'Disbursement: ₱${(c['disbursement'] as num).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                  Text(
                    'Total: ₱${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
