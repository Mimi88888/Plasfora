import 'package:flutter/material.dart';
import '../widgets/verif_doctor.dart'; // Adjust path according to your project

// UserRoleService to manage user roles throughout the app
class UserRoleService {
  static String _userRole = "user"; // Default role

  static String get userRole => _userRole;

  static void setUserRole(String role) {
    _userRole = role;
    print('User role set to: $role'); // For debugging
  }

  static Future<String> getUserRoleFromStorage() async {
    // In a real app, you would get this from SharedPreferences or secure storage
    return _userRole;
  }

  static void clearUserRole() {
    _userRole = "user";
  }
}

// Custom styled input field with optional password toggle
class AuthFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;

  const AuthFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _AuthFormFieldState createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 62, 101, 240),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: Icon(widget.icon, color: Colors.blue.shade700),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.blue.shade700,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 62, 101, 240),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.blue.shade50,
            hintStyle: TextStyle(color: Colors.blue.shade400),
          ),
        ),
      ],
    );
  }
}

// Stateless phone number input with country code display
class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String countryCode;
  final Function(String) onCountryChanged;

  const PhoneNumberField({
    Key? key,
    required this.controller,
    required this.countryCode,
    required this.onCountryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 62, 101, 240),
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade300),
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue.shade50,
              ),
              child: Text(
                '🇹🇳 $countryCode',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 62, 101, 240),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 62, 101, 240),
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.blue.shade50,
                  hintStyle: TextStyle(color: Colors.blue.shade400),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Dropdown input with label and styling
class DropdownFormField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  const DropdownFormField({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 62, 101, 240),
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 62, 101, 240),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.blue.shade50,
          ),
          dropdownColor: Colors.white,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(color: Color.fromARGB(255, 62, 101, 240)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// Main AuthScreen widget implementing login/signup flow
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  PageController _pageController = PageController();
  int currentPage = 0;

  Map<String, dynamic>? doctorVerificationData;

  // Form controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController documentController = TextEditingController();

  String selectedCountry = 'Tunisia';
  String selectedCountryCode = '+216';
  String selectedRole = '';
  bool isTunisian = true;
  String documentType = 'CIN';

  final List<String> countries = [
    'Tunisia',
    'France',
    'Germany',
    'USA',
    'Canada',
    'UK',
  ];

  final Map<String, String> countryCodes = {
    'Tunisia': '+216',
    'France': '+33',
    'Germany': '+49',
    'USA': '+1',
    'Canada': '+1',
    'UK': '+44',
  };

  final List<String> roles = [
    'Patient',
    'Doctor',
    'Clinic Director',
    'Nurse',
    'Administrator',
  ];

  // Method to convert role to lowercase for UserRoleService
  String _convertRoleToUserRole(String role) {
    switch (role.toLowerCase()) {
      case 'patient':
        return 'user';
      case 'doctor':
        return 'doctor';
      case 'clinic director':
      case 'administrator':
        return 'admin';
      case 'nurse':
        return 'nurse'; // You can change this to 'user' if you prefer
      default:
        return 'user';
    }
  }

  // Method to handle successful signup
  void _handleSuccessfulSignup() {
    if (selectedRole.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a role to continue'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Convert the selected role to the appropriate user role
    String userRole = _convertRoleToUserRole(selectedRole);

    // Set the user role
    UserRoleService.setUserRole(userRole);

    print('Signup successful! User role set to: $userRole'); // Debug print

    // Navigate to home
    Navigator.pushReplacementNamed(context, '/home');
  }

  // Method to handle successful login
  void _handleSuccessfulLogin() {
    // For login, you would typically get the role from your backend/database
    // For now, we'll simulate this based on email for testing
    String userRole = _determineUserRoleFromEmail(emailController.text);
    UserRoleService.setUserRole(userRole);

    print('Login successful! User role set to: $userRole'); // Debug print

    Navigator.pushReplacementNamed(context, '/home');
  }

  // Helper method to determine role from email (for testing purposes)
  String _determineUserRoleFromEmail(String email) {
    String emailLower = email.toLowerCase();
    if (emailLower.contains('doctor') || emailLower.contains('dr.')) {
      return 'doctor';
    } else if (emailLower.contains('admin') ||
        emailLower.contains('administrator')) {
      return 'admin';
    } else if (emailLower.contains('nurse')) {
      return 'nurse';
    }
    return 'user';
  }

  @override
  void dispose() {
    // Clean up controllers
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    documentController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: isLogin ? _buildLoginScreen() : _buildSignUpScreen(),
      ),
    );
  }

  Widget _buildLoginScreen() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildPlasforaLogo(),
            Text(
              'Welcome to Plasfora',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 62, 101, 240),
              ),
            ),
            Text(
              'Your Medical Tourism Partner',
              style: TextStyle(fontSize: 16, color: Colors.blue.shade700),
            ),
            SizedBox(height: 40),
            _buildAuthToggle(),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 62, 101, 240),
                    ),
                  ),
                  SizedBox(height: 30),
                  AuthFormField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'Enter your email',
                    icon: Icons.email_outlined,
                  ),
                  SizedBox(height: 20),
                  AuthFormField(
                    controller: passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleSuccessfulLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 62, 101, 240),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgot_password');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 66, 128, 235),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpScreen() {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(height: 100, child: _buildPlasforaLogo()),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              if (currentPage > 0)
                IconButton(
                  onPressed: () {
                    if (currentPage > 0) {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 62, 101, 240),
                  ),
                ),
              Expanded(
                child: LinearProgressIndicator(
                  value: selectedRole == 'Doctor'
                      ? (currentPage + 1) / 6
                      : (currentPage + 1) / 5,
                  backgroundColor: Colors.blue.shade100,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 62, 101, 240),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isLogin = true;
                    currentPage = 0;
                  });
                },
                icon: Icon(Icons.close, color: Colors.grey),
              ),
            ],
          ),
        ),
        _buildAuthToggle(),
        SizedBox(height: 20),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
            children: [
              _buildNamePage(),
              _buildEmailPasswordPage(),
              _buildPhoneCountryPage(),
              _buildDocumentRolePage(),
              _buildFinalPage(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlasforaLogo() {
    return Container(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Replace with your logo asset
          Icon(
            Icons.medical_services,
            size: 80,
            color: Color.fromARGB(255, 62, 101, 240),
          ),
          // Image.asset('assets/images/plasfora.png', height: 100, width: 92),
        ],
      ),
    );
  }

  Widget _buildAuthToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isLogin = true;
                currentPage = 0;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              decoration: BoxDecoration(
                color: isLogin
                    ? Color.fromARGB(255, 62, 101, 240)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  color: isLogin ? Colors.white : Colors.blue.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isLogin = false;
                currentPage = 0;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              decoration: BoxDecoration(
                color: !isLogin
                    ? Color.fromARGB(255, 62, 101, 240)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: !isLogin ? Colors.white : Colors.blue.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNamePage() {
    return _buildFormPage(
      illustration: _buildIllustration(Icons.person_add, Colors.blue.shade700),
      title: 'Personal Information',
      subtitle: 'Let\'s get to know you better',
      children: [
        AuthFormField(
          controller: firstNameController,
          label: 'First Name',
          hint: 'Enter your first name',
          icon: Icons.person_outline,
        ),
        SizedBox(height: 20),
        AuthFormField(
          controller: lastNameController,
          label: 'Last Name',
          hint: 'Enter your last name',
          icon: Icons.person_outline,
        ),
      ],
    );
  }

  Widget _buildEmailPasswordPage() {
    return _buildFormPage(
      illustration: _buildIllustration(Icons.email, Colors.blue.shade600),
      title: 'Account Security',
      subtitle: 'Create your login credentials',
      children: [
        AuthFormField(
          controller: emailController,
          label: 'Email',
          hint: 'Enter your email',
          icon: Icons.email_outlined,
        ),
        SizedBox(height: 20),
        AuthFormField(
          controller: passwordController,
          label: 'Password',
          hint: 'Create a strong password',
          icon: Icons.lock_outline,
          isPassword: true,
        ),
      ],
    );
  }

  Widget _buildPhoneCountryPage() {
    return _buildFormPage(
      illustration: _buildIllustration(Icons.phone, Colors.blue.shade500),
      title: 'Contact Information',
      subtitle: 'How can we reach you?',
      children: [
        PhoneNumberField(
          controller: phoneController,
          countryCode: selectedCountryCode,
          onCountryChanged: (code) {
            setState(() {
              selectedCountryCode = code;
            });
          },
        ),
        SizedBox(height: 20),
        DropdownFormField(
          label: 'Country',
          value: selectedCountry,
          items: countries,
          onChanged: (value) {
            setState(() {
              selectedCountry = value!;
              selectedCountryCode = countryCodes[value]!;
              isTunisian = value == 'Tunisia';
              documentType = isTunisian ? 'CIN' : 'Passport';
            });
          },
        ),
      ],
    );
  }

  Widget _buildDocumentRolePage() {
    return _buildFormPage(
      illustration: _buildIllustration(Icons.badge, Colors.blue.shade400),
      title: 'Verification & Role',
      subtitle: 'Help us verify your identity',
      children: [
        if (isTunisian) ...[
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Document Type:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 62, 101, 240),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'CIN',
                      style: TextStyle(
                        color: documentType == 'CIN'
                            ? Color.fromARGB(255, 62, 101, 240)
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Switch(
                      value: documentType == 'CIN',
                      onChanged: (value) {
                        setState(() {
                          documentType = value ? 'CIN' : 'Passport';
                        });
                      },
                      activeColor: Color.fromARGB(255, 62, 101, 240),
                    ),
                    Text(
                      'Passport',
                      style: TextStyle(
                        color: documentType == 'Passport'
                            ? Color.fromARGB(255, 62, 101, 240)
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
        AuthFormField(
          controller: documentController,
          label: isTunisian ? '$documentType Number' : 'Passport Number',
          hint:
              'Enter your ${isTunisian ? documentType.toLowerCase() : 'passport'} number',
          icon: Icons.credit_card,
        ),
        SizedBox(height: 20),
        Text(
          'Select your role:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 62, 101, 240),
          ),
        ),
        SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: roles
              .map(
                (role) => ChoiceChip(
                  label: Text(role),
                  selected: selectedRole == role,
                  onSelected: (selected) {
                    setState(() {
                      selectedRole = selected ? role : '';
                    });
                  },
                  selectedColor: Color.fromARGB(
                    255,
                    62,
                    101,
                    240,
                  ).withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: selectedRole == role
                        ? Color.fromARGB(255, 62, 101, 240)
                        : Colors.grey[700],
                    fontWeight: selectedRole == role
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  backgroundColor: Colors.blue.shade50,
                  side: BorderSide(
                    color: selectedRole == role
                        ? Color.fromARGB(255, 62, 101, 240)
                        : Colors.blue.shade200,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildFinalPage() {
    return _buildFormPage(
      illustration: _buildIllustration(
        Icons.check_circle,
        Color.fromARGB(255, 62, 101, 240),
      ),
      title: 'Welcome to Plasfora!',
      subtitle: 'Ready to start your medical journey?',
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            children: [
              Icon(
                selectedRole == 'Doctor'
                    ? Icons.local_hospital
                    : Icons.medical_services,
                size: 40,
                color: Color.fromARGB(255, 62, 101, 240),
              ),
              SizedBox(height: 15),
              Text(
                'Review your information:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 62, 101, 240),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              _buildInfoRow(
                'Name',
                '${firstNameController.text} ${lastNameController.text}',
              ),
              _buildInfoRow('Email', emailController.text),
              _buildInfoRow(
                'Phone',
                '$selectedCountryCode ${phoneController.text}',
              ),
              _buildInfoRow('Country', selectedCountry),
              _buildInfoRow('Role', selectedRole),
              _buildInfoRow(
                'System Role',
                _convertRoleToUserRole(selectedRole),
              ),

              if (selectedRole == 'Doctor' &&
                  doctorVerificationData != null) ...[
                Divider(color: Colors.blue.shade300, thickness: 1, height: 30),
                Text(
                  'Professional Information:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 62, 101, 240),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 10),
                _buildInfoRow(
                  'Specialty',
                  doctorVerificationData!['specialty'] ?? '',
                ),
                _buildInfoRow(
                  'Registration',
                  doctorVerificationData!['registrationNumber'] ?? '',
                ),
                _buildInfoRow(
                  'Experience',
                  '${doctorVerificationData!['yearsOfExperience'] ?? 0} years',
                ),
                _buildInfoRow(
                  'Workplace',
                  doctorVerificationData!['workplace'] ?? '',
                ),
              ],
            ],
          ),
        ),
      ],
      isLastPage: true,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Color.fromARGB(255, 62, 101, 240)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormPage({
    required Widget illustration,
    required String title,
    required String subtitle,
    required List<Widget> children,
    bool isLastPage = false,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Container(height: 120, child: illustration),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 62, 101, 240),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 16, color: Colors.blue.shade600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                ...children,
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isLastPage) {
                        _handleSuccessfulSignup();
                      } else if (currentPage == 3 && selectedRole == 'Doctor') {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorVerificationScreen(
                              fullName:
                                  '${firstNameController.text} ${lastNameController.text}',
                            ),
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            doctorVerificationData = result;
                          });
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 62, 101, 240),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      isLastPage ? 'START YOUR JOURNEY' : 'NEXT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration(IconData icon, Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Icon(icon, size: 50, color: color),
    );
  }
}
