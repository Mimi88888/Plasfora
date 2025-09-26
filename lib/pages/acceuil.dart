import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PlasforaHomeScreen extends StatefulWidget {
  const PlasforaHomeScreen({Key? key}) : super(key: key);

  @override
  State<PlasforaHomeScreen> createState() => _PlasforaHomeScreenState();
}

class FAQItem {
  final String question;
  final String answer;
  bool isExpanded;

  FAQItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}

class _PlasforaHomeScreenState extends State<PlasforaHomeScreen> {
  late VideoPlayerController _videoController;
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentTestimonial = 0;

  final List<Widget> carouselItems = [
    Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage('assets/acceuil/desert.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage('assets/acceuil/montagne.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage('assets/acceuil/sidibou.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage('assets/acceuil/tataouine.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ];

  final List<Testimonial> testimonials = [
    Testimonial(
      name: "Sarah M.",
      service: "Dental Tourism",
      rating: 5,
      comment: "Exceptional care and beautiful recovery in Tunis.",
      avatar: "S",
    ),
    Testimonial(
      name: "John D.",
      service: "Plastic Surgery",
      rating: 5,
      comment: "Professional staff and amazing results. Best decision I made!",
      avatar: "J",
    ),
    Testimonial(
      name: "Maria L.",
      service: "Hair Transplant",
      rating: 5,
      comment: "World-class facilities and caring doctors. Thank you Plasfora!",
      avatar: "M",
    ),
  ];

  // Remplacez votre liste de FAQs par ceci
  final List<FAQItem> faqs = [
    FAQItem(
      question: "How much can I save on medical procedures?",
      answer:
          "Patients typically save 50-70% compared to prices in Europe or North America while receiving the same quality of care. For example, dental implants cost about 60% less in Tunisia than in France.",
    ),
    FAQItem(
      question: "What languages do doctors speak?",
      answer:
          "Most doctors speak fluent French and Arabic. Many specialists are also proficient in English, especially in international clinics. Plasfora provides translation services for other languages if needed.",
    ),
    FAQItem(
      question: "Is Tunisia safe for medical tourism?",
      answer:
          "Absolutely. Tunisia has been a leading medical tourism destination for decades with excellent safety records. We partner only with accredited hospitals in secure areas, and provide 24/7 support throughout your stay.",
    ),
    FAQItem(
      question: "What is included in the medical packages?",
      answer:
          "Our packages include: medical procedure, hospital accommodation, medications, airport transfers, 5-star hotel recovery stay, follow-up consultations, and a personal care coordinator. Tourism activities can be added optionally.",
    ),
    FAQItem(
      question: "How do I get started with Plasfora?",
      answer:
          "1. Request a free consultation on our website\n2. Receive your personalized treatment plan\n3. Get visa assistance\n4. Travel for your procedure\n5. Enjoy your recovery with our support",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/videos/promo.mp4')
      ..initialize().then((_) {
        setState(() {}); // Refresh to show video
        _videoController.setVolume(0.0);
        _videoController.setLooping(true);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildStatsSection(),
            _buildSpecialtiesSection(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ResponsiveCarousel(
                items: carouselItems,
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildWhyTunisiaSection(),
            _buildTestimonialsSection(),
            _buildFAQSection(),
            _buildLatestUpdatesSection(),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Stack(
        children: [
          // Video background
          if (_videoController.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            )
          else
            // Fallback if video not ready yet
            Container(color: Colors.blue.shade700),

          // Semi-transparent overlay
          Container(color: Colors.black.withOpacity(0.5)),

          // Centered logo & text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Plasfora logo in circle white BG
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/plasfora.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Transform Your Health Journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 5,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'World-Class Medical Care in Tunisia',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                // Call to actions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/medical_booking');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              62,
                              101,
                              240,
                            ),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            ' Book Appointment',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'About Plasfora',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 62, 101, 240),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your trusted partner for medical tourism in Tunisia. We connect you with world-renowned specialists and luxury recovery experiences in the heart of the Mediterranean.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  '10,000+',
                  'Happy Patients',
                  Icons.people,
                  Colors.blue,
                ),
              ),
              Expanded(
                child: _buildStatCard(
                  '150+',
                  'Specialists',
                  Icons.medical_services,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  '98%',
                  'Success Rate',
                  Icons.star,
                  Colors.orange,
                ),
              ),
              Expanded(
                child: _buildStatCard(
                  '25+',
                  'Countries',
                  Icons.public,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String number,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            number,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 62, 101, 240),
            ),
          ),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildSpecialtiesSection() {
    final screenWidth = MediaQuery.of(context).size.width;

    // Initialisation des variables avec des valeurs par défaut
    int crossAxisCount = 3;
    double childAspectRatio = 0.9; // Plus compact
    double imageSize = 18; // Plus petit
    double fontSize = 10; // Taille de police réduite
    EdgeInsetsGeometry cardPadding = EdgeInsets.zero;
    // Padding réduit
    double titleFontSize = 16;

    // Ajustement pour les tablettes
    if (screenWidth >= 600) {
      crossAxisCount = 4;
      childAspectRatio = 0.8;
      imageSize = 28;
      fontSize = 12;
      cardPadding = const EdgeInsets.all(2);
      titleFontSize = 17;
    }

    // Ajustement pour les grands écrans
    if (screenWidth >= 900) {
      crossAxisCount = 5;
      childAspectRatio = 0.9;
      imageSize = 32;
      fontSize = 13;
      cardPadding = const EdgeInsets.all(3);
      titleFontSize = 18;
    }

    return Container(
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Medical Specialties',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 62, 101, 240),
            ),
          ),
          const SizedBox(height: 6), // Espace réduit
          GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 4, // GridView
            mainAxisSpacing: 4,
            childAspectRatio: childAspectRatio,
            children: [
              _buildSpecialtyCard(
                'Plastic\nSurgery',
                'assets/acceuil/plastic-surgery.png',
                Colors.blue.shade100,
                '/plastic_surgery',
                imageSize: imageSize,
                fontSize: fontSize,
                padding: cardPadding,
              ),
              _buildSpecialtyCard(
                'Dentistry',
                'assets/acceuil/hygiene.png',
                Colors.blue.shade100,
                '/dentistry',
                imageSize: imageSize,
                fontSize: fontSize,
                padding: cardPadding,
              ),
              _buildSpecialtyCard(
                'Hair\nTransplant',
                'assets/acceuil/hair-transplant.png',
                Colors.blue.shade100,
                '/hair_transplant',
                imageSize: imageSize,
                fontSize: fontSize,
                padding: cardPadding,
              ),
              _buildSpecialtyCard(
                'IVF',
                'assets/acceuil/foetus.png',
                Colors.blue.shade100,
                '/ivf.dart',
                imageSize: imageSize,
                fontSize: fontSize,
                padding: cardPadding,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyCard(
    String title,
    String iconPath,
    Color color,
    String? route, {
    required double imageSize,
    required double fontSize,
    required EdgeInsetsGeometry padding,
  }) {
    return GestureDetector(
      onTap: () {
        if (route != null) Navigator.pushNamed(context, route);
      },
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8), // Border-radius réduit
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05), // Ombre plus légère
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 2), // Espace réduit (4 → 2)
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 62, 101, 240),
                height: 1.1, // Hauteur de ligne réduite
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhyTunisiaSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose Tunisia?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 62, 101, 240),
            ),
          ),
          const SizedBox(height: 15),
          ...[
            'World-class medical facilities',
            '70% cost savings compared to Europe',
            'English-speaking medical professionals',
            'Recovery in Mediterranean paradise',
            'Rich cultural heritage & hospitality',
          ].map(
            (benefit) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      benefit,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/visit_tunisia');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Explore Tunisia',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Patient Stories',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 62, 101, 240),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentTestimonial = index;
                });
              },
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                return _buildTestimonialCard(testimonials[index]);
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              testimonials.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 10,
                height: 15,
                decoration: BoxDecoration(
                  color: _currentTestimonial == index
                      ? Color.fromARGB(255, 62, 101, 240)
                      : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Testimonial testimonial) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(
              testimonial.rating,
              (index) => const Icon(Icons.star, color: Colors.orange, size: 20),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '"${testimonial.comment}"',
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.grey[700],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color.fromARGB(255, 62, 101, 240),
                child: Text(
                  testimonial.avatar,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 62, 101, 240),
                    ),
                  ),
                  Text(
                    testimonial.service,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // REMPLACEZ votre méthode _buildFAQSection existante par ceci :
  Widget _buildFAQSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 62, 101, 240),
            ),
          ),
          const SizedBox(height: 20),
          ...faqs.map((faq) => _buildFAQItem(faq)).toList(),
        ],
      ),
    );
  }

  // Ajoutez cette nouvelle méthode pour construire les items FAQ
  Widget _buildFAQItem(FAQItem faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          faq.question,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 62, 101, 240),
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          faq.isExpanded ? Icons.expand_less : Icons.expand_more,
          color: Color.fromARGB(255, 62, 101, 240),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              faq.answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            faq.isExpanded = expanded;
          });
        },
      ),
    );
  }
}

Widget _buildLatestUpdatesSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        Text(
          'Latest Updates',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 62, 101, 240),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildUpdateCard(
                'Special Offer',
                '20% Off Dental\nPackages',
                const Color.fromARGB(255, 126, 183, 230),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildUpdateCard(
                'New Clinic',
                'Opening in\nSousse',
                const Color.fromARGB(255, 126, 183, 230),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildUpdateCard(
                'Summer Package',
                'Medical + Beach\nHoliday',
                const Color.fromARGB(255, 126, 183, 230),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildUpdateCard(String title, String subtitle, Color color) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            height: 1.2,
          ),
        ),
      ],
    ),
  );
}

class ResponsiveCarousel extends StatelessWidget {
  final List<Widget> items;
  final CarouselOptions options;

  const ResponsiveCarousel({
    Key? key,
    required this.items,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(items: items, options: options);
  }
}

class Testimonial {
  final String name;
  final String service;
  final int rating;
  final String comment;
  final String avatar;

  Testimonial({
    required this.name,
    required this.service,
    required this.rating,
    required this.comment,
    required this.avatar,
  });
}
