import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import 'dart:math' as math;

Future<void> showLogoutDialogAndNavigate(BuildContext context) async {
  final shouldLogout = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFFE9EEF3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titlePadding: const EdgeInsets.only(top: 32),
      contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      actionsPadding: const EdgeInsets.only(bottom: 24, right: 20, left: 20),
      title: Column(
        children: const [
          Icon(Icons.logout, size: 48, color: Color(0xFF0B5E1C)),
          SizedBox(height: 16),
          Text(
            'Log Out',
            style: TextStyle(
              color: Color(0xFF0B5E1C),
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Divider(height: 24, thickness: 1, color: Color(0xFFB8D53D)),
          SizedBox(height: 10),
          Text(
            'Are you sure you want to log out of your account?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF0B5E1C),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B5E1C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Log Out'),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  if (shouldLogout == true) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _SpinningLogoutLogoDialog(),
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

// Spinning logo dialog for logout (matches login loading design)
class _SpinningLogoutLogoDialog extends StatefulWidget {
  @override
  State<_SpinningLogoutLogoDialog> createState() =>
      _SpinningLogoutLogoDialogState();
}

class _SpinningLogoutLogoDialogState extends State<_SpinningLogoutLogoDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final double logoSize = isMobile ? 64 : 90;
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      content: SizedBox(
        width: isMobile ? double.infinity : 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/logo.png',
                      width: logoSize,
                      height: logoSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            const Text(
              'Logging out... Please wait',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF0B5E1C), fontSize: 16),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
