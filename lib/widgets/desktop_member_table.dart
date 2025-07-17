import 'package:flutter/material.dart';
import '../theme_colors.dart';

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
    final isNarrow = MediaQuery.of(context).size.width < 900;
    return Column(
      children: [
        // Table header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.limeGreen.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.limeGreen.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 40), // Avatar
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Align(
                      alignment: Alignment.center, // Header stays centered
                      child: Text(
                        'NAME',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreen,
                          fontSize: isNarrow ? 10 : 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: isNarrow ? 140 : 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.center, // Header stays centered
                      child: Text(
                        'BRANCH',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreen,
                          fontSize: isNarrow ? 10 : 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: isNarrow ? 120 : 180,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.center, // Header stays centered
                      child: Text(
                        'LOCATION',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreen,
                          fontSize: isNarrow ? 10 : 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: isNarrow ? 90 : 110,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'SAVINGS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreen,
                          fontSize: isNarrow ? 10 : 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: isNarrow ? 90 : 110,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'DISBURSEMENT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreen,
                          fontSize: isNarrow ? 10 : 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: isNarrow ? 90 : 120,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'TOTAL',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreen,
                          fontSize: isNarrow ? 10 : 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 40), // Edit
                const SizedBox(width: 40), // Delete
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.limeGreen.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.green.withOpacity(0.12),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.darkGreen,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Align(
                        alignment: Alignment.centerLeft, // Content left-aligned
                        child: Text(
                          c['name']!.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: isNarrow ? 12 : 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isNarrow ? 140 : 200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft, // Content left-aligned
                        child: Text(
                          c['branch']!.toString(),
                          style: TextStyle(
                            fontSize: isNarrow ? 11 : 13,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isNarrow ? 120 : 180,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft, // Content left-aligned
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.start, // Content left-aligned
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 15,
                              color: AppColors.limeGreen,
                            ),
                            const SizedBox(width: 3),
                            Flexible(
                              child: Text(
                                c['location']!.toString(),
                                style: TextStyle(
                                  fontSize: isNarrow ? 11 : 13,
                                  color: AppColors.limeGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isNarrow ? 90 : 110,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.center, // Content centered
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.yellowGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '₱ ${(c['savings'] as num).toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isNarrow ? 90 : 110,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.center, // Content centered
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.limeGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '₱ ${(c['disbursement'] as num).toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isNarrow ? 90 : 120,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.center, // Content centered
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '₱ ${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: AppColors.green),
                      onPressed: onEdit != null ? () => onEdit!(c, idx) : null,
                      tooltip: 'Edit',
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete != null ? () => onDelete!(idx) : null,
                      tooltip: 'Delete',
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
