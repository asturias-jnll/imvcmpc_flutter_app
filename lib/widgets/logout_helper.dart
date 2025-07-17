import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

Future<void> showLogoutDialogAndNavigate(BuildContext context) async {
  final shouldLogout = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFFE9EEF3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: const EdgeInsets.only(top: 32),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      actionsPadding: const EdgeInsets.only(bottom: 20, right: 16, left: 16),
      title: Column(
        children: const [
          Icon(Icons.logout, size: 48, color: Color(0xFF0B5E1C)),
          SizedBox(height: 16),
          Text(
            'Log Out?',
            style: TextStyle(
              color: Color(0xFF0B5E1C),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
      content: const Text(
        'Are you sure you want to log out of your account?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF0B5E1C),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0B5E1C),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Log Out'),
        ),
      ],
    ),
  );
  if (shouldLogout == true) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFE9EEF3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        content: SizedBox(
          width: 240,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(height: 8),
              CircularProgressIndicator(
                color: Color(0xFF0B5E1C),
                strokeWidth: 3,
              ),
              SizedBox(height: 24),
              Text(
                'Logging out... Please wait',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF0B5E1C),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await Future.delayed(const Duration(seconds: 1));
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(); // Close loading dialog
    }
    Future.delayed(Duration.zero, () {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    });
  }
}
