import 'package:flutter/material.dart';

class TopContributorsCard extends StatelessWidget {
  const TopContributorsCard({super.key});
  @override
  Widget build(BuildContext context) {
    final contributors = [
      {
        'name': 'Alvin Aquino',
        'branch': 'IMVCMPC - BRANCH 1',
        'location': 'IBAAN',
        'amount': '90,000',
      },
      {
        'name': 'Rita Helera',
        'branch': 'IMVCMPC - BRANCH 7',
        'location': 'ROSARIO',
        'amount': '67,000',
      },
      {
        'name': 'Jom Cortez',
        'branch': 'IMVCMPC - BRANCH 1',
        'location': 'IBAAN',
        'amount': '63,000',
      },
      {
        'name': 'Josie Calmarez',
        'branch': 'IMVCMPC - BRANCH 9',
        'location': 'CALAMIAS',
        'amount': '59,000',
      },
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
            'Top Member Contributors',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF0B5E1C),
            ),
          ),
          const SizedBox(height: 16),
          ...contributors.map(
            (c) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.person, color: Color(0xFF0B5E1C)),
                  ),
                  const SizedBox(width: 14),
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
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    c['location']!,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    c['amount']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF0B5E1C),
                    ),
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