import 'package:flutter/material.dart';

class AIRecommendationCard extends StatelessWidget {
  const AIRecommendationCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.smart_toy, size: 20, color: Colors.black54),
            ),
            TextSpan(
              text: '  AI recommendation\n',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Initiate a savings incentive campaign for ',
              style: TextStyle(color: Colors.black87),
            ),
            TextSpan(
              text: 'B9',
              style: TextStyle(
                color: Color(0xFF0B5E1C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }
} 