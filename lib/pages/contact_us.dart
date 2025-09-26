import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  final Color primaryBlue = const Color(0xFF0077CC);
  final Color lightBlue = const Color(0xFFE6F0FA);

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open link: $url')));
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Here you would normally send the form data to your backend
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Merci! Votre message a été envoyé."),
          backgroundColor: Colors.green,
        ),
      );
      _fullNameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  "Nous sommes à votre écoute",
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Contactez-nous par téléphone, e-mail ou via le formulaire ci-dessous.",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 30),

                // Contact Info + Social Row
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _contactInfoWidgets(),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _contactInfoWidgets(),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(flex: 2, child: _contactForm()),
                        ],
                      ),
                if (isMobile) ...[const SizedBox(height: 30), _contactForm()],

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _contactInfoWidgets() {
    return [
      _contactInfoRow(
        Icons.phone,
        "Téléphone",
        "+216 52 408 822",
        onTap: () => _launchURL('tel:+21652408822'),
      ),
      const SizedBox(height: 16),
      _contactInfoRow(
        Icons.email,
        "Email",
        "contact@plasfora.com",
        onTap: () => _launchURL('mailto:contact@plasfora.com'),
      ),
      const SizedBox(height: 16),
      _contactInfoRow(Icons.location_on, "Adresse", "Sousse, Tunisie"),
      const SizedBox(height: 24),
      Row(
        children: [
          _socialIcon(
            FontAwesomeIcons.whatsapp,
            Colors.green,
            'https://wa.me/21652408822',
          ),
          const SizedBox(width: 12),
          _socialIcon(
            FontAwesomeIcons.linkedin,
            const Color(0xFF0077B5),
            'https://www.linkedin.com/company/plasfora-medical',
          ),
          const SizedBox(width: 12),
          _socialIcon(
            FontAwesomeIcons.instagram,
            const Color(0xFFE4405F),
            'https://www.instagram.com/plasforamedical',
          ),
        ],
      ),
    ];
  }

  Widget _contactInfoRow(
    IconData icon,
    String label,
    String value, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: Icon(icon, color: Colors.blue.shade700),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(color: Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, Color color, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(24),
      child: CircleAvatar(
        backgroundColor: color,
        radius: 22,
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _contactForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inputField(
            controller: _fullNameController,
            label: 'Nom complet',
            icon: Icons.person,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Veuillez entrer votre nom complet';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _inputField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null ||
                  !RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                return 'Veuillez entrer un email valide';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _inputField(
            controller: _phoneController,
            label: 'Téléphone',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().length < 8) {
                return 'Veuillez entrer un numéro valide';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _inputField(
            controller: _subjectController,
            label: 'Sujet',
            icon: Icons.subject,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Veuillez entrer un sujet';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _inputField(
            controller: _messageController,
            label: 'Message',
            icon: Icons.message,
            maxLines: 5,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Veuillez entrer un message';
              }
              return null;
            },
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Envoyer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryBlue, width: 2.5),
        ),
      ),
    );
  }
}
