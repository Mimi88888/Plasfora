import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkModeInitial;

  const SettingsPage({Key? key, this.isDarkModeInitial = false})
    : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Settings states
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  bool _privacyEnabled = false;

  // Language options
  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Arabic',
  ];

  @override
  void initState() {
    super.initState();
    _darkModeEnabled = widget.isDarkModeInitial;
  }

  @override
  Widget build(BuildContext context) {
    final turquoise = Color.fromARGB(255, 62, 101, 240);
    final lightTurquoise = Color(0xFFBFEFEA);
    final backgroundLight = Colors.white;
    final backgroundDark = Color(0xFF121212);
    final isDark = _darkModeEnabled;

    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 101, 240),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Preferences', isDark),
            _buildToggleTile(
              icon: Icons.notifications_active_outlined,
              title: 'Notifications',
              value: _notificationsEnabled,
              onChanged: (v) => setState(() => _notificationsEnabled = v),
              color: turquoise,
              isDark: isDark,
            ),
            _buildDropdownTile(
              icon: Icons.language,
              title: 'Language',
              value: _selectedLanguage,
              items: _languages,
              onChanged: (val) => setState(() => _selectedLanguage = val!),
              color: turquoise,
              isDark: isDark,
            ),
            _buildToggleTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy',
              value: _privacyEnabled,
              onChanged: (v) => setState(() => _privacyEnabled = v),
              color: turquoise,
              isDark: isDark,
            ),
            _buildToggleTile(
              icon: isDark ? Icons.dark_mode : Icons.light_mode,
              title: 'Dark Mode',
              value: _darkModeEnabled,
              onChanged: (v) => setState(() => _darkModeEnabled = v),
              color: turquoise,
              isDark: isDark,
            ),
            SizedBox(height: 32),
            _buildFooterDetails(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text, bool isDark) => Padding(
    padding: const EdgeInsets.only(bottom: 12.0, top: 20),
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        letterSpacing: 1.2,
        color: isDark ? Colors.white70 : Colors.grey[700],
      ),
    ),
  );

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color color,
    required bool isDark,
  }) => Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[850] : Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: isDark ? Colors.black54 : Colors.grey.withOpacity(0.15),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.grey[900],
        ),
      ),
      trailing: Switch(activeColor: color, value: value, onChanged: onChanged),
    ),
  );

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required Color color,
    required bool isDark,
  }) => Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[850] : Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: isDark ? Colors.black54 : Colors.grey.withOpacity(0.15),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: DropdownButtonFormField<String>(
      value: value,
      icon: Icon(Icons.keyboard_arrow_down, color: color),
      decoration: InputDecoration(
        icon: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
        ),
        border: InputBorder.none,
      ),
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : Colors.grey[900],
        fontSize: 16,
      ),
      dropdownColor: isDark ? Colors.grey[800] : Colors.white,
      items: items
          .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
          .toList(),
      onChanged: onChanged,
    ),
  );

  Widget _buildFooterDetails(bool isDark) {
    return Center(
      child: Text(
        'Plasfora Medical Tourism\nYour trusted healthcare travel companion',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isDark ? Colors.white54 : Colors.grey[600],
          fontStyle: FontStyle.italic,
          fontSize: 14,
        ),
      ),
    );
  }
}
