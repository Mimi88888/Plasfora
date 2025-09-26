import 'package:flutter/material.dart';

class AuthButtonsWithLogo extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onSignUpPressed;
  final String logoPath;

  const AuthButtonsWithLogo({
    super.key,
    required this.onLoginPressed,
    required this.onSignUpPressed,
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(logoPath, height: 120),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAuthButton(
              context: context,
              text: 'LOG in',
              isFilled: true,
              onPressed: onLoginPressed,
            ),
            _buildAuthButton(
              context: context,
              text: 'SIGN up',
              isFilled: false,
              onPressed: onSignUpPressed,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAuthButton({
    required BuildContext context,
    required String text,
    required bool isFilled,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: isFilled ? Theme.of(context).primaryColor : null,
        side: isFilled
            ? null
            : BorderSide(color: Theme.of(context).primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isFilled ? Colors.white : Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Common form field widget
class AuthFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? prefixText;

  const AuthFormField({
    super.key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
            prefixText: prefixText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}

// Updated Login Screen
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Bienvenue sur Plasfore'),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthButtonsWithLogo(
                logoPath: 'assets/plasfora_logo.png',
                onLoginPressed: () {},
                onSignUpPressed: () =>
                    Navigator.pushNamed(context, '/register1'),
              ),
              const SizedBox(height: 40),
              const AuthFormField(
                label: 'Username',
                hintText: 'Enter your username',
              ),
              const SizedBox(height: 20),
              const AuthFormField(
                label: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('LOG In', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Updated Registration Screen 1
class RegisterScreen1 extends StatelessWidget {
  const RegisterScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue sur Plasfore'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Créez un nouveau compte',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const AuthFormField(
                label: 'Full Name',
                hintText: 'Enter your full name',
              ),
              const SizedBox(height: 20),
              const AuthFormField(
                label: 'Email',
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              const AuthFormField(
                label: 'Username',
                hintText: 'Choose a username',
              ),
              const SizedBox(height: 20),
              const AuthFormField(
                label: 'Password',
                hintText: 'Create a password',
                obscureText: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/register2'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Continue', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Updated Registration Screen 2
class RegisterScreen2 extends StatelessWidget {
  const RegisterScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Welcome to PlasFora'),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthFormField(
                label: 'Username',
                hintText: 'Choose a username',
              ),
              const SizedBox(height: 20),
              const AuthFormField(
                label: 'Password',
                hintText: 'Create a password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              const AuthFormField(
                label: 'Phone Number',
                hintText: 'XX XXX XXX',
                prefixText: '+216 ',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Tunisian Citizen',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Switch(value: true, onChanged: (value) {}),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Document Type',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('CIN (Tunisian ID)', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                'For Tunisian citizens, CIN is required',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              const AuthFormField(
                label: 'CIN Number',
                hintText: 'Enter your CIN number',
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
