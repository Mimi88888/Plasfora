import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({Key? key}) : super(key: key);

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  // Example user data
  final String name = 'Amina Okafor';
  final String email = 'amina.okafor@example.com';
  final String location = 'Lagos, Nigeria';
  final String avatarUrl =
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800&q=80&auto=format&fit=crop';

  @override
  Widget build(BuildContext context) {
    final Color turquoise = Color.fromARGB(
      255,
      135,
      192,
      235,
    ); // light turquoise
    final Color turquoiseAccent = Color.fromARGB(255, 62, 101, 240);
    final double avatarSize = 110;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: BackgroundMotifPainter()),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 48),

                  // Avatar
                  Center(
                    child: Container(
                      width: avatarSize + 8,
                      height: avatarSize + 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            turquoiseAccent.withOpacity(0.14),
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 16,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: avatarSize / 2,
                        backgroundImage: NetworkImage(avatarUrl),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Name and Edit button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[900],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Verified Patient',
                            style: TextStyle(
                              fontSize: 13,
                              color: const Color.fromARGB(255, 73, 131, 205),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12),
                      // Edit button
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // TODO: navigate to edit screen
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: const Color.fromARGB(
                                    255,
                                    117,
                                    171,
                                    251,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      84,
                                      112,
                                      234,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Info card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      child: Column(
                        children: [
                          InfoRow(
                            icon: Icons.email_outlined,
                            title: 'Email',
                            subtitle: email,
                            iconColor: const Color.fromARGB(255, 117, 171, 251),
                          ),
                          Divider(height: 22, thickness: 0.5),
                          InfoRow(
                            icon: Icons.location_on_outlined,
                            title: 'Location',
                            subtitle: location,
                            iconColor: const Color.fromARGB(255, 117, 171, 251),
                          ),
                          Divider(height: 22, thickness: 0.5),
                          InfoRow(
                            icon: Icons.phone_outlined,
                            title: 'Phone',
                            subtitle: '+234 701 234 5678',
                            iconColor: const Color.fromARGB(255, 117, 171, 251),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 18),

                  // Additional cards (health profile, bookings)
                  Row(
                    children: [
                      Expanded(
                        child: FeatureCard(
                          color: Colors.white,
                          title: 'Health Profile',
                          subtitle: 'Allergies, history',
                          icon: Icons.health_and_safety_outlined,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: FeatureCard(
                          color: Colors.white,
                          title: 'Bookings',
                          subtitle: 'Upcoming & past',
                          icon: Icons.airplane_ticket_outlined,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 22),

                  // CTA: Start a new consultation or explore
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [turquoise, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.12),
                          blurRadius: 14,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[50],
                        child: Icon(
                          Icons.local_hospital_outlined,
                          color: const Color.fromARGB(255, 117, 171, 251),
                        ),
                      ),
                      title: Text(
                        'Explore medical destinations',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text('Find hospitals and specialists abroad'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ),

                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: const Color.fromARGB(255, 117, 171, 251),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  const InfoRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor = Colors.teal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // elegant icon container
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right, color: Colors.grey[400]),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final IconData icon;

  const FeatureCard({
    Key? key,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.teal[700]),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundMotifPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    // Soft turquoise blobs
    paint.color = Color(0xFFECFFFC);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(-60, -40, size.width * 0.7, 220),
        Radius.circular(80),
      ),
      paint,
    );

    paint.color = Color(0xFFF6FFFD);
    canvas.drawCircle(Offset(size.width * 0.9, 40), 60, paint);

    // subtle icons (stroked) - medical cross & airplane
    final iconPaint = Paint()
      ..color = Colors.teal.withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // draw cross
    final double cx = size.width * 0.15;
    final double cy = size.height * 0.22;
    final double s = 22;
    canvas.drawRect(Rect.fromLTWH(cx - s / 6, cy - s, s / 3, s * 2), iconPaint);
    canvas.drawRect(Rect.fromLTWH(cx - s, cy - s / 6, s * 2, s / 3), iconPaint);

    // draw simple airplane shape as path
    final Path plane = Path();
    plane.moveTo(size.width * 0.8, size.height * 0.12);
    plane.lineTo(size.width * 0.78, size.height * 0.18);
    plane.lineTo(size.width * 0.9, size.height * 0.17);
    plane.lineTo(size.width * 0.83, size.height * 0.21);
    plane.lineTo(size.width * 0.86, size.height * 0.24);
    plane.lineTo(size.width * 0.8, size.height * 0.2);
    canvas.drawPath(plane, iconPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
