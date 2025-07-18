import 'package:flutter/material.dart';
import '../theme_colors.dart';
import 'package:intl/intl.dart';

class BranchBarData {
  final String branch;
  final String location;
  final double value;
  BranchBarData({
    required this.branch,
    required this.location,
    required this.value,
  });
}

class HorizontalBarChartCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<BranchBarData> data;
  final Color barColor;
  final bool isDisbursement;
  final bool small;
  final bool long;
  const HorizontalBarChartCard({
    super.key,
    required this.title,
    required this.icon,
    required this.data,
    required this.barColor,
    this.isDisbursement = false,
    this.small = false,
    this.long = false,
  });

  @override
  Widget build(BuildContext context) {
    final sortedData = [...data]..sort((a, b) => b.value.compareTo(a.value));
    final maxValue = sortedData.isNotEmpty ? sortedData.first.value.abs() : 1;
    final barHeight = small ? 12.0 : 22.0;
    final rowPadding = small ? 2.0 : 6.0;
    final titleFont = small ? 15.0 : 18.0;
    final branchFont = small ? 12.0 : 14.0;
    final locationFont = small ? 11.0 : 13.0;
    final valueFont = small ? 11.0 : 13.0;
    final numberFormat = NumberFormat.decimalPattern();
    return Container(
      padding: EdgeInsets.all(small ? 10 : 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7), // very light yellow
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.yellowGreen.withOpacity(0.10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      constraints: long
          ? const BoxConstraints(minWidth: 1100, maxWidth: 1300)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: barColor, size: small ? 20 : 28),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: titleFont,
                  color: isDisbursement ? Colors.red[700] : AppColors.darkGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: small ? 10 : 18),
          ...sortedData.map((d) {
            final percent = (d.value.abs() / maxValue).clamp(0.0, 1.0);
            final isDisbursementBar = isDisbursement;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: rowPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Branch code (fixed width)
                  SizedBox(
                    width: 48,
                    child: Text(
                      d.branch,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: branchFont,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // Location (fixed width)
                  SizedBox(
                    width: 140,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: isDisbursement
                              ? Colors.red[700]
                              : AppColors.limeGreen,
                          size: locationFont + 3,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            d.location,
                            style: TextStyle(
                              fontSize: locationFont,
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Bar (flexible)
                  Expanded(
                    flex: 6,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: barHeight,
                          decoration: BoxDecoration(
                            color: barColor.withOpacity(0.13),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: percent,
                          child: Container(
                            height: barHeight,
                            decoration: BoxDecoration(
                              gradient: isDisbursementBar
                                  ? LinearGradient(
                                      colors: [
                                        Colors.red.shade700,
                                        Colors.orange.shade400,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    )
                                  : LinearGradient(
                                      colors: [barColor, AppColors.limeGreen],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Value (fixed width, right-aligned)
                  SizedBox(
                    width: 70,
                    child: Text(
                      isDisbursement
                          ? '-₱${numberFormat.format(d.value.abs())}'
                          : '₱${numberFormat.format(d.value)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDisbursement
                            ? Colors.red[700]
                            : AppColors.darkGreen,
                        fontSize: valueFont,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
