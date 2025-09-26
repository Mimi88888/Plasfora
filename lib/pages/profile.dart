import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userRole;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async { 
    try {
      final role = await UserRoleService.getUserRoleFromStorage();
      setState(() {
        userRole = role;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        userRole = null;
        isLoading = false;
      });
      // Handle error appropriately
      print('Error loading user role: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return ProfilePageFactory.createProfilePage(userRole);
  }
}

// profile_page_factory.dart - Factory Pattern for Profile Pages
class ProfilePageFactory {
  static Widget createProfilePage(String? role) {
    switch (role?.toLowerCase()) {
      case 'user':
        return const UserProfilePage();
      case 'doctor':
        return const DoctorProfilePage();
      case 'admin':
        return const AdminProfilePage();
      default:
        return const UnknownRoleProfilePage();
    }
  }
}

// base_profile_page.dart - Base class for common functionality
abstract class BaseProfilePage extends StatelessWidget {
  const BaseProfilePage({Key? key}) : super(key: key);

  String get pageTitle;
  Color get primaryColor;
  
  Widget buildHeader(BuildContext context);
  Widget buildContent(BuildContext context);
  List<Widget> buildActions(BuildContext context) => [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: buildActions(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(context),
            const SizedBox(height: 24),
            buildContent(context),
          ],
        ),
      ),
    );
  }
}

// user_profile_page.dart - User Profile Implementation
class UserProfilePage extends BaseProfilePage {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  String get pageTitle => 'My Profile';

  @override
  Color get primaryColor => Colors.blue;

  @override
  Widget buildHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: primaryColor,
              child: const Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Patient', style: TextStyle(color: Colors.grey)),
                  Text('john.doe@email.com'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        _buildSectionCard(
          'Personal Information',
          Icons.person_outline,
          [
            _buildInfoTile('Age', '32 years'),
            _buildInfoTile('Gender', 'Male'),
            _buildInfoTile('Blood Type', 'O+'),
            _buildInfoTile('Phone', '+1 234 567 8900'),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          'Medical History',
          Icons.medical_services_outlined,
          [
            _buildInfoTile('Allergies', 'None'),
            _buildInfoTile('Medications', 'Aspirin, Vitamin D'),
            _buildInfoTile('Last Checkup', 'March 15, 2024'),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          'Settings',
          Icons.settings_outlined,
          [
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy Settings'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Help & Support'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          // Navigate to edit profile
        },
      ),
    ];
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

// doctor_profile_page.dart - Doctor Profile Implementation
class DoctorProfilePage extends BaseProfilePage {
  const DoctorProfilePage({Key? key}) : super(key: key);

  @override
  String get pageTitle => 'Doctor Dashboard';

  @override
  Color get primaryColor => Colors.green;

  @override
  Widget buildHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: primaryColor,
              child: const Icon(Icons.medical_services, size: 40, color: Colors.white),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Sarah Smith',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Cardiologist', style: TextStyle(color: Colors.grey)),
                  Text('Medical License: MD123456'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        _buildStatsRow(),
        const SizedBox(height: 16),
        _buildSectionCard(
          'Recent Patients',
          Icons.people_outlined,
          [
            _buildPatientTile('John Doe', 'Checkup - 2:00 PM'),
            _buildPatientTile('Jane Smith', 'Follow-up - 3:30 PM'),
            _buildPatientTile('Mike Johnson', 'Consultation - 4:00 PM'),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          'Upcoming Appointments',
          Icons.calendar_today_outlined,
          [
            _buildAppointmentTile('Today, 2:00 PM', 'John Doe - Routine Checkup'),
            _buildAppointmentTile('Today, 3:30 PM', 'Jane Smith - Follow-up'),
            _buildAppointmentTile('Tomorrow, 10:00 AM', 'Mike Johnson - Consultation'),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          'Quick Actions',
          Icons.flash_on_outlined,
          [
            ListTile(
              leading: const Icon(Icons.add_circle_outlined),
              title: const Text('Add New Patient'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.schedule_outlined),
              title: const Text('View Schedule'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart_outlined),
              title: const Text('Patient Reports'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          // Search patients
        },
      ),
      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () {
          // Show notifications
        },
      ),
    ];
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('42', 'Patients', Icons.people)),
        const SizedBox(width: 8),
        Expanded(child: _buildStatCard('8', 'Today\'s Appointments', Icons.today)),
        const SizedBox(width: 8),
        Expanded(child: _buildStatCard('15', 'This Week', Icons.date_range)),
      ],
    );
  }

  Widget _buildStatCard(String number, String label, IconData icon) {
    return Card(
      color: primaryColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 32),
            const SizedBox(height: 8),
            Text(
              number,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildPatientTile(String name, String subtitle) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: primaryColor.withOpacity(0.1),
        child: Icon(Icons.person, color: primaryColor),
      ),
      title: Text(name),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }

  Widget _buildAppointmentTile(String time, String details) {
    return ListTile(
      leading: Icon(Icons.schedule, color: primaryColor),
      title: Text(time),
      subtitle: Text(details),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

// admin_profile_page.dart - Admin Profile Implementation
class AdminProfilePage extends BaseProfilePage {
  const AdminProfilePage({Key? key}) : super(key: key);

  @override
  String get pageTitle => 'Admin Dashboard';

  @override
  Color get primaryColor => Colors.purple;

  @override
  Widget buildHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: primaryColor,
              child: const Icon(Icons.admin_panel_settings, size: 40, color: Colors.white),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admin User',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('System Administrator', style: TextStyle(color: Colors.grey)),
                  Text('admin@healthcare.com'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        _buildSystemStatsRow(),
        const SizedBox(height: 16),
        _buildSectionCard(
          'User Management',
          Icons.people_outlined,
          [
            ListTile(
              leading: const Icon(Icons.person_add_outlined),
              title: const Text('Add New User'),
              subtitle: const Text('Create doctor or patient account'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.group_outlined),
              title: const Text('Manage Users'),
              subtitle: const Text('View, edit, or deactivate users'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.security_outlined),
              title: const Text('Role Permissions'),
              subtitle: const Text('Configure user roles and access'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          'System Management',
          Icons.settings_outlined,
          [
            ListTile(
              leading: const Icon(Icons.backup_outlined),
              title: const Text('Database Backup'),
              subtitle: const Text('Schedule and manage backups'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.update_outlined),
              title: const Text('System Updates'),
              subtitle: const Text('Check for system updates'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: const Text('Error Logs'),
              subtitle: const Text('View system error reports'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          'Analytics',
          Icons.analytics_outlined,
          [
            ListTile(
              leading: const Icon(Icons.trending_up_outlined),
              title: const Text('Usage Statistics'),
              subtitle: const Text('System usage and performance'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.report_outlined),
              title: const Text('Generate Reports'),
              subtitle: const Text('Create custom system reports'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () {
          // System notifications
        },
      ),
      PopupMenuButton(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'settings',
            child: Text('System Settings'),
          ),
          const PopupMenuItem(
            value: 'logout',
            child: Text('Logout'),
          ),
        ],
        onSelected: (value) {
          // Handle menu selection
        },
      ),
    ];
  }

  Widget _buildSystemStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('1,247', 'Total Users', Icons.people)),
        const SizedBox(width: 8),
        Expanded(child: _buildStatCard('89', 'Active Doctors', Icons.medical_services)),
        const SizedBox(width: 8),
        Expanded(child: _buildStatCard('99.9%', 'Uptime', Icons.trending_up)),
      ],
    );
  }

  Widget _buildStatCard(String number, String label, IconData icon) {
    return Card(
      color: primaryColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 32),
            const SizedBox(height: 8),
            Text(
              number,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}

// unknown_role_profile_page.dart - Fallback for unknown roles
class UnknownRoleProfilePage extends StatelessWidget {
  const UnknownRoleProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Unknown User Role',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please contact support for assistance.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// user_role_service.dart - Mock service (replace with your actual service)
class UserRoleService {
  static Future<String> getUserRoleFromStorage() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Replace this with your actual implementation
    // This could read from SharedPreferences, secure storage, etc.
    return 'user'; // or 'doctor', 'admin'
  }
}