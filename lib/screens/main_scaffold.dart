import 'package:flutter/material.dart';
import '../widgets/navigation_drawer.dart' as custom;
import 'dashboard_screen.dart';
import 'member_data_screen.dart';
import 'analytics_screen.dart';
import 'reports_screen.dart';

class MainScaffold extends StatefulWidget {
  final int selectedIndex;
  const MainScaffold({super.key, required this.selectedIndex});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onNavTap(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  Widget _getMobileScreen(int index) {
    switch (index) {
      case 0:
        return const DashboardScreen(key: ValueKey('dashboard'));
      case 1:
        return const MemberDataScreen(key: ValueKey('memberdata'));
      case 2:
        return const AnalyticsScreen(key: ValueKey('analytics'));
      case 3:
        return const ReportsScreen(key: ValueKey('reports'));
      default:
        return const DashboardScreen(key: ValueKey('dashboard'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 900;
        return Scaffold(
          backgroundColor: const Color(0xFFE9EEF3),
          appBar: isWide
              ? null
              : AppBar(
                  backgroundColor: const Color(0xFF0B5E1C),
                  elevation: 0,
                  title: const Text(
                    'IMVCMPC',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      letterSpacing: 1,
                    ),
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
          body: isWide
              ? Row(
                  children: [
                    custom.NavigationDrawer(
                      selectedIndex: _selectedIndex,
                      onNavTap: _onNavTap,
                    ),
                    Expanded(
                      child: IndexedStack(
                        index: _selectedIndex,
                        children: const [
                          DashboardScreen(),
                          MemberDataScreen(),
                          AnalyticsScreen(),
                          ReportsScreen(),
                        ],
                      ),
                    ),
                  ],
                )
              : AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(0.1, 0),
                      end: Offset.zero,
                    ).animate(animation);
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: _getMobileScreen(_selectedIndex),
                ),
          bottomNavigationBar: isWide
              ? null
              : BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: const Color(0xFF0B5E1C),
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white70,
                  currentIndex: _selectedIndex,
                  onTap: _onNavTap,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.groups),
                      label: 'Member Data',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bar_chart),
                      label: 'Analytics',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.event_note),
                      label: 'Reports',
                    ),
                  ],
                ),
          drawer: isWide
              ? null
              : Drawer(
                  child: Container(
                    color: const Color(0xFF0B5E1C),
                    child: Column(
                      children: [
                        const SizedBox(height: 36),
                        const Text(
                          'IMVCMPC',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 28,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ListTile(
                          leading: const Icon(
                            Icons.settings,
                            color: Colors.white70,
                          ),
                          title: const Text(
                            'Settings',
                            style: TextStyle(color: Colors.white70),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.white70,
                          ),
                          title: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white70),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            final shouldLogout = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: const Color(0xFFE9EEF3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                titlePadding: const EdgeInsets.only(top: 32),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 8,
                                ),
                                actionsPadding: const EdgeInsets.only(
                                  bottom: 20,
                                  right: 16,
                                  left: 16,
                                ),
                                title: Column(
                                  children: const [
                                    Icon(
                                      Icons.logout,
                                      size: 48,
                                      color: Color(0xFF0B5E1C),
                                    ),
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
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color(0xFF0B5E1C),
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 10,
                                      ),
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
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 28,
                                        vertical: 12,
                                      ),
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
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
                              if (Navigator.of(
                                context,
                                rootNavigator: true,
                              ).canPop()) {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();
                              }
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('/login');
                            }
                          },
                        ),
                        const Spacer(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
