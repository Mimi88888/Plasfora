import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralTreatmentPage extends StatefulWidget {
  @override
  _GeneralTreatmentPageState createState() => _GeneralTreatmentPageState();
}

class _GeneralTreatmentPageState extends State<GeneralTreatmentPage>
    with TickerProviderStateMixin {
  late AnimationController _heroAnimationController;
  late AnimationController _cardsAnimationController;
  late Animation<double> _heroFadeAnimation;
  late Animation<Offset> _heroSlideAnimation;
  late Animation<double> _cardsAnimation;

  final List<Map<String, dynamic>> medicalServices = [
    {
      'title': 'General Consultation',
      'description': 'Comprehensive health checkups with experienced doctors',
      'icon': Icons.health_and_safety,
      'image': 'assets/images/general_consultation.png',
      'color': Color(0xFF0891B2),
      'price': 'From \$45',
    },
    {
      'title': 'Pediatrics',
      'description': 'Specialized care for children and adolescents',
      'icon': Icons.child_care,
      'image': 'assets/images/pediatrics.png',
      'color': Color(0xFF059669),
      'price': 'From \$55',
    },
    {
      'title': 'Cardiology',
      'description': 'Heart health specialists and cardiac treatments',
      'icon': Icons.favorite,
      'image': 'assets/images/cardiology.png',
      'color': Color(0xFFDC2626),
      'price': 'From \$80',
    },
    {
      'title': 'ENT Specialist',
      'description': 'Ear, nose, and throat diagnosis and treatment',
      'icon': Icons.hearing,
      'image': 'assets/images/ent.png',
      'color': Color(0xFF7C3AED),
      'price': 'From \$65',
    },
    {
      'title': 'Dermatology',
      'description': 'Skin health and cosmetic dermatology services',
      'icon': Icons.face,
      'image': 'assets/images/dermatology.png',
      'color': Color(0xFFEA580C),
      'price': 'From \$70',
    },
    {
      'title': 'Lab Tests & Checkups',
      'description': 'Comprehensive laboratory tests and health screenings',
      'icon': Icons.science,
      'image': 'assets/images/lab_tests.png',
      'color': Color(0xFF0D9488),
      'price': 'From \$25',
    },
    {
      'title': 'Teleconsultation',
      'description': 'Remote consultations with certified physicians',
      'icon': Icons.video_call,
      'image': 'assets/images/teleconsultation.png',
      'color': Color(0xFF2563EB),
      'price': 'From \$35',
    },
  ];

  final List<Map<String, dynamic>> quickActions = [
    {
      'title': 'Emergency',
      'subtitle': '24/7 Available',
      'icon': Icons.local_hospital,
      'color': Color(0xFFDC2626),
      'action': 'call_emergency',
    },
    {
      'title': 'Video Call',
      'subtitle': 'Instant Care',
      'icon': Icons.video_call,
      'color': Color(0xFF0891B2),
      'action': 'video_consultation',
    },
    {
      'title': 'Book Appointment',
      'subtitle': 'Schedule Visit',
      'icon': Icons.calendar_today,
      'color': Color(0xFF059669),
      'action': 'book_appointment',
    },
  ];

  final List<Map<String, dynamic>> benefits = [
    {
      'title': 'World-Class Doctors',
      'description': '500+ certified physicians',
      'icon': Icons.verified_user,
    },
    {
      'title': 'Advanced Technology',
      'description': 'State-of-the-art equipment',
      'icon': Icons.precision_manufacturing,
    },
    {
      'title': 'Affordable Care',
      'description': '60% cost savings',
      'icon': Icons.savings,
    },
    {
      'title': 'International Standards',
      'description': 'JCI accredited facilities',
      'icon': Icons.public,
    },
  ];

  @override
  void initState() {
    super.initState();

    _heroAnimationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _cardsAnimationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _heroFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _heroAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _heroSlideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _heroAnimationController,
            curve: Curves.easeOutBack,
          ),
        );

    _cardsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations
    _heroAnimationController.forward();

    // Delay cards animation
    Future.delayed(Duration(milliseconds: 500), () {
      _cardsAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _heroAnimationController.dispose();
    _cardsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildQuickAccessSection(),
            _buildMedicalServicesSection(),
            _buildBenefitsSection(),
            _buildCallToActionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 280,
      child: Stack(
        children: [
          // Background with gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0891B2), Color(0xFF0D9488)],
              ),
            ),
          ),

          // Background pattern or video placeholder
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),

          // Content
          AnimatedBuilder(
            animation: _heroAnimationController,
            builder: (context, child) {
              return SlideTransition(
                position: _heroSlideAnimation,
                child: FadeTransition(
                  opacity: _heroFadeAnimation,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 40), // Status bar spacing

                        Text(
                          'General Treatment',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 12),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Your health journey starts here\nComprehensive medical care in Tunisia',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: 32),

                        _buildSearchBar(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600]),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search medical services...',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0891B2), Color(0xFF0D9488)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessSection() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Access',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),

          Row(
            children: quickActions.asMap().entries.map((entry) {
              return Expanded(
                child: AnimatedBuilder(
                  animation: _cardsAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - _cardsAnimation.value)),
                      child: Opacity(
                        opacity: _cardsAnimation.value,
                        child: Container(
                          margin: EdgeInsets.only(right: entry.key < 2 ? 8 : 0),
                          child: _buildQuickActionCard(entry.value, entry.key),
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action, int index) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            HapticFeedback.lightImpact();
            _handleQuickAction(action['action']);
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: action['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(action['icon'], color: action['color'], size: 24),
              ),
              SizedBox(height: 8),
              Text(
                action['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                action['subtitle'],
                style: TextStyle(color: Colors.grey[600], fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicalServicesSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Medical Services',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: medicalServices.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _cardsAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      30 * (1 - _cardsAnimation.value),
                      20 * (1 - _cardsAnimation.value),
                    ),
                    child: Opacity(
                      opacity: _cardsAnimation.value,
                      child: _buildServiceCard(medicalServices[index], index),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            HapticFeedback.lightImpact();
            _navigateToService(service);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service icon/image header
              Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      service['color'].withOpacity(0.8),
                      service['color'],
                    ],
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
                  child: Icon(service['icon'], size: 40, color: Colors.white),
                ),
              ),

              // Service content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 8),

                      Expanded(
                        child: Text(
                          service['description'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            service['price'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: service['color'],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0891B2).withOpacity(0.05),
            Color(0xFF0D9488).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose Tunisia for Medical Care?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),

          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: benefits.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            benefits[index]['icon'],
                            color: Color(0xFF0891B2),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              benefits[index]['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        benefits[index]['description'],
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToActionSection() {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0891B2), Color(0xFF0D9488)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Start Your Treatment?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),

          Text(
            'Book a consultation with our medical experts today',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        HapticFeedback.lightImpact();
                        _bookConsultation();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Book Consultation',
                          style: TextStyle(
                            color: Color(0xFF0891B2),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        HapticFeedback.lightImpact();
                        _contactSupport();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Action handlers
  void _handleQuickAction(String action) {
    switch (action) {
      case 'call_emergency':
        // Handle emergency call
        break;
      case 'video_consultation':
        // Navigate to video consultation
        break;
      case 'book_appointment':
        // Navigate to appointment booking
        break;
    }
  }

  void _navigateToService(Map<String, dynamic> service) {
    // Navigate to service details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceDetailsPage(service: service),
      ),
    );
  }

  void _bookConsultation() {
    // Navigate to consultation booking
  }

  void _contactSupport() {
    // Navigate to contact/support page
  }
}

// Placeholder for service details page
class ServiceDetailsPage extends StatelessWidget {
  final Map<String, dynamic> service;

  ServiceDetailsPage({required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service['title'])),
      body: Center(child: Text('Service Details for ${service['title']}')),
    );
  }
}
