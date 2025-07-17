import 'package:flutter/material.dart';

class UserProfileBar extends StatelessWidget {
  const UserProfileBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Color(0xFF0B5E1C)),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
        const CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, size: 28, color: Color(0xFF0B5E1C)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Marketing Clerk',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'IMVCMPC Main Branch',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}
