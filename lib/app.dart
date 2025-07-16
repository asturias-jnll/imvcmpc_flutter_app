import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

class IMVCMPCDashboardApp extends StatelessWidget {
  const IMVCMPCDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMVCMPC Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0B5E1C),
        scaffoldBackgroundColor: const Color(0xFFE9EEF3),
      ),
      home: const LoginScreen(),
      routes: {'/login': (context) => const LoginScreen()},
    );
  }
}
