import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/drawer_item.dart';
import '../widgets/auth_screen.dart';
import '../pages/process.dart';
import '../pages/profile.dart';

// Service class to manage user role
class UserRoleService {
  static String _userRole = "user"; // Default role

  static String get userRole => _userRole;

  static void setUserRole(String role) {
    _userRole = role;
  }

  static Future<String> getUserRoleFromStorage() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _userRole;
  }
}

// Main Screen using IndexedStack approach (Recommended)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Navigation method for drawer items
  void _navigateToPage(String pageName) {
    Navigator.pop(context); // Close drawer

    switch (pageName.toLowerCase().replaceAll(' ', '_')) {
      case 'plastic_surgery':
        Navigator.pushNamed(context, '/plastic_surgery');
        break;
      case 'dentistry':
        Navigator.pushNamed(context, '/dentistry');
        break;
      case 'hair_transplant':
        Navigator.pushNamed(context, '/hair_transplant');
        break;
      case 'ivf':
        Navigator.pushNamed(context, '/ivf');
        break;
      case 'healthy_holiday':
        Navigator.pushNamed(context, '/healthy_holiday');
        break;
      case 'general_treatment':
        Navigator.pushNamed(context, '/general_treatment');
        break;
      case 'medical_booking':
        Navigator.pushNamed(context, '/medical_booking');
        break;
      case 'travel_assistance':
        Navigator.pushNamed(context, '/travel_assistance');
        break;
      case 'additional_services':
        Navigator.pushNamed(context, '/additional_services');
        break;
      case 'contact_us':
        Navigator.pushNamed(context, '/contact_us');
        break;
      case 'visit_tunisia':
        Navigator.pushNamed(context, '/visit_tunisia');
        break;
      case 'process':
        // Switch to Process tab instead of navigating
        setState(() {
          _currentIndex = 1; // Assuming Process is at index 1
        });
        break;
      case 'logout':
        _handleLogout();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Page $pageName en cours de développement')),
        );
    }
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/auth_screen',
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  List<MenuItem> get menuItems => [
    MenuItem(
      title: 'Specialties',
      icon: Icons.medical_services,
      children: [
        MenuItem(
          title: 'Plastic Surgery',
          icon: Icons.face,
          onTap: () => _navigateToPage('Plastic Surgery'),
        ),
        MenuItem(
          title: 'Dentistry',
          icon: Icons.medical_information,
          onTap: () => _navigateToPage('Dentistry'),
        ),
        MenuItem(
          title: 'Hair Transplant',
          icon: Icons.cut,
          onTap: () => _navigateToPage('Hair Transplant'),
        ),
        MenuItem(
          title: 'IVF',
          icon: Icons.family_restroom,
          onTap: () => _navigateToPage('IVF'),
        ),
        MenuItem(
          title: 'Healthy Holiday',
          icon: Icons.beach_access,
          onTap: () => _navigateToPage('Healthy Holiday'),
        ),
        MenuItem(
          title: 'General Treatment',
          icon: Icons.local_hospital,
          onTap: () => _navigateToPage('General Treatment'),
        ),
      ],
    ),
    MenuItem(
      title: 'Services',
      icon: Icons.design_services,
      children: [
        MenuItem(
          title: 'Medical Booking',
          icon: Icons.calendar_today,
          onTap: () => _navigateToPage('Medical Booking'),
        ),
        MenuItem(
          title: 'Travel Assistance',
          icon: Icons.flight_takeoff,
          onTap: () => _navigateToPage('Travel Assistance'),
        ),
        MenuItem(
          title: 'Additional Services',
          icon: Icons.miscellaneous_services,
          onTap: () => _navigateToPage('Additional Services'),
        ),
      ],
    ),
    MenuItem(
      title: 'Resources',
      icon: Icons.book,
      children: [
        MenuItem(
          title: 'Visit Tunisia',
          icon: Icons.place,
          onTap: () => _navigateToPage('Visit Tunisia'),
        ),
        MenuItem(
          title: 'WikiMed',
          icon: Icons.wifi_lock,
          onTap: () => _navigateToPage('wiki_med'),
        ),
        MenuItem(
          title: 'Blogs',
          icon: Icons.health_and_safety,
          onTap: () => _navigateToPage('blogs'),
        ),
      ],
    ),
    MenuItem(
      title: 'Process',
      icon: Icons.timeline,
      onTap: () => _navigateToPage('process'),
    ),
    MenuItem(
      title: 'Contact Us',
      icon: Icons.contact_mail,
      onTap: () => _navigateToPage('Contact Us'),
    ),
  ];

  // Get the correct title based on current index and user role
  String _getPageTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Plasfora Services';
      case 1:
        return 'Process';
      case 2:
        return 'Chat';
      case 3:
        return 'Map';
      case 4:
        final userRole = UserRoleService.userRole;
        switch (userRole) {
          case 'doctor':
            return 'Doctor Dashboard';
          case 'admin':
            return 'Admin Dashboard';
          case 'user':
          default:
            return 'My Profile';
        }
      default:
        return 'Plasfora Services';
    }
  }

  // List of pages for IndexedStack
  List<Widget> get _pages => [
    const HomePage(),
    const ProcessPage(),
    const ChatPage(),
    const MapPage(),
    const ProfilePage(), // This will automatically handle role-based UI
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          _getPageTitle(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Plasfora Services',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Medical Tourism Platform',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                ...menuItems.map((item) => DrawerItem(item: item)),
                const Divider(),
              ],
            ),
          ),
          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: ElevatedButton.icon(
              onPressed: _handleLogout,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: const Color.fromARGB(255, 62, 101, 240),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color.fromARGB(255, 62, 101, 240),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: const [
        BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Iconsax.activity), label: 'Process'),
        BottomNavigationBarItem(icon: Icon(Iconsax.message), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Iconsax.map), label: 'Map'),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.profile_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}

// Legacy MainLayout for backward compatibility (if needed)
class MainLayout extends StatefulWidget {
  final Widget child;
  final String title;
  final int bottomNavIndex;

  const MainLayout({
    super.key,
    required this.child,
    required this.title,
    this.bottomNavIndex = 0,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  void _navigateToPage(String pageName) {
    Navigator.pop(context);

    switch (pageName.toLowerCase().replaceAll(' ', '_')) {
      case 'plastic_surgery':
        Navigator.pushNamed(context, '/plastic_surgery');
        break;
      case 'dentistry':
        Navigator.pushNamed(context, '/dentistry');
        break;
      case 'hair_transplant':
        Navigator.pushNamed(context, '/hair_transplant');
        break;
      case 'ivf':
        Navigator.pushNamed(context, '/ivf');
        break;
      case 'healthy_holiday':
        Navigator.pushNamed(context, '/healthy_holiday');
        break;
      case 'general_treatment':
        Navigator.pushNamed(context, '/general_treatment');
        break;
      case 'medical_booking':
        Navigator.pushNamed(context, '/medical_booking');
        break;
      case 'travel_assistance':
        Navigator.pushNamed(context, '/travel_assistance');
        break;
      case 'additional_services':
        Navigator.pushNamed(context, '/additional_services');
        break;
      case 'contact_us':
        Navigator.pushNamed(context, '/contact_us');
        break;
      case 'visit_tunisia':
        Navigator.pushNamed(context, '/visit_tunisia');
        break;
      case 'process':
        Navigator.pushNamed(context, '/process');
        break;
      case 'logout':
        Navigator.pushNamed(context, '/auth_screen');
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Page $pageName en cours de développement')),
        );
    }
  }

  List<MenuItem> get menuItems => [
    MenuItem(
      title: 'Specialties',
      icon: Icons.medical_services,
      children: [
        MenuItem(
          title: 'Plastic Surgery',
          icon: Icons.face,
          onTap: () => _navigateToPage('Plastic Surgery'),
        ),
        MenuItem(
          title: 'Dentistry',
          icon: Icons.medical_information,
          onTap: () => _navigateToPage('Dentistry'),
        ),
        MenuItem(
          title: 'Hair Transplant',
          icon: Icons.cut,
          onTap: () => _navigateToPage('Hair Transplant'),
        ),
        MenuItem(
          title: 'IVF',
          icon: Icons.family_restroom,
          onTap: () => _navigateToPage('IVF'),
        ),
        MenuItem(
          title: 'Healthy Holiday',
          icon: Icons.beach_access,
          onTap: () => _navigateToPage('Healthy Holiday'),
        ),
        MenuItem(
          title: 'General Treatment',
          icon: Icons.local_hospital,
          onTap: () => _navigateToPage('General Treatment'),
        ),
      ],
    ),
    MenuItem(
      title: 'Services',
      icon: Icons.design_services,
      children: [
        MenuItem(
          title: 'Medical Booking',
          icon: Icons.calendar_today,
          onTap: () => _navigateToPage('Medical Booking'),
        ),
        MenuItem(
          title: 'Travel Assistance',
          icon: Icons.flight_takeoff,
          onTap: () => _navigateToPage('Travel Assistance'),
        ),
        MenuItem(
          title: 'Additional Services',
          icon: Icons.miscellaneous_services,
          onTap: () => _navigateToPage('Additional Services'),
        ),
      ],
    ),
    MenuItem(
      title: 'Resources',
      icon: Icons.book,
      children: [
        MenuItem(
          title: 'Visit Tunisia',
          icon: Icons.place,
          onTap: () => _navigateToPage('Visit Tunisia'),
        ),
        MenuItem(
          title: 'WikiMed',
          icon: Icons.wifi_lock,
          onTap: () => _navigateToPage('wiki_med'),
        ),
        MenuItem(
          title: 'Blogs',
          icon: Icons.health_and_safety,
          onTap: () => _navigateToPage('blogs'),
        ),
      ],
    ),
    MenuItem(
      title: 'Process',
      icon: Icons.timeline,
      onTap: () => _navigateToPage('process'),
    ),
    MenuItem(
      title: 'Contact Us',
      icon: Icons.contact_mail,
      onTap: () => _navigateToPage('Contact Us'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Plasfora Services',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Medical Tourism Platform',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  ...menuItems.map((item) => DrawerItem(item: item)),
                  const Divider(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/auth_screen',
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: const Color.fromARGB(255, 62, 101, 240),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: widget.child,
      bottomNavigationBar: LegacyBottomNavigationBar(
        initialIndex: widget.bottomNavIndex,
      ),
    );
  }
}

// Legacy bottom navigation bar for backward compatibility
class LegacyBottomNavigationBar extends StatefulWidget {
  final int initialIndex;

  const LegacyBottomNavigationBar({super.key, this.initialIndex = 0});

  @override
  State<LegacyBottomNavigationBar> createState() =>
      _LegacyBottomNavigationBarState();
}

class _LegacyBottomNavigationBarState extends State<LegacyBottomNavigationBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  String _getProfileRoute() {
    final userRole = UserRoleService.userRole;
    switch (userRole) {
      case 'doctor':
        return '/doctor';
      case 'admin':
        return '/admin_dashboard';
      case 'user':
      default:
        return '/profile';
    }
  }

  void _handleNavigation(int index) {
    setState(() {
      _currentIndex = index;
    });

    String route;
    switch (index) {
      case 0:
        route = '/home';
        break;
      case 1:
        route = '/chat';
        break;
      case 2:
        route = '/map';
        break;
      case 3:
        route = _getProfileRoute();
        break;
      default:
        route = '/home';
    }

    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _handleNavigation,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color.fromARGB(255, 62, 101, 240),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: const [
        BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Iconsax.message), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Iconsax.map), label: 'Map'),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.profile_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}

// Placeholder pages - Replace these with your actual implementations
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 64, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Home Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ProcessPage extends StatelessWidget {
  const ProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timeline, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'Process Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 64, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'Chat Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'Map Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Example of how to use the UserRoleService
class AuthService {
  static void setUserRoleAfterAuth(String role) {
    UserRoleService.setUserRole(role);
  }

  static Future<void> loginUser(String email, String password) async {
    String userRole = await determineUserRole(email);
    UserRoleService.setUserRole(userRole);
  }

  static Future<String> determineUserRole(String email) async {
    if (email.contains('doctor')) return 'doctor';
    if (email.contains('admin')) return 'admin';
    return 'user';
  }
}
