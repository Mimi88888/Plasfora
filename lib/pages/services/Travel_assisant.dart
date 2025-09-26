import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:plasfora_app/widgets/navBar.dart';

class TravelAssistancePage extends StatelessWidget {
  const TravelAssistancePage({super.key});

  final String supportNumber = '+21695064336'; // Actual number from image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      // appBar: AppBar(
      //   backgroundColor: Colors.blue.shade500,
      //   title: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       const Text('Travel Assistance'),
      //       const SizedBox(width: 8),
      //       const Icon(Icons.flight_takeoff, size: 30, color: Colors.white),
      //     ],
      //   ),
      // ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/images/plasfora.png', height: 120),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Smart Travel Support',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      const TextSpan(
                        text:
                            'We help you organize your medical trip with comfort and ease.\n\n',
                      ),
                      const WidgetSpan(
                        child: Icon(Icons.check, color: Colors.blue, size: 18),
                      ),
                      const TextSpan(text: ' Airport Pickup\n'),
                      const WidgetSpan(
                        child: Icon(Icons.check, color: Colors.blue, size: 18),
                      ),
                      const TextSpan(text: ' Hotel Booking\n'),
                      const WidgetSpan(
                        child: Icon(Icons.check, color: Colors.blue, size: 18),
                      ),
                      const TextSpan(text: ' Language Assistance\n'),
                      const WidgetSpan(
                        child: Icon(Icons.check, color: Colors.blue, size: 18),
                      ),
                      const TextSpan(text: ' 24/7 Support'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return _buildContactContainer(context);
                        },
                      );
                    },
                    icon: const Icon(Icons.support_agent),
                    label: const Text('Request Assistance'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade500,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactContainer(BuildContext context) {
    // Extract parts of the phone number
    final countryCode = supportNumber.substring(0, 4); // +216
    final firstPart = supportNumber.substring(4, 6); // 95
    final secondPart = supportNumber.substring(6, 9); // 064
    final thirdPart = supportNumber.substring(9); // 336

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Contact Our Hotline',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 25),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '($countryCode)',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text: '$firstPart-$secondPart-$thirdPart',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final Uri phoneUri = Uri(scheme: 'tel', path: supportNumber);
                if (await canLaunchUrl(phoneUri)) {
                  await launchUrl(phoneUri);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Could not launch phone dialer'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                shadowColor: Colors.green.withOpacity(0.3),
              ),
              child: const Text(
                'Call Now',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
