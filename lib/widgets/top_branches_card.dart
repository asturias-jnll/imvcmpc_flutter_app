import 'package:flutter/material.dart';
import '../theme_colors.dart';

class TopBranchesCard extends StatelessWidget {
  const TopBranchesCard({super.key});
  @override
  Widget build(BuildContext context) {
    final branches = [
      {'name': 'IBAAN', 'branch': 'BRANCH 1 - MAIN'},
      {'name': 'CALAMIAS', 'branch': 'BRANCH 9'},
      {'name': 'ROSARIO', 'branch': 'BRANCH 7'},
      {'name': 'PADRE GARCIA', 'branch': 'BRANCH 5'},
      {'name': 'LIPA', 'branch': 'BRANCH 3'},
    ];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Branches',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.darkGreen,
            ),
          ),
          const SizedBox(height: 16),
          ...branches.asMap().entries.map((entry) {
            final b = entry.value;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.limeGreen.withOpacity(0.15),
                        child: Icon(Icons.groups, color: AppColors.green),
                      ),
                      const SizedBox(width: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.limeGreen.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          b['name']!,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            b['branch']!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (entry.key != branches.length - 1)
                  Divider(
                    height: 1,
                    color: Colors.black12,
                    indent: 10,
                    endIndent: 10,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
