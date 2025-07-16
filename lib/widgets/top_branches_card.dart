import 'package:flutter/material.dart';

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
          const Text(
            'Top Branches',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF0B5E1C),
            ),
          ),
          const SizedBox(height: 16),
          ...branches.map(
            (b) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.groups, color: Color(0xFF0B5E1C)),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        b['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
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
          ),
        ],
      ),
    );
  }
} 