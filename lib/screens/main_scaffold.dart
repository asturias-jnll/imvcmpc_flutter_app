import 'package:flutter/material.dart';
import '../widgets/navigation_drawer.dart' as custom;
import 'dashboard_screen.dart';
import 'member_data_screen.dart';
import 'analytics_screen.dart';
import 'reports_screen.dart';
import '../widgets/logout_helper.dart';

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
                      isMobile: false,
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
              : _getMobileScreen(_selectedIndex),
          bottomNavigationBar: isWide
              ? null
              : BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: const Color(0xFF0B5E1C),
                  unselectedItemColor: Colors.black45,
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
                            await showLogoutDialogAndNavigate(context);
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
