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
                  titleSpacing: 0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'IMVCMPC',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          letterSpacing: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/logo.png',
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
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
                        // Account Profile info for mobile drawer (aesthetic, left-aligned, with icons and padding)
                        const SizedBox(height: 36),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Account Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(height: 18),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.person,
                                      size: 32,
                                      color: Color(0xFF0B5E1C),
                                    ),
                                  ),
                                  SizedBox(width: 14),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Marketing Clerk',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.apartment,
                                            color: Colors.white70,
                                            size: 16,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'IMVCMPC - Main Branch',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white70,
                                    size: 18,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Ibaan, Batangas',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: Colors.white70,
                                    size: 18,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'marketingclerk.main@gmail.com',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 28),
                              // Add cooperative name
                              Text(
                                'Ibaan Market Vendors & Community Multi-Purpose Cooperative',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
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
                        // Add IMVCMPC | 2025 at the very bottom, centered, with distinct color
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16, top: 8),
                          child: Center(
                            child: Text(
                              'IMVCMPC | 2025',
                              style: TextStyle(
                                color: Color(0xFFB8D53D), // distinct color
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
