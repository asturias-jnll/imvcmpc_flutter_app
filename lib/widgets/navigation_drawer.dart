import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

class NavigationDrawer extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onNavTap;
  const NavigationDrawer({
    super.key,
    required this.selectedIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      _NavItem(Icons.home, 'Home'),
      _NavItem(Icons.groups, 'Member Data'),
      _NavItem(Icons.bar_chart, 'Analytics'),
      _NavItem(Icons.event_note, 'Reports'),
    ];
    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: Color(0xFF0B5E1C),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
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
          ...List.generate(navItems.length, (i) {
            final item = navItems[i];
            final selected = i == selectedIndex;
            return ListTile(
              leading: Icon(
                item.icon,
                color: selected ? Colors.white : Colors.white70,
              ),
              title: Text(
                item.label,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.white70,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              selected: selected,
              selectedTileColor: const Color(0xFF166B2E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () => onNavTap(i),
            );
          }),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white70),
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white70),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white70),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white70),
            ),
            onTap: () async {
              // Always close the drawer (or any overlay) first
              Navigator.of(context, rootNavigator: true).pop();
              // Wait for the drawer to close
              await Future.delayed(const Duration(milliseconds: 300));
              // Now show the logout dialog
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
                if (Navigator.of(context, rootNavigator: true).canPop()) {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pop(); // Close loading dialog
                }
                Future.delayed(Duration.zero, () {
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                });
              }
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  _NavItem(this.icon, this.label);
}
