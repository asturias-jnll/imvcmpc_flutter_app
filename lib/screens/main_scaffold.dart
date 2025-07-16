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
              : IndexedStack(
                  index: _selectedIndex,
                  children: const [
                    DashboardScreen(),
                    MemberDataScreen(),
                    AnalyticsScreen(),
                    ReportsScreen(),
                  ],
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
                                title: const Text('Confirm Logout'),
                                content: const Text(
                                  'Are you sure you want to log out?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text(
                                      'Logout',
                                      style: TextStyle(
                                        color: Color(0xFF0B5E1C),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                            if (shouldLogout == true) {
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
