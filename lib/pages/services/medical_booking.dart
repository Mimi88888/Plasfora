import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plasfora_app/pages/payment.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  PageController _pageController = PageController();
  int currentPage = 0;

  // Form controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String _country = '';
  String? _selectedGender;
  DateTime? _selectedDate;
  DateTime? _birthDate;
  String? _selectedService;
  String? _selectedTime;

  final List<String> _services = [
    'Plastic Surgery',
    'Dentistry',
    'Hair Transplant',
    'IVF',
    'General Treatment',
  ];

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _countries = [
    'France',
    'Tunisia',
    'Germany',
    'UK',
    'USA',
    'Canada',
  ];

  final List<String> _timeSlots = [
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
  ];

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 62, 101, 240),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _pickBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 62, 101, 240),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _validateCurrentPage()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Appointment confirmed for ${nameController.text} on ${_selectedDate != null ? DateFormat.yMMMd().format(_selectedDate!) : "N/A"} at ${_selectedTime ?? "N/A"}',
          ),
          backgroundColor: Color.fromARGB(255, 62, 101, 240),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      // Navigate back to home or show success page
      Navigator.pop(context);
    }
  }

  bool _validateCurrentPage() {
    switch (currentPage) {
      case 0:
        return nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            emailController.text.contains('@');
      case 1:
        return phoneController.text.isNotEmpty && _country.isNotEmpty;
      case 2:
        return _birthDate != null && _selectedGender != null;
      case 3:
        return _selectedService != null &&
            _selectedDate != null &&
            _selectedTime != null;
      default:
        return true;
    }
  }

  void _nextPage() {
    if (_validateCurrentPage()) {
      if (currentPage < 3) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _submit();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),

            // Header with logo and progress
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Logo
                  _buildPlasforaLogo(),
                  SizedBox(height: 20),

                  // Back button and progress
                  Row(
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
                        child: Column(
                          children: [
                            Text(
                              'Medical Booking',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 62, 101, 240),
                              ),
                            ),
                            SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: (currentPage + 1) / 4,
                              backgroundColor: Colors.blue.shade100,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 62, 101, 240),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // PageView for booking steps
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  children: [
                    _buildPersonalInfoPage(),
                    _buildContactInfoPage(),
                    _buildPersonalDetailsPage(),
                    _buildAppointmentPage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlasforaLogo() {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/plasfora.png', height: 100)),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoPage() {
    return _buildFormPage(
      illustration: _buildIllustration(
        Icons.person,
        Color.fromARGB(255, 62, 101, 240),
      ),
      title: 'Personal Information',
      subtitle: 'Tell us about yourself',
      children: [
        BookingFormField(
          controller: nameController,
          label: 'Full Name',
          hint: 'Enter your full name',
          icon: Icons.person_outline,
          isRequired: true,
        ),
        SizedBox(height: 20),
        BookingFormField(
          controller: emailController,
          label: 'Email',
          hint: 'Enter your email address',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          isRequired: true,
        ),
      ],
    );
  }

  Widget _buildContactInfoPage() {
    return _buildFormPage(
      illustration: _buildIllustration(
        Icons.phone,
        Color.fromARGB(255, 62, 101, 240),
      ),
      title: 'Contact Information',
      subtitle: 'How can we reach you?',
      children: [
        BookingFormField(
          controller: phoneController,
          label: 'Phone Number',
          hint: 'Enter your phone number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          isRequired: true,
        ),
        SizedBox(height: 20),
        BookingDropdownField(
          label: 'Country',
          value: _country.isEmpty ? null : _country,
          items: _countries,
          onChanged: (value) {
            setState(() {
              _country = value!;
            });
          },
          icon: Icons.public,
          isRequired: true,
        ),
      ],
    );
  }

  Widget _buildPersonalDetailsPage() {
    return _buildFormPage(
      illustration: _buildIllustration(
        Icons.calendar_today,
        Colors.blue.shade500,
      ),
      title: 'Personal Details',
      subtitle: 'A few more details about you',
      children: [
        BookingDateField(
          label: 'Date of Birth',
          selectedDate: _birthDate,
          onDateSelected: _pickBirthDate,
          icon: Icons.cake_outlined,
          isRequired: true,
        ),
        SizedBox(height: 20),
        BookingDropdownField(
          label: 'Gender',
          value: _selectedGender,
          items: _genders,
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
          icon: Icons.wc,
          isRequired: true,
        ),
      ],
    );
  }

  Widget _buildAppointmentPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page title
          Text(
            'Appointment Details',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 62, 101, 240),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose your service and preferred time',
            style: TextStyle(fontSize: 14, color: Colors.blue.shade600),
          ),
          const SizedBox(height: 30),

          // Medical Service dropdown
          BookingDropdownField(
            label: 'Medical Service',
            value: _selectedService,
            items: _services,
            onChanged: (value) {
              setState(() {
                _selectedService = value;
              });
            },
            icon: Icons.medical_services_outlined,
            isRequired: true,
          ),
          const SizedBox(height: 20),

          // Date + Time row with safe spacing
          LayoutBuilder(
            builder: (context, constraints) {
              final double gap = constraints.maxWidth < 360 ? 8.0 : 15.0;
              return Row(
                children: [
                  Expanded(
                    child: BookingDateField(
                      label: 'Appointment Date',
                      selectedDate: _selectedDate,
                      onDateSelected: _pickDate,
                      icon: Icons.event_outlined,
                      isRequired: true,
                    ),
                  ),
                  SizedBox(width: gap),
                  Expanded(
                    child: BookingDropdownField(
                      label: 'Time',
                      value: _selectedTime,
                      items: _timeSlots,
                      onChanged: (value) {
                        setState(() {
                          _selectedTime = value;
                        });
                      },
                      icon: Icons.access_time,
                      isRequired: true,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 30),

          // Book button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                  255,
                  62,
                  101,
                  240,
                ), // Plasfora theme
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
              ),
              child: const Text(
                "Book Appointment",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
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
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(height: 100, child: illustration),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 62, 101, 240),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.blue.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ...children,
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 62, 101, 240),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      isLastPage ? 'BOOK APPOINTMENT' : 'NEXT',
                      style: const TextStyle(
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
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Icon(icon, size: 40, color: color),
    );
  }
}

class BookingFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isRequired;

  const BookingFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.blue.shade700),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 62, 101, 240),
              ),
            ),
            if (isRequired)
              Text(' *', style: TextStyle(color: Colors.red, fontSize: 14)),
          ],
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 62, 101, 240),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.blue.shade50,
            hintStyle: TextStyle(color: Colors.blue.shade400),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  if (keyboardType == TextInputType.emailAddress &&
                      !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }
}

class BookingDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final IconData icon;
  final bool isRequired;

  const BookingDropdownField({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.icon,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.blue.shade700),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 62, 101, 240),
              ),
            ),
            if (isRequired)
              Text(' *', style: TextStyle(color: Colors.red, fontSize: 14)),
          ],
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 62, 101, 240),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.blue.shade50,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          validator: isRequired
              ? (value) {
                  return value == null ? 'This field is required' : null;
                }
              : null,
        ),
      ],
    );
  }
}

class BookingDateField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final VoidCallback onDateSelected;
  final IconData icon;
  final bool isRequired;

  const BookingDateField({
    Key? key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    required this.icon,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.blue.shade700),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 62, 101, 240),
              ),
            ),
            if (isRequired)
              Text(' *', style: TextStyle(color: Colors.red, fontSize: 14)),
          ],
        ),
        SizedBox(height: 8),
        InkWell(
          onTap: onDateSelected,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade300),
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue.shade50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? DateFormat.yMMMd().format(selectedDate!)
                      : 'Select date',
                  style: TextStyle(
                    color: selectedDate != null
                        ? Color.fromARGB(255, 62, 101, 240)
                        : Colors.blue.shade400,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: Colors.blue.shade700,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
