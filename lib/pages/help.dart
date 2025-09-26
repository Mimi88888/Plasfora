import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color turquoise = Color.fromARGB(255, 62, 101, 240);
    final Color lightTurquoise = Color.fromARGB(255, 151, 208, 255);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 101, 240),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Help & Support',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Stack(
          children: [
            // Background faint illustration or painter
            Positioned.fill(
              child: CustomPaint(painter: HelpSupportBackgroundPainter()),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'How can we help you today?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32),

                    // FAQ Card
                    _SupportOptionCard(
                      icon: Icons.help_outline,
                      title: 'FAQs',
                      subtitle: 'Find answers to common questions',
                      buttonText: 'View FAQs',
                      onPressed: () {
                        // TODO: navigate to FAQs page
                      },
                      accentColor: turquoise,
                    ),

                    SizedBox(height: 20),

                    // Contact Support Card
                    _SupportOptionCard(
                      icon: Icons.contact_mail_outlined,
                      title: 'Contact Support',
                      subtitle: 'Send us a message or email',
                      buttonText: 'Contact',
                      onPressed: () {
                        // TODO: navigate to Contact Support page or open email client
                      },
                      accentColor: turquoise,
                    ),

                    SizedBox(height: 20),

                    // Live Chat Card
                    _SupportOptionCard(
                      icon: Icons.chat_bubble_outline,
                      title: 'Live Chat',
                      subtitle: 'Chat with a support agent now',
                      buttonText: 'Start Chat',
                      onPressed: () {
                        // TODO: open live chat feature or screen
                      },
                      accentColor: turquoise,
                    ),

                    Spacer(),

                    // Optional footer or help info
                    Text(
                      'Need urgent assistance? Call us at +234 701 234 5678',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;
  final Color accentColor;

  const _SupportOptionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
    required this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            padding: EdgeInsets.all(14),
            child: Icon(icon, color: accentColor, size: 30),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.grey[900],
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HelpSupportBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    // Light subtle background color
    paint.color = Color(0xFFF7FCFC);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Soft abstract shapes symbolizing travel, health, and communication
    paint.color = Color.fromARGB(255, 120, 184, 229).withOpacity(0.08);

    // Oval shape for travel
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.8, size.height * 0.15),
        width: 180,
        height: 120,
      ),
      paint,
    );

    // Rounded rectangle for health cross zone
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.2, size.height * 0.7),
          width: 140,
          height: 140,
        ),
        Radius.circular(40),
      ),
      paint,
    );

    // Small circle symbolizing communication bubble
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 60, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
