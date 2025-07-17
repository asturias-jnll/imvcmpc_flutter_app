import 'package:flutter/material.dart';
import '../theme_colors.dart';

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
                color: AppColors.limeGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.limeGreen.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: AppColors.limeGreen.withOpacity(0.18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.green.withOpacity(0.12),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.darkGreen,
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
                        icon: const Icon(Icons.edit, color: AppColors.green),
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
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppColors.limeGreen,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        c['location']!.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.limeGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.yellowGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Savings: ₱${(c['savings'] as num).toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.limeGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Disb: ₱${(c['disbursement'] as num).toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Total: ₱${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
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
