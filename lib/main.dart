import 'package:flutter/material.dart';

void main() {
  runApp(const IMVCMPCDashboardApp());
}

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
    );
  }
}

// --- Login Screen ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _autoValidate = false;
  bool _isLoading = false;
  String? _generalError;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _generalError = null;
    });
    if (_formKey.currentState!.validate()) {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final isMobile = MediaQuery.of(context).size.width < 600;
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            content: SizedBox(
              width: isMobile ? double.infinity : 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: const Color(0xFF0B5E1C),
                    child: const Icon(
                      Icons.person,
                      size: 38,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Logging in as Finance Officer...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0B5E1C),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const CircularProgressIndicator(
                    color: Color(0xFF0B5E1C),
                    strokeWidth: 2.5,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      );
      // Simulate authentication delay
      await Future.delayed(const Duration(seconds: 2));
      // Fake check: username must be 'finance' and password 'password123'
      bool success =
          _usernameController.text.trim() == 'finance' &&
          _passwordController.text == 'password123';
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop(); // Close dialog
      }
      if (success) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const MainScaffold(selectedIndex: 0),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          );
        }
      } else {
        setState(() {
          _generalError = 'Invalid username or password.';
        });
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    return Scaffold(
      backgroundColor: const Color(0xFFE9EEF3),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: isDesktop ? 700 : (isMobile ? double.infinity : 400),
            margin: isMobile
                ? const EdgeInsets.symmetric(horizontal: 16)
                : null,
            padding: isDesktop
                ? const EdgeInsets.all(0)
                : const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: isDesktop
                ? Row(
                    children: [
                      // Left: Info
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 48,
                            horizontal: 32,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0B5E1C),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Finance Management System',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              SizedBox(height: 18),
                              Text(
                                'IMVCMPC',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 32,
                                  letterSpacing: 2,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Ibaan Market Vendors & Community\nMulti-Purpose Cooperative',
                                style: TextStyle(
                                  color: Color(0xFFB2E5B2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Right: Login
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 48,
                            horizontal: 32,
                          ),
                          child: Form(
                            key: _formKey,
                            autovalidateMode: _autoValidate
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    radius: 32,
                                    backgroundColor: const Color(0xFF0B5E1C),
                                    child: const Icon(
                                      Icons.person,
                                      size: 38,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                const Text(
                                  'Login as',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF0B5E1C),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                if (_generalError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Text(
                                      _generalError!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                Text(
                                  'Username',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: _usernameController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                    hintText: 'e.g. finance.officer',
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF0B5E1C),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF0B5E1C),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Username is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Password',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) =>
                                      !_isLoading ? _submit() : null,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                    hintText: 'Enter your password',
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF0B5E1C),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF0B5E1C),
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: const Color(0xFF0B5E1C),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color(0xFF0B5E1C),
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    child: const Text('Forgot Password?'),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0B5E1C),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 0,
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    onPressed: _isLoading ? null : _submit,
                                    child: const Text('LOGIN'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(0),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _autoValidate
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Finance Management System',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0B5E1C),
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                          const SizedBox(height: 18),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF0B5E1C),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: const [
                                Text(
                                  'IMVCMPC',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24,
                                    letterSpacing: 2,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Ibaan Market Vendors & Community\nMulti-Purpose Cooperative',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFB2E5B2),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Login as',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0B5E1C),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 18),
                          if (_generalError != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                _generalError!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          Text(
                            'Username',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _usernameController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[50],
                              hintText: 'e.g. finance.officer',
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0B5E1C),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0B5E1C),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) =>
                                !_isLoading ? _submit() : null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[50],
                              hintText: 'Enter your password',
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0B5E1C),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0B5E1C),
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xFF0B5E1C),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF0B5E1C),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              child: const Text('Forgot Password?'),
                            ),
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0B5E1C),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                              onPressed: _isLoading ? null : _submit,
                              child: const Text('LOGIN'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

// --- Main Scaffold with Navigation Drawer ---
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
                    NavigationDrawer(
                      selectedIndex: _selectedIndex,
                      onNavTap: _onNavTap,
                    ),
                    Expanded(
                      child: IndexedStack(
                        index: _selectedIndex,
                        children: [
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
                  children: [
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
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
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

// --- Navigation Drawer Widget ---
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
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
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

// --- Placeholder Screens ---
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final isMobile = constraints.maxWidth < 600;
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 40,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar with white background
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 28,
                  vertical: 16,
                ),
                margin: const EdgeInsets.only(bottom: 24),
                child: isMobile
                    ? Column(
                        children: [
                          _UserProfileBar(),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _FilterButton(
                                label: 'Filters',
                                options: const [
                                  'BRANCH',
                                  'SAVINGS',
                                  'DISBURSEMENT',
                                  'MONTHLY',
                                  'ANNUALLY',
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                _FilterButton(
                                  label: 'Filters',
                                  options: const [
                                    'BRANCH',
                                    'SAVINGS',
                                    'DISBURSEMENT',
                                    'MONTHLY',
                                    'ANNUALLY',
                                  ],
                                ),
                              ],
                            ),
                          ),
                          _UserProfileBar(),
                        ],
                      ),
              ),
              // Dashboard title + AI Recommendation
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Dashboard',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0B5E1C),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Welcome back!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(flex: 3, child: _AIRecommendationCard()),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0B5E1C),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Welcome back!',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 18),
                        _AIRecommendationCard(),
                      ],
                    ),
              const SizedBox(height: 24),
              // Charts Row
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _ChartCard(
                            title: 'Monthly\nSavings per Branch',
                            barHeights: [
                              80,
                              110,
                              70,
                              100,
                              120,
                              90,
                              115,
                              85,
                              105,
                              75,
                            ],
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: _ChartCard(
                            title: 'Monthly\nDisbursements per Branch',
                            barHeights: [
                              60,
                              90,
                              80,
                              110,
                              70,
                              100,
                              120,
                              90,
                              115,
                              85,
                            ],
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: _ChartCard(
                            title: 'Annual\nSavings per Branch',
                            isLine: true,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _ChartCard(
                          title: 'Monthly\nSavings per Branch',
                          barHeights: [
                            80,
                            110,
                            70,
                            100,
                            120,
                            90,
                            115,
                            85,
                            105,
                            75,
                          ],
                        ),
                        const SizedBox(height: 18),
                        _ChartCard(
                          title: 'Monthly\nDisbursements per Branch',
                          barHeights: [
                            60,
                            90,
                            80,
                            110,
                            70,
                            100,
                            120,
                            90,
                            115,
                            85,
                          ],
                        ),
                        const SizedBox(height: 18),
                        _ChartCard(
                          title: 'Annual\nSavings per Branch',
                          isLine: true,
                        ),
                      ],
                    ),
              const SizedBox(height: 32),
              // Contributors and Branches
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _TopContributorsCard()),
                        const SizedBox(width: 18),
                        SizedBox(width: 340, child: _TopBranchesCard()),
                      ],
                    )
                  : Column(
                      children: [
                        _TopContributorsCard(),
                        const SizedBox(height: 18),
                        _TopBranchesCard(),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}

class _AIRecommendationCard extends StatelessWidget {
  const _AIRecommendationCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.smart_toy, size: 20, color: Colors.black54),
            ),
            TextSpan(
              text: '  AI recommendation\n',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Initiate a savings incentive campaign for ',
              style: TextStyle(color: Colors.black87),
            ),
            TextSpan(
              text: 'B9',
              style: TextStyle(
                color: Color(0xFF0B5E1C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final bool isLine;
  final List<double>? barHeights;
  const _ChartCard({required this.title, this.isLine = false, this.barHeights});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: isLine ? 120 : 120,
            alignment: Alignment.center,
            child: isLine
                ? _SimpleLineGraph()
                : _CustomBarGraph(
                    barHeights:
                        barHeights ??
                        [80, 110, 70, 100, 120, 90, 115, 85, 105, 75],
                  ),
          ),
        ],
      ),
    );
  }
}

class _SimpleLineGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Responsive width/height for the line graph
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = 80.0;
        final points = [
          Offset(0, height * 0.75),
          Offset(width * 0.1, height * 0.5),
          Offset(width * 0.2, height * 0.7),
          Offset(width * 0.3, height * 0.3),
          Offset(width * 0.4, height * 0.6),
          Offset(width * 0.5, height * 0.2),
          Offset(width * 0.6, height * 0.5),
          Offset(width * 0.7, height * 0.3),
          Offset(width * 0.8, height * 0.75),
          Offset(width * 0.9, height * 0.5),
          Offset(width, height * 0.6),
        ];
        return SizedBox(
          width: width,
          height: height,
          child: CustomPaint(painter: _LineGraphPainter(points)),
        );
      },
    );
  }
}

class _LineGraphPainter extends CustomPainter {
  final List<Offset> points;
  _LineGraphPainter(this.points);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0B5E1C)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final path = Path();
    if (points.isNotEmpty) {
      path.moveTo(points[0].dx, points[0].dy);
      for (var i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CustomBarGraph extends StatelessWidget {
  final List<double> barHeights;
  const _CustomBarGraph({required this.barHeights});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        barHeights.length,
        (i) => Container(
          width: 18,
          height: barHeights[i],
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              colors: [Color(0xFF0B5E1C), Color(0xFFB2E5B2)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }
}

class _TopContributorsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contributors = [
      {
        'name': 'Alvin Aquino',
        'branch': 'IMVCMPC - BRANCH 1',
        'location': 'IBAAN',
        'amount': '90,000',
      },
      {
        'name': 'Rita Helera',
        'branch': 'IMVCMPC - BRANCH 7',
        'location': 'ROSARIO',
        'amount': '67,000',
      },
      {
        'name': 'Jom Cortez',
        'branch': 'IMVCMPC - BRANCH 1',
        'location': 'IBAAN',
        'amount': '63,000',
      },
      {
        'name': 'Josie Calmarez',
        'branch': 'IMVCMPC - BRANCH 9',
        'location': 'CALAMIAS',
        'amount': '59,000',
      },
    ];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Member Contributors',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF0B5E1C),
            ),
          ),
          const SizedBox(height: 16),
          ...contributors.map(
            (c) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.person, color: Color(0xFF0B5E1C)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          c['branch']!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    c['location']!,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    c['amount']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBranchesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final branches = [
      {'name': 'IBAAN', 'branch': 'BRANCH 1 - MAIN'},
      {'name': 'CALAMIAS', 'branch': 'BRANCH 9'},
      {'name': 'ROSARIO', 'branch': 'BRANCH 7'},
      {'name': 'PADRE GARCIA', 'branch': 'BRANCH 5'},
      {'name': 'LIPA', 'branch': 'BRANCH 3'},
    ];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Branches',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF0B5E1C),
            ),
          ),
          const SizedBox(height: 16),
          ...branches.map(
            (b) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.groups, color: Color(0xFF0B5E1C)),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        b['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        b['branch']!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final List<String>? options;
  final void Function(String)? onSelected;
  final bool noRightMargin;
  const _FilterButton({
    required this.label,
    this.options,
    this.onSelected,
    this.noRightMargin = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: noRightMargin
          ? EdgeInsets.zero
          : const EdgeInsets.only(right: 12),
      child: PopupMenuButton<String>(
        tooltip: label,
        onSelected: onSelected ?? (value) => print('Selected: $value'),
        itemBuilder: (context) {
          if (options == null) return [];
          return options!
              .map((opt) => PopupMenuItem<String>(value: opt, child: Text(opt)))
              .toList();
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FB),
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.tune, color: Color(0xFF0B5E1C)),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: Color(0xFF0B5E1C))),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserProfileBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Color(0xFF0B5E1C)),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, size: 28, color: Color(0xFF0B5E1C)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Finance Officer',
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

// Replace the MemberDataScreen with a stateful version and filtering logic
// --- Member Data Screen (Responsive, Improved Mobile Layout) ---
class MemberDataScreen extends StatefulWidget {
  const MemberDataScreen({super.key});
  @override
  State<MemberDataScreen> createState() => _MemberDataScreenState();
}

class _MemberDataScreenState extends State<MemberDataScreen> {
  List<Map<String, dynamic>> allContributors = [
    {
      'avatar': null,
      'name': 'Rita Helera',
      'branch': 'IMVCMPC - BRANCH 7',
      'location': 'ROSARIO',
      'savings': 34000.0,
      'disbursement': 33000.0,
    },
    {
      'avatar': null,
      'name': 'Jom Cortez',
      'branch': 'IMVCMPC - BRANCH 1',
      'location': 'IBAAN',
      'savings': 40000.0,
      'disbursement': 23000.0,
    },
    {
      'avatar': null,
      'name': 'Josie Calmarez',
      'branch': 'IMVCMPC - BRANCH 9',
      'location': 'CALAMIAS',
      'savings': 25000.0,
      'disbursement': 34000.0,
    },
    {
      'avatar': null,
      'name': 'Alvin Aquino',
      'branch': 'IMVCMPC - BRANCH 1',
      'location': 'IBAAN',
      'savings': 50000.0,
      'disbursement': 40000.0,
    },
  ];

  String? selectedBranch;
  String sortBy = 'Total';
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  List<String> get branchOptions {
    final branches = allContributors
        .map((c) => c['branch'] ?? '')
        .toSet()
        .toList();
    branches.sort();
    return ['All Branches', ...branches];
  }

  List<Map<String, dynamic>> get filteredContributors {
    var list = (selectedBranch == null || selectedBranch == 'All Branches')
        ? allContributors
        : allContributors.where((c) => c['branch'] == selectedBranch).toList();
    if (searchQuery.isNotEmpty) {
      list = list
          .where(
            (c) => c['name'].toString().toLowerCase().contains(
              searchQuery.toLowerCase(),
            ),
          )
          .toList();
    }
    list.sort((a, b) {
      switch (sortBy) {
        case 'Branch':
          return a['branch'].toString().compareTo(b['branch'].toString());
        case 'Savings':
          return (b['savings'] as num).compareTo(a['savings'] as num);
        case 'Disbursement':
          return (b['disbursement'] as num).compareTo(a['disbursement'] as num);
        case 'Total':
        default:
          final at = (a['savings'] as num) - (a['disbursement'] as num);
          final bt = (b['savings'] as num) - (b['disbursement'] as num);
          return bt.compareTo(at);
      }
    });
    return list;
  }

  void _showMemberDialog({Map<String, dynamic>? member, int? index}) {
    final isEdit = member != null && index != null;
    final nameController = TextEditingController(
      text: member?['name']?.toString() ?? '',
    );
    final savingsController = TextEditingController(
      text: member?['savings']?.toString() ?? '',
    );
    final disbursementController = TextEditingController(
      text: member?['disbursement']?.toString() ?? '',
    );

    // Branches and locations mapping
    final List<String> branches = [
      'IMVCMPC - BRANCH 1',
      'IMVCMPC - BRANCH 2',
      'IMVCMPC - BRANCH 3',
      'IMVCMPC - BRANCH 4',
      'IMVCMPC - BRANCH 5',
      'IMVCMPC - BRANCH 6',
      'IMVCMPC - BRANCH 7',
      'IMVCMPC - BRANCH 8',
      'IMVCMPC - BRANCH 9',
      'IMVCMPC - BRANCH 10',
      'IMVCMPC - BRANCH 11',
      'IMVCMPC - BRANCH 12',
    ];
    final Map<String, String> branchToLocation = {
      'IMVCMPC - BRANCH 1': 'IBAAN',
      'IMVCMPC - BRANCH 2': 'BAUAN',
      'IMVCMPC - BRANCH 3': 'SAN JOSE',
      'IMVCMPC - BRANCH 4': 'ROSARIO',
      'IMVCMPC - BRANCH 5': 'SAN JUAN',
      'IMVCMPC - BRANCH 6': 'PADRE GARCIA',
      'IMVCMPC - BRANCH 7': 'LIPA CITY',
      'IMVCMPC - BRANCH 8': 'BATANGAS CITY',
      'IMVCMPC - BRANCH 9': 'MABINI LIPA',
      'IMVCMPC - BRANCH 10': 'CALAMIAS',
      'IMVCMPC - BRANCH 11': 'LEMERY',
      'IMVCMPC - BRANCH 12': 'MATAAS NA KAHOY',
    };

    String selectedBranch = isEdit
        ? (member?['branch']?.toString() ?? branches[0])
        : branches[0];
    String selectedLocation = branchToLocation[selectedBranch]!;

    showDialog(
      context: context,
      builder: (context) {
        final isWide = MediaQuery.of(context).size.width > 600;
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            void updateLocation(String branch) {
              selectedLocation = branchToLocation[branch]!;
            }

            return AlertDialog(
              backgroundColor: const Color(0xFFE9EEF3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              content: Container(
                constraints: BoxConstraints(
                  maxWidth: isWide ? 500 : double.infinity,
                  minWidth: isWide ? 350 : double.infinity,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF0B5E1C), width: 2),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 32 : 12,
                  vertical: isWide ? 28 : 16,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B5E1C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            isEdit ? 'Edit Member' : 'Add Member',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Name
                      TextField(
                        controller: nameController,
                        enabled: !isEdit,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          filled: true,
                          fillColor: isEdit ? Colors.grey[100] : Colors.white,
                          labelStyle: TextStyle(
                            color: isEdit ? Colors.grey : Color(0xFF0B5E1C),
                            fontStyle: isEdit
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: FontWeight.normal,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                              width: 2.0,
                            ),
                          ),
                        ),
                        cursorColor: Color(0xFF0B5E1C),
                        style: TextStyle(
                          color: isEdit ? Colors.grey : Color(0xFF0B5E1C),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Branch Dropdown (add only)
                      isEdit
                          ? TextField(
                              enabled: false,
                              controller: TextEditingController(
                                text: selectedBranch,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Branch',
                                filled: true,
                                fillColor: Colors.grey[100],
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal,
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF0B5E1C),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF0B5E1C),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              cursorColor: Color(0xFF0B5E1C),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          : DropdownButtonFormField<String>(
                              value: selectedBranch,
                              items: branches
                                  .map(
                                    (b) => DropdownMenuItem(
                                      value: b,
                                      child: Text(b),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                setStateDialog(() {
                                  selectedBranch = val!;
                                  updateLocation(selectedBranch);
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Branch',
                                filled: true,
                                fillColor: Colors.white,
                                labelStyle: const TextStyle(
                                  color: Color(0xFF0B5E1C),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF0B5E1C),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF0B5E1C),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Color(0xFF0B5E1C)),
                            ),
                      const SizedBox(height: 12),
                      // Location (auto, not editable)
                      TextField(
                        enabled: false,
                        controller: TextEditingController(
                          text: selectedLocation,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Location',
                          filled: true,
                          fillColor: Colors.grey[100],
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal,
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                              width: 2.0,
                            ),
                          ),
                        ),
                        cursorColor: Color(0xFF0B5E1C),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Savings
                      TextField(
                        controller: savingsController,
                        decoration: InputDecoration(
                          labelText: 'Savings',
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(
                            color: Color(0xFF0B5E1C),
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                              width: 2.0,
                            ),
                          ),
                        ),
                        cursorColor: Color(0xFF0B5E1C),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Color(0xFF0B5E1C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Disbursement
                      TextField(
                        controller: disbursementController,
                        decoration: InputDecoration(
                          labelText: 'Disbursement',
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(
                            color: Color(0xFF0B5E1C),
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                              width: 2.0,
                            ),
                          ),
                        ),
                        cursorColor: Color(0xFF0B5E1C),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Color(0xFF0B5E1C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF0B5E1C),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
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
                  ),
                  onPressed: () {
                    if (isEdit) {
                      final updatedMember = {
                        'avatar': null,
                        'name': nameController.text.trim(),
                        'branch': selectedBranch,
                        'location': selectedLocation,
                        'savings':
                            double.tryParse(savingsController.text.trim()) ??
                            0.0,
                        'disbursement':
                            double.tryParse(
                              disbursementController.text.trim(),
                            ) ??
                            0.0,
                      };
                      setState(() {
                        allContributors[index!] = updatedMember;
                      });
                      Navigator.of(context).pop();
                      _showSuccessDialog('Updated successfully!');
                    } else {
                      final newMember = {
                        'avatar': null,
                        'name': nameController.text.trim(),
                        'branch': selectedBranch,
                        'location': selectedLocation,
                        'savings':
                            double.tryParse(savingsController.text.trim()) ??
                            0.0,
                        'disbursement':
                            double.tryParse(
                              disbursementController.text.trim(),
                            ) ??
                            0.0,
                      };
                      setState(() {
                        allContributors.add(newMember);
                      });
                      Navigator.of(context).pop();
                      _showSuccessDialog('Added successfully!');
                    }
                  },
                  child: Text(isEdit ? 'Save' : 'Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFE9EEF3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF0B5E1C),
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center, // Center the actions
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color(0xFF0B5E1C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteMember(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFE9EEF3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(16),
          child: const Text('Are you sure you want to delete this member?'),
        ),
        actionsAlignment: MainAxisAlignment.center, // Center the actions
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF0B5E1C),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              setState(() {
                allContributors.removeAt(index);
              });
              Navigator.of(context).pop();
              _showSuccessDialog('Deleted successfully!');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            if (isMobile) {
              // --- MOBILE LAYOUT ---
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Top Row: Finance Officer Bar on the right in white container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(children: [const Spacer(), _UserProfileBar()]),
                    ),
                    const SizedBox(height: 18),
                    // 2. Title
                    const Text(
                      'Member Contributors',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B5E1C),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // 3. Search (full width)
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by name',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF0B5E1C),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF0B5E1C),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF0B5E1C),
                            width: 2.0,
                          ),
                        ),
                      ),
                      cursorColor: Color(0xFF0B5E1C),
                      onChanged: (val) => setState(() => searchQuery = val),
                    ),
                    const SizedBox(height: 10),
                    // 4. Sort and Branch Filter Row
                    Row(
                      children: [
                        // Sort
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0B5E1C),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: sortBy,
                              dropdownColor: const Color(0xFF0B5E1C),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Total',
                                  child: Text('Total'),
                                ),
                                DropdownMenuItem(
                                  value: 'Branch',
                                  child: Text('Branch'),
                                ),
                                DropdownMenuItem(
                                  value: 'Savings',
                                  child: Text('Savings'),
                                ),
                                DropdownMenuItem(
                                  value: 'Disbursement',
                                  child: Text('Disbursement'),
                                ),
                              ],
                              onChanged: (val) => setState(() => sortBy = val!),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Branch Filter
                        Expanded(
                          child: _FilterButton(
                            label: selectedBranch ?? 'Filter by branch',
                            options: branchOptions,
                            onSelected: (value) {
                              setState(() {
                                selectedBranch = value;
                              });
                            },
                            noRightMargin:
                                true, // Custom prop to remove right margin
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Green header edge-to-edge with rounded corners
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Color(0x800B5E1C),
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // Rounded corners
                        ),
                        child: const Text(
                          'MEMBER CONTRIBUTORS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12), // Space before the table
                    // Member List inside white container (no header)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 0,
                      ),
                      child: _MobileMemberList(
                        contributors: filteredContributors,
                        onEdit: (member, idx) =>
                            _showMemberDialog(member: member, index: idx),
                        onDelete: (idx) => _confirmDeleteMember(idx),
                        edgeToEdgeHeader:
                            false, // Don't show header inside list
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // --- DESKTOP/TABLET LAYOUT (filter left, profile bar right) ---
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 40,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Top bar: white container with filter (left) and profile bar (right)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 28,
                        vertical: 16,
                      ),
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _FilterButton(
                            label: selectedBranch ?? 'Filter by branch',
                            options: branchOptions,
                            onSelected: (value) {
                              setState(() {
                                selectedBranch = value;
                              });
                            },
                            noRightMargin:
                                true, // Custom prop to remove right margin
                          ),
                          const Spacer(),
                          _UserProfileBar(),
                        ],
                      ),
                    ),
                    // 2. Title and search/sort row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title on the left
                        const Text(
                          'Member Contributors',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B5E1C),
                          ),
                        ),
                        const Spacer(),
                        // Search and sort on the right
                        SizedBox(
                          width: 220,
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search by name',
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0B5E1C),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0B5E1C),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            cursorColor: Color(0xFF0B5E1C),
                            style: const TextStyle(fontSize: 16),
                            onChanged: (val) =>
                                setState(() => searchQuery = val),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 48,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF0B5E1C),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: sortBy,
                                dropdownColor: const Color(0xFF0B5E1C),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Total',
                                    child: Text('Total'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Branch',
                                    child: Text('Branch'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Savings',
                                    child: Text('Savings'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Disbursement',
                                    child: Text('Disbursement'),
                                  ),
                                ],
                                onChanged: (val) =>
                                    setState(() => sortBy = val!),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // 3. Member List Table
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 0,
                      ),
                      child: _DesktopMemberTable(
                        contributors: filteredContributors,
                        onEdit: (member, idx) =>
                            _showMemberDialog(member: member, index: idx),
                        onDelete: (idx) => _confirmDeleteMember(idx),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        // Floating Action Button for Add
        Positioned(
          bottom: 24,
          right: 24,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF0B5E1C),
            foregroundColor: Colors.white,
            onPressed: () => _showMemberDialog(),
            child: const Icon(Icons.add),
            tooltip: 'Add Member',
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}

// Update _MobileMemberList and _DesktopMemberTable to accept onEdit/onDelete
class _MobileMemberList extends StatelessWidget {
  final List<Map<String, dynamic>> contributors;
  final void Function(Map<String, dynamic> member, int idx)? onEdit;
  final void Function(int idx)? onDelete;
  final bool edgeToEdgeHeader;
  const _MobileMemberList({
    required this.contributors,
    this.onEdit,
    this.onDelete,
    this.edgeToEdgeHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header REMOVED
        // Member cards
        ...contributors.asMap().entries.map((entry) {
          final c = entry.value;
          final idx = entry.key;
          final total = (c['savings'] as num) - (c['disbursement'] as num);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          Icons.person,
                          color: Color(0xFF0B5E1C),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              c['branch']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF0B5E1C)),
                        onPressed: onEdit != null
                            ? () => onEdit!(c, idx)
                            : null,
                        tooltip: 'Edit',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: onDelete != null
                            ? () => onDelete!(idx)
                            : null,
                        tooltip: 'Delete',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: ${c['location']!.toString()}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6D6D6D),
                    ),
                  ),
                  Text(
                    'Savings: ₱${(c['savings'] as num).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                  Text(
                    'Disbursement: ₱${(c['disbursement'] as num).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                  Text(
                    'Total: ₱${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _DesktopMemberTable extends StatelessWidget {
  final List<Map<String, dynamic>> contributors;
  final void Function(Map<String, dynamic> member, int idx)? onEdit;
  final void Function(int idx)? onDelete;
  const _DesktopMemberTable({
    required this.contributors,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Table header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0x800B5E1C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(width: 48), // Avatar
                Expanded(
                  child: Text(
                    'NAME',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    'BRANCH',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    'LOCATION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    'SAVINGS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    'DISBURSEMENT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    'TOTAL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 48), // Edit
                SizedBox(width: 48), // Delete
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Table rows
        ...contributors.asMap().entries.map((entry) {
          final c = entry.value;
          final idx = entry.key;
          final total = (c['savings'] as num) - (c['disbursement'] as num);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF0B5E1C),
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    c['name']!.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    c['branch']!.toString(),
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    c['location']!.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF6D6D6D),
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    '₱${(c['savings'] as num).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    '₱${(c['disbursement'] as num).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    '₱${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                ),
                SizedBox(
                  width: 48,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFF0B5E1C)),
                    onPressed: onEdit != null ? () => onEdit!(c, idx) : null,
                    tooltip: 'Edit',
                  ),
                ),
                SizedBox(
                  width: 48,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete != null ? () => onDelete!(idx) : null,
                    tooltip: 'Delete',
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final isMobile = constraints.maxWidth < 600;
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 40,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar with white background
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 28,
                  vertical: 16,
                ),
                margin: const EdgeInsets.only(bottom: 24),
                child: isMobile
                    ? Column(
                        children: [
                          _UserProfileBar(),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _FilterButton(
                                label: 'Filter by Branch',
                                options: [
                                  for (int i = 1; i <= 12; i++) 'BRANCH $i',
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _FilterButton(
                                label: 'Filter by Month',
                                options: const [
                                  'JANUARY',
                                  'FEBRUARY',
                                  'MARCH',
                                  'APRIL',
                                  'MAY',
                                  'JUNE',
                                  'JULY',
                                  'AUGUST',
                                  'SEPTEMBER',
                                  'OCTOBER',
                                  'NOVEMBER',
                                  'DECEMBER',
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _FilterButton(
                                label: 'Filter by Branch',
                                options: [
                                  for (int i = 1; i <= 12; i++) 'BRANCH $i',
                                ],
                              ),
                              const SizedBox(width: 12),
                              _FilterButton(
                                label: 'Filter by Month',
                                options: const [
                                  'JANUARY',
                                  'FEBRUARY',
                                  'MARCH',
                                  'APRIL',
                                  'MAY',
                                  'JUNE',
                                  'JULY',
                                  'AUGUST',
                                  'SEPTEMBER',
                                  'OCTOBER',
                                  'NOVEMBER',
                                  'DECEMBER',
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          _UserProfileBar(),
                        ],
                      ),
              ),
              // AI Recommendation
              _AIRecommendationCard(),
              const SizedBox(height: 24),
              // Charts and Top Branches
              isWide
                  ? IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Left column: Monthly Savings (top), Monthly Disbursements (bottom)
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 280,
                                  child: _ChartCard(
                                    title: 'Monthly\nSavings per Branch',
                                    barHeights: [
                                      80,
                                      110,
                                      70,
                                      100,
                                      120,
                                      90,
                                      115,
                                      85,
                                      105,
                                      75,
                                      95,
                                      100,
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 18),
                                SizedBox(
                                  height: 280,
                                  child: _ChartCard(
                                    title: 'Monthly\nDisbursements per Branch',
                                    barHeights: [
                                      60,
                                      90,
                                      80,
                                      110,
                                      70,
                                      100,
                                      120,
                                      90,
                                      115,
                                      85,
                                      95,
                                      105,
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 18),
                          // Right column: Annual Savings (top), Top Branches (bottom)
                          Expanded(
                            child: Column(
                              children: [
                                _ChartCard(
                                  title: 'Annual\nSavings per Branch',
                                  isLine: true,
                                ),
                                const SizedBox(height: 18),
                                _TopBranchesCard(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        _ChartCard(
                          title: 'Monthly\nSavings per Branch',
                          barHeights: [
                            80,
                            110,
                            70,
                            100,
                            120,
                            90,
                            115,
                            85,
                            105,
                            75,
                          ],
                        ),
                        const SizedBox(height: 18),
                        _ChartCard(
                          title: 'Monthly\nDisbursements per Branch',
                          barHeights: [
                            60,
                            90,
                            80,
                            110,
                            70,
                            100,
                            120,
                            90,
                            115,
                            85,
                          ],
                        ),
                        const SizedBox(height: 18),
                        _ChartCard(
                          title: 'Annual\nSavings per Branch',
                          isLine: true,
                        ),
                        const SizedBox(height: 18),
                        _TopBranchesCard(),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}

// --- Reports Screen ---
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});
  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final branches = [
    'Select Branch',
    'Branch 1 - IBAAN',
    'Branch 2 - BAUAN',
    'Branch 3 - SAN JOSE',
    'Branch 4 - ROSARIO',
    'Branch 5 - SAN JUAN',
    'Branch 6 - PADRE GARCIA',
    'Branch 7 - LIPA CITY',
    'Branch 8 - BATANGAS CITY',
    'Branch 9 - MABINI LIPA',
  ];
  final months = [
    'Select Month',
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER',
  ];
  final years = ['Select Year', '2025', '2024', '2023', '2022'];
  final types = ['Select Type', 'SAVINGS', 'DISBURSEMENT'];

  String selectedBranch = 'Select Branch';
  String selectedMonth = 'Select Month';
  String selectedYear = 'Select Year';
  String selectedType = 'Select Type';
  String selectedOption = 'Select';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Scaffold(
          backgroundColor: const Color(0xFFE9EEF3),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 40,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 28,
                        vertical: 16,
                      ),
                      margin: const EdgeInsets.only(bottom: 24),
                      child: isMobile
                          ? Column(
                              children: [
                                const Text(
                                  'Reports',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0B5E1C),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _UserProfileBar(),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Reports',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0B5E1C),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const Spacer(),
                                _UserProfileBar(),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Top row: SELECT BRANCH, SELECT MONTH, SELECT YEAR
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 40,
                    ),
                    child: isMobile
                        ? Column(
                            children: [
                              _StyledDropdown<String>(
                                value: selectedBranch,
                                items: branches,
                                onChanged: (v) =>
                                    setState(() => selectedBranch = v!),
                              ),
                              const SizedBox(height: 12),
                              _StyledDropdown<String>(
                                value: selectedMonth,
                                items: months,
                                onChanged: (v) =>
                                    setState(() => selectedMonth = v!),
                              ),
                              const SizedBox(height: 12),
                              _StyledDropdown<String>(
                                value: selectedYear,
                                items: years,
                                onChanged: (v) =>
                                    setState(() => selectedYear = v!),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: _StyledDropdown<String>(
                                  value: selectedBranch,
                                  items: branches,
                                  onChanged: (v) =>
                                      setState(() => selectedBranch = v!),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _StyledDropdown<String>(
                                  value: selectedMonth,
                                  items: months,
                                  onChanged: (v) =>
                                      setState(() => selectedMonth = v!),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _StyledDropdown<String>(
                                  value: selectedYear,
                                  items: years,
                                  onChanged: (v) =>
                                      setState(() => selectedYear = v!),
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 12),
                  // Two-column grid: left (MEMBER/SAVINGS/DISBURSEMENT), right (TYPE MEMBER/SUMMARY)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 40,
                    ),
                    child: isMobile
                        ? Column(
                            children: [
                              // Left column
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 44,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF0B5E1C,
                                        ).withOpacity(0.5),
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xFF0B5E1C),
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      onPressed: () {},
                                      child: const Text('MEMBER'),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 54,
                                    child: _TypeToggleButton(
                                      label: 'SAVINGS',
                                      icon: Icons.savings,
                                      selected: selectedType == 'SAVINGS',
                                      onTap: () => setState(
                                        () => selectedType = 'SAVINGS',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 54,
                                    child: _TypeToggleButton(
                                      label: 'DISBURSEMENT',
                                      icon: Icons.payments,
                                      selected: selectedType == 'DISBURSEMENT',
                                      onTap: () => setState(
                                        () => selectedType = 'DISBURSEMENT',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Right column
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 44,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'TYPE MEMBER.........',
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10,
                                            ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF0B5E1C),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF0B5E1C),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 116,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFF0B5E1C),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _ReportsSummaryRow(
                                            label: 'SELECTED BRANCH',
                                            value:
                                                selectedBranch ==
                                                    'Select Branch'
                                                ? '-'
                                                : selectedBranch
                                                      .split('-')
                                                      .last
                                                      .trim(),
                                          ),
                                          const SizedBox(height: 8),
                                          _ReportsSummaryRow(
                                            label: 'SELECTED DATE',
                                            value:
                                                (selectedMonth ==
                                                        'Select Month' ||
                                                    selectedYear ==
                                                        'Select Year')
                                                ? '-'
                                                : '${selectedMonth} ${selectedYear}',
                                          ),
                                          const SizedBox(height: 8),
                                          _ReportsSummaryRow(
                                            label: 'SELECTED TYPE',
                                            value: selectedType == 'Select Type'
                                                ? '-'
                                                : selectedType,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 44,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF0B5E1C,
                                          ).withOpacity(0.5),
                                          foregroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            side: const BorderSide(
                                              color: Color(0xFF0B5E1C),
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        onPressed: () {},
                                        child: const Text('MEMBER'),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 54,
                                      child: _TypeToggleButton(
                                        label: 'SAVINGS',
                                        icon: Icons.savings,
                                        selected: selectedType == 'SAVINGS',
                                        onTap: () => setState(
                                          () => selectedType = 'SAVINGS',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 54,
                                      child: _TypeToggleButton(
                                        label: 'DISBURSEMENT',
                                        icon: Icons.payments,
                                        selected:
                                            selectedType == 'DISBURSEMENT',
                                        onTap: () => setState(
                                          () => selectedType = 'DISBURSEMENT',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 44,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'TYPE MEMBER.........',
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF0B5E1C),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF0B5E1C),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 116,
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFF0B5E1C),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            _ReportsSummaryRow(
                                              label: 'SELECTED BRANCH',
                                              value:
                                                  selectedBranch ==
                                                      'Select Branch'
                                                  ? '-'
                                                  : selectedBranch
                                                        .split('-')
                                                        .last
                                                        .trim(),
                                            ),
                                            const SizedBox(height: 8),
                                            _ReportsSummaryRow(
                                              label: 'SELECTED DATE',
                                              value:
                                                  (selectedMonth ==
                                                          'Select Month' ||
                                                      selectedYear ==
                                                          'Select Year')
                                                  ? '-'
                                                  : '${selectedMonth} ${selectedYear}',
                                            ),
                                            const SizedBox(height: 8),
                                            _ReportsSummaryRow(
                                              label: 'SELECTED TYPE',
                                              value:
                                                  selectedType == 'Select Type'
                                                  ? '-'
                                                  : selectedType,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 32),
                  // Download button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 40,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF0B5E1C,
                          ).withOpacity(0.5),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () => _fakeDownloadPdf(context),
                        child: const Text(
                          'DOWNLOAD REPORT AS PDF',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
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

  Future<void> _fakeDownloadPdf(BuildContext context) async {
    double progress = 0.0;
    late StateSetter setStateDialog;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            return StatefulBuilder(
              builder: (context, setState) {
                setStateDialog = setState;
                return AlertDialog(
                  content: isMobile
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Downloading file...',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: LinearProgressIndicator(
                                value: progress,
                                color: const Color(0xFF0B5E1C),
                                backgroundColor: const Color(0xFFB2E5B2),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            SizedBox(
                              width: 180,
                              child: LinearProgressIndicator(
                                value: progress,
                                color: const Color(0xFF0B5E1C),
                                backgroundColor: const Color(0xFFB2E5B2),
                              ),
                            ),
                            const SizedBox(width: 24),
                            const Text('Downloading file...'),
                          ],
                        ),
                );
              },
            );
          },
        );
      },
    );
    // Animate progress
    const int totalMillis = 2000;
    const int interval = 20;
    int elapsed = 0;
    while (elapsed < totalMillis) {
      await Future.delayed(const Duration(milliseconds: interval));
      elapsed += interval;
      progress = elapsed / totalMillis;
      if (progress > 1.0) progress = 1.0;
      setStateDialog(() {});
    }
    Navigator.of(context).pop(); // Close progress dialog
    showDialog(
      context: context,
      builder: (context) => LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF0B5E1C),
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Downloaded successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center, // Center the actions
            actions: [
              SizedBox(
                width: isMobile ? double.infinity : null,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Color(0xFF0B5E1C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StyledDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final void Function(T?) onChanged;
  final Widget Function(T)? iconBuilder;
  const _StyledDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.iconBuilder,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF0B5E1C)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF0B5E1C)),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Row(
                children: [
                  if (iconBuilder != null) iconBuilder!(item),
                  if (iconBuilder != null) const SizedBox(width: 8),
                  Text(
                    item.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ReportsSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _ReportsSummaryRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label  -  ',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _TypeToggleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _TypeToggleButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF0B5E1C) : Colors.white,
          border: Border.all(color: const Color(0xFF0B5E1C)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : const Color(0xFF0B5E1C),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : const Color(0xFF0B5E1C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
