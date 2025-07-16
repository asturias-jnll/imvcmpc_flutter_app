import 'package:flutter/material.dart';

class DesktopMemberTable extends StatelessWidget {
  final List<Map<String, dynamic>> contributors;
  final void Function(Map<String, dynamic> member, int idx)? onEdit;
  final void Function(int idx)? onDelete;
  const DesktopMemberTable({
    required this.contributors,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Table header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0x800B5E1C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(width: 48), // Avatar
                Expanded(
                  child: Text(
                    'NAME',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    'BRANCH',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    'LOCATION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    'SAVINGS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    'DISBURSEMENT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    'TOTAL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 48), // Edit
                SizedBox(width: 48), // Delete
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Table rows
        ...contributors.asMap().entries.map((entry) {
          final c = entry.value;
          final idx = entry.key;
          final total = (c['savings'] as num) - (c['disbursement'] as num);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF0B5E1C),
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    c['name']!.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    c['branch']!.toString(),
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    c['location']!.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF6D6D6D),
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    '₱${(c['savings'] as num).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    '₱${(c['disbursement'] as num).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    '₱${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                ),
                SizedBox(
                  width: 48,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFF0B5E1C)),
                    onPressed: onEdit != null ? () => onEdit!(c, idx) : null,
                    tooltip: 'Edit',
                  ),
                ),
                SizedBox(
                  width: 48,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete != null ? () => onDelete!(idx) : null,
                    tooltip: 'Delete',
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
