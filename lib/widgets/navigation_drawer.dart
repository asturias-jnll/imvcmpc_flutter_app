import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import 'logout_helper.dart';

class NavigationDrawer extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onNavTap;
  final bool isMobile;
  const NavigationDrawer({
    super.key,
    required this.selectedIndex,
    required this.onNavTap,
    this.isMobile = false,
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
            leading: const Icon(Icons.account_circle, color: Colors.white70),
            title: const Text(
              'Account',
              style: TextStyle(color: Colors.white70),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const AccountProfileDialog(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white70),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white70),
            ),
            onTap: () async {
              if (isMobile) {
                Navigator.of(context, rootNavigator: true).pop();
                await Future.delayed(const Duration(milliseconds: 300));
              }
              await showLogoutDialogAndNavigate(context);
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

class AccountProfileDialog extends StatelessWidget {
  const AccountProfileDialog();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFE9EEF3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundColor: Color(0xFF0B5E1C),
              child: Icon(Icons.person, size: 44, color: Colors.white),
            ),
            const SizedBox(height: 18),
            const Text(
              'Marketing Clerk',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 6),
            const Text(
              'IMVCMPC - Main Branch',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            const Text(
              'Ibaan, Batangas',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 6),
            const Text(
              'marketingclerk.main@gmail.com',
              style: TextStyle(fontSize: 15, color: Color(0xFF0B5E1C)),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B5E1C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
