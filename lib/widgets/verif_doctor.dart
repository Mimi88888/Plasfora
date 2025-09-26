import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class DoctorVerificationScreen extends StatefulWidget {
  final String fullName;

  const DoctorVerificationScreen({Key? key, required this.fullName})
    : super(key: key);

  @override
  State<DoctorVerificationScreen> createState() =>
      _DoctorVerificationScreenState();
}

class _DoctorVerificationScreenState extends State<DoctorVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _specialtyController = TextEditingController();
  final _registrationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _biographyController = TextEditingController();

  String? _selectedWorkplace;
  File? _verificationDocument;
  String? _documentFileName;
  Uint8List? _verificationDocumentBytes; // For web platform
  bool _isUploading = false; // Add loading state

  // Medical specialties for Tunisia
  final List<String> _specialties = [
    'Cardiology',
    'Dermatology',
    'Gastroenterology',
    'Gynecology-Obstetrics',
    'General Medicine',
    'Neurology',
    'Ophthalmology',
    'Orthopedics',
    'Otolaryngology (ENT)',
    'Pediatrics',
    'Psychiatry',
    'Radiology',
    'Rheumatology',
    'Urology',
    'Anesthesia-Resuscitation',
    'General Surgery',
    'Plastic and Aesthetic Surgery',
    'Dentistry',
    'Endocrinology',
    'Hematology',
    'Nephrology',
    'Oncology',
    'Pneumology',
  ];

  final List<String> _workplaceOptions = [
    'Private Clinic',
    'Public Hospital',
    'Private Practice',
    'Medical Center',
  ];

  @override
  void dispose() {
    _specialtyController.dispose();
    _registrationController.dispose();
    _experienceController.dispose();
    _biographyController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument() async {
    if (_isUploading) return; // Prevent multiple simultaneous uploads

    setState(() {
      _isUploading = true;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
        withData: kIsWeb, // Load bytes for web, path for mobile
        withReadStream: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.single;

        // Check file size (5MB limit)
        final fileSize = file.size;
        const maxSize = 5 * 1024 * 1024; // 5MB in bytes

        if (fileSize > maxSize) {
          throw Exception('File is too large. Maximum size: 5MB');
        }

        // Validate file extension
        final fileName = file.name.toLowerCase();
        final validExtensions = ['pdf', 'jpg', 'jpeg', 'png'];
        final hasValidExtension = validExtensions.any(
          (ext) => fileName.endsWith('.$ext'),
        );

        if (!hasValidExtension) {
          throw Exception('Unsupported file format. Use: PDF, JPG, JPEG, PNG');
        }

        if (kIsWeb) {
          // For web platform
          if (file.bytes == null) {
            throw Exception('Unable to read the selected file');
          }

          setState(() {
            _verificationDocumentBytes = file.bytes;
            _verificationDocument = null; // Not available on web
            _documentFileName = file.name;
          });
        } else {
          // For mobile platforms
          if (file.path == null) {
            throw Exception('Unable to access the selected file');
          }

          final selectedFile = File(file.path!);

          // Validate file existence
          if (!await selectedFile.exists()) {
            throw Exception('The selected file does not exist');
          }

          setState(() {
            _verificationDocument = selectedFile;
            _verificationDocumentBytes = null; // Not needed for mobile
            _documentFileName = file.name;
          });
        }

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Document uploaded successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      print('File picker error: $e'); // For debugging

      String errorMessage;
      if (e.toString().contains('User canceled')) {
        // User cancelled - don't show error
        return;
      } else if (e is Exception) {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      } else {
        errorMessage = 'Error selecting file. Please try again.';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  void _removeDocument() {
    setState(() {
      _verificationDocument = null;
      _verificationDocumentBytes = null;
      _documentFileName = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Document removed'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onContinue() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedWorkplace == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select your workplace'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_verificationDocument == null && _verificationDocumentBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please upload a verification document'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Validate document still exists (only for mobile)
      if (!kIsWeb &&
          _verificationDocument != null &&
          !await _verificationDocument!.exists()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'The selected document is no longer accessible. Please select another one.',
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _verificationDocument = null;
          _verificationDocumentBytes = null;
          _documentFileName = null;
        });
        return;
      }

      // Collect all doctor verification data
      final doctorData = {
        'fullName': widget.fullName,
        'specialty': _specialtyController.text,
        'registrationNumber': _registrationController.text,
        'yearsOfExperience': int.parse(_experienceController.text),
        'workplace': _selectedWorkplace,
        'biography': _biographyController.text,
        'verificationDocument': _verificationDocument,
        'verificationDocumentBytes': _verificationDocumentBytes,
        'documentFileName': _documentFileName,
        'isWeb': kIsWeb,
      };

      // Navigate to home page instead of confirmation
      try {
        // You can either use pushReplacementNamed to replace the current screen
        // or pushNamedAndRemoveUntil to clear the entire navigation stack
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home', // or whatever your home route is
          (route) => false, // This removes all previous routes
        );

        // Alternative: if you want to replace just this screen:
        // Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Navigation error. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 62, 101, 240),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Doctor Verification',
          style: TextStyle(
            color: Color.fromARGB(255, 62, 101, 240),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                children: [
                  _buildProgressStep(true, '1'),
                  _buildProgressLine(true),
                  _buildProgressStep(true, '2'),
                  _buildProgressLine(false),
                  _buildProgressStep(false, '3'),
                ],
              ),
            ),

            // Header Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_hospital,
                        color: Color.fromARGB(255, 62, 101, 240),
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Professional Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 62, 101, 240),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please complete your medical information for professional profile verification.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),

            // Form Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full Name Display
                    _buildSectionTitle('Full Name'),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        widget.fullName,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Specialty
                    _buildSectionTitle('Medical Specialty'),
                    _buildAutocompleteField(
                      controller: _specialtyController,
                      options: _specialties,
                      hintText: 'Select your specialty',
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Specialty is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Registration Number
                    _buildSectionTitle('Medical License Number'),
                    _buildTextField(
                      controller: _registrationController,
                      hintText: 'Ex: TN123456789',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'License number is required';
                        }
                        if (value!.length < 8) {
                          return 'Invalid license number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Years of Experience
                    _buildSectionTitle('Years of Experience'),
                    _buildTextField(
                      controller: _experienceController,
                      hintText: 'Ex: 5',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Years of experience is required';
                        }
                        final years = int.tryParse(value!);
                        if (years == null || years < 0 || years > 50) {
                          return 'Please enter a valid number (0-50)';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Workplace
                    _buildSectionTitle('Workplace'),
                    _buildWorkplaceSelector(),
                    SizedBox(height: 20),

                    // Document Upload
                    _buildSectionTitle('Verification Document'),
                    _buildDocumentUpload(),
                    SizedBox(height: 20),

                    // Biography
                    _buildSectionTitle('Professional Biography'),
                    _buildTextField(
                      controller: _biographyController,
                      hintText:
                          'Briefly describe your background and expertise...',
                      maxLines: 4,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Biography is required';
                        }
                        if (value!.length < 50) {
                          return 'Biography must contain at least 50 characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 62, 101, 240),
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(bool active, String number) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: active ? Color.fromARGB(255, 62, 101, 240) : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            color: active ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressLine(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        margin: EdgeInsets.symmetric(horizontal: 10),
        color: active ? Color.fromARGB(255, 62, 101, 240) : Colors.grey[300],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 62, 101, 240),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 62, 101, 240),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }

  Widget _buildAutocompleteField({
    required TextEditingController controller,
    required List<String> options,
    required String hintText,
    String? Function(String?)? validator,
  }) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return options.where((String option) {
          return option.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          );
        });
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
            textEditingController.text = controller.text;
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              validator: validator,
              onChanged: (value) {
                controller.text = value;
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 62, 101, 240),
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[500],
                ),
              ),
            );
          },
      onSelected: (String selection) {
        controller.text = selection;
      },
    );
  }

  Widget _buildWorkplaceSelector() {
    return Column(
      children: _workplaceOptions.map((option) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedWorkplace = option;
            });
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: _selectedWorkplace == option
                  ? Color.fromARGB(255, 62, 101, 240).withOpacity(0.1)
                  : Colors.grey[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _selectedWorkplace == option
                    ? Color.fromARGB(255, 62, 101, 240)
                    : Colors.grey[300]!,
                width: _selectedWorkplace == option ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _selectedWorkplace == option
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: _selectedWorkplace == option
                      ? Color.fromARGB(255, 62, 101, 240)
                      : Colors.grey[500],
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedWorkplace == option
                          ? Color.fromARGB(255, 62, 101, 240)
                          : Colors.grey[700],
                      fontWeight: _selectedWorkplace == option
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDocumentUpload() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:
              (_verificationDocument != null ||
                  _verificationDocumentBytes != null)
              ? Color.fromARGB(255, 62, 101, 240)
              : Colors.grey[300]!,
          style: BorderStyle.solid,
        ),
      ),
      child: _verificationDocument != null || _verificationDocumentBytes != null
          ? Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 40),
                SizedBox(height: 10),
                Text(
                  _documentFileName ?? 'Document uploaded',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: _isUploading ? null : _pickDocument,
                      icon: Icon(
                        _isUploading ? Icons.hourglass_empty : Icons.refresh,
                        color: _isUploading
                            ? Colors.grey
                            : Color.fromARGB(255, 62, 101, 240),
                      ),
                      label: Text(
                        _isUploading ? 'Loading...' : 'Replace',
                        style: TextStyle(
                          color: _isUploading
                              ? Colors.grey
                              : Color.fromARGB(255, 62, 101, 240),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _isUploading ? null : _removeDocument,
                      icon: Icon(
                        Icons.delete,
                        color: _isUploading ? Colors.grey : Colors.red,
                      ),
                      label: Text(
                        'Remove',
                        style: TextStyle(
                          color: _isUploading ? Colors.grey : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Column(
              children: [
                Icon(
                  _isUploading
                      ? Icons.hourglass_empty
                      : Icons.cloud_upload_outlined,
                  color: _isUploading
                      ? Colors.grey
                      : Color.fromARGB(255, 62, 101, 240),
                  size: 40,
                ),
                SizedBox(height: 15),
                Text(
                  _isUploading ? 'Loading...' : 'Upload Document',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _isUploading
                        ? Colors.grey
                        : Color.fromARGB(255, 62, 101, 240),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Diploma, medical license, or other certificate',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'PDF, JPG, PNG (Max 5MB)',
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
                SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: _isUploading ? null : _pickDocument,
                  icon: Icon(
                    _isUploading ? Icons.hourglass_empty : Icons.attach_file,
                    size: 18,
                  ),
                  label: Text(_isUploading ? 'Loading...' : 'Choose File'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isUploading
                        ? Colors.grey
                        : Color.fromARGB(255, 62, 101, 240),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
