import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

// Your main PlasticSurgeryPage widget
class PlasticSurgeryPage extends StatefulWidget {
  const PlasticSurgeryPage({Key? key}) : super(key: key);

  @override
  State<PlasticSurgeryPage> createState() => _PlasticSurgeryPageState();
}

class _PlasticSurgeryPageState extends State<PlasticSurgeryPage>
    with TickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  final List<PlasticSurgeryService> services = [
    PlasticSurgeryService(
      title: "Breast Surgery",
      subtitle: "Augmentation, Lift & Reduction",
      description:
          "Enhance your natural beauty with comprehensive breast procedures",
      detailedDescription:
          "Our skilled surgeons utilize advanced techniques to achieve natural-looking and harmonious results with breast augmentation, breast lift, and breast reduction procedures. We focus on creating proportional, aesthetic outcomes that enhance your confidence and natural beauty.",
      iconPath: "assets/plasticSurgery/mastopexy.png",
      videoPath: "assets/videos/mastopexy.mp4",
      externalLink: "https://www.plasfora.com/procedures/breast-surgery",
      featureTags: [
        "Natural Results",
        "Advanced Techniques",
        "Personalized Care",
        "Recovery Support",
      ],
      keyBenefits: [
        "Enhanced natural beauty and proportions",
        "Improved self-confidence and body image",
        "Advanced surgical techniques for minimal scarring",
        "Comprehensive pre and post-operative care",
        "Natural-looking, long-lasting results",
      ],
      pricing: "Starting from €2,500",
    ),
    PlasticSurgeryService(
      title: "Facial Surgery",
      subtitle: "Facelift, Rhinoplasty & Blepharoplasty",
      description:
          "Restore youthful appearance with advanced facial procedures",
      detailedDescription:
          "Restore a youthful and refreshed appearance with our range of facial surgery procedures, including facelifts, rhinoplasty (nose reshaping), eyelid surgery (blepharoplasty), and more. Our surgeons are skilled in creating natural-looking results that enhance your features while maintaining facial harmony.",
      iconPath: "assets/plasticSurgery/botox.png",
      videoPath: "assets/videos/facial_surgery.mp4",
      externalLink: "https://www.plasfora.com/procedures/facial-surgery",
      featureTags: [
        "Anti-Aging",
        "Natural Enhancement",
        "Facial Harmony",
        "Expert Surgeons",
      ],
      keyBenefits: [
        "Youthful, refreshed appearance",
        "Enhanced facial features and symmetry",
        "Natural-looking results without artificial appearance",
        "Improved self-esteem and confidence",
        "Long-lasting aesthetic improvements",
      ],
      pricing: "Starting from €3,200",
    ),
    PlasticSurgeryService(
      title: "Body Contouring",
      subtitle: "Liposuction, Tummy Tuck & BBL",
      description: "Achieve your ideal body shape with advanced contouring",
      detailedDescription:
          "Achieve a sculpted and toned physique with our variety of body contouring procedures, including abdominoplasty (tummy tuck), liposuction, Brazilian Butt Lift (BBL), and more. Our surgeons are experts in body contouring and can help you achieve your desired shape and enhanced confidence.",
      iconPath: "assets/plasticSurgery/liposuction.png",
      videoPath: "assets/videos/body_contouring.mp4",
      externalLink: "https://www.plasfora.com/procedures/body-contouring",
      featureTags: [
        "Body Sculpting",
        "Fat Removal",
        "Curves Enhancement",
        "Confidence Boost",
      ],
      keyBenefits: [
        "Sculpted, toned physique",
        "Removal of stubborn fat deposits",
        "Enhanced body proportions and curves",
        "Improved clothing fit and comfort",
        "Boosted self-confidence and body image",
      ],
      pricing: "Starting from €2,800",
    ),
    PlasticSurgeryService(
      title: "Limb Enhancement",
      subtitle: "Arm Lift, Thigh Lift & Contouring",
      description: "Enhance limb contours for harmonious proportions",
      detailedDescription:
          "Enhance the contours of your limbs with our range of specialized procedures, including arm lift, thigh liposuction, calf augmentation, and more. Our surgeons are skilled in creating harmonious proportions and enhancing your overall appearance for a balanced, confident look.",
      iconPath: "assets/plasticSurgery/reduction.png",
      videoPath: "assets/videos/limb_enhancement.mp4",
      externalLink: "https://www.plasfora.com/procedures/limb-enhancement",
      featureTags: [
        "Limb Contouring",
        "Proportional Balance",
        "Toning",
        "Aesthetic Harmony",
      ],
      keyBenefits: [
        "Enhanced limb contours and definition",
        "Improved overall body proportions",
        "Reduced sagging skin and tissue",
        "Increased confidence in clothing choices",
        "Natural-looking, harmonious results",
      ],
      pricing: "Starting from €2,200",
    ),
    PlasticSurgeryService(
      title: "Maxillofacial Surgery",
      subtitle: "Osteotomy, Trauma & Reconstruction",
      description: "Restore facial harmony and function with expertise",
      detailedDescription:
          "Our maxillofacial surgeons provide comprehensive treatment including osteotomy for facial reshaping, facial trauma reconstruction, cranioplasty, and burn reconstruction. We are dedicated to restoring both facial function and aesthetics with advanced surgical techniques.",
      iconPath: "assets/plasticSurgery/face.png",
      videoPath: "assets/videos/maxillofacial.mp4",
      externalLink: "https://www.plasfora.com/procedures/maxillofacial",
      featureTags: [
        "Facial Reconstruction",
        "Trauma Care",
        "Functional Restoration",
        "Expert Treatment",
      ],
      keyBenefits: [
        "Restored facial function and aesthetics",
        "Comprehensive trauma care and reconstruction",
        "Advanced surgical techniques for optimal healing",
        "Improved bite alignment and facial symmetry",
        "Expert care for complex facial conditions",
      ],
      pricing: "Starting from €3,500",
    ),
    PlasticSurgeryService(
      title: "Reconstructive Surgery",
      subtitle: "Burns, Scars & Defect Correction",
      description: "Comprehensive reconstruction and scar management",
      detailedDescription:
          "We provide comprehensive care for reconstructive needs including burn injury reconstruction, wound care, scar management, and congenital defect correction. Our skilled surgeons work to restore function, minimize scarring, and improve quality of life through advanced reconstructive techniques.",
      iconPath: "assets/plasticSurgery/reconstructive.png",
      videoPath: "assets/videos/reconstructive.mp4",
      externalLink: "https://www.plasfora.com/procedures/reconstructive",
      featureTags: [
        "Scar Reduction",
        "Function Restoration",
        "Quality of Life",
        "Advanced Care",
      ],
      keyBenefits: [
        "Restored function and mobility",
        "Significant scar reduction and improvement",
        "Enhanced quality of life and confidence",
        "Comprehensive wound care and management",
        "Expert treatment for complex cases",
      ],
      pricing: "Starting from €1,800",
    ),
  ];

  @override
  void initState() {
    super.initState();

    _videoController =
        VideoPlayerController.asset('assets/videos/plasticSurgery.mp4')
          ..initialize().then((_) {
            if (mounted) {
              setState(() {});
              _videoController.setLooping(true);
              _videoController.play();
            }
          });

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _pulseController.repeat(reverse: true);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  _videoController.value.isInitialized
                      ? FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _videoController.value.size.width,
                            height: _videoController.value.size.height,
                            child: VideoPlayer(_videoController),
                          ),
                        )
                      : Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
                            ),
                          ),
                        ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Center(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) => Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: Image.asset(
                                    'assets/plasticSurgery/plastic-surgery.png',
                                    fit: BoxFit.contain,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Plastic Surgery',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Reconstructive & Aesthetic Excellence in Tunisia',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 600 + (index * 100)),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: _buildServiceCard(services[index]),
                      ),
                    );
                  },
                );
              }, childCount: services.length),
            ),
          ),
          SliverToBoxAdapter(child: _buildContactSection()),
        ],
      ),
    );
  }

  Widget _buildServiceCard(PlasticSurgeryService service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(16),
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showServiceModal(service),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.grey.shade50],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90E2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          service.iconPath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service.subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90E2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        service.pricing,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  service.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: service.featureTags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90E2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF4A90E2).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF4A90E2),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Modified _showServiceModal to pass callbacks to modal widget
  void _showServiceModal(PlasticSurgeryService service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _ServiceVideoModal(
          service: service,
          showConsultationDialog: _showConsultationDialog,
          launchURL: _launchURL,
        );
      },
    );
  }

  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90E2).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ready to Enhance Your Beauty?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Schedule a consultation with our expert plastic surgeons in Tunisia',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _showConsultationDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF4A90E2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 8),
                  Text(
                    'Get Free Consultation',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConsultationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Free Consultation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enhance your natural beauty with expert plastic surgery in Tunisia. Our team will contact you within 2 hours!',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.email, color: Color(0xFF4A90E2)),
                  SizedBox(width: 8),
                  Text('contact@plasfora.com'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, color: Color(0xFF4A90E2)),
                  SizedBox(width: 8),
                  Text('+216 XX XXX XXX'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.chat, color: Color(0xFF4A90E2)),
                  SizedBox(width: 8),
                  Text('WhatsApp Available'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xFF4A90E2)),
                  SizedBox(width: 8),
                  Text('Sousse, Tunisia'),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _launchURL('mailto:contact@plasfora.com');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Contact Now'),
            ),
          ],
        );
      },
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

// Data model for Plastic Surgery Service
class PlasticSurgeryService {
  final String title;
  final String subtitle;
  final String description;
  final String detailedDescription;
  final String iconPath;
  final String? videoPath;
  final String? externalLink;
  final List<String> featureTags;
  final List<String> keyBenefits;
  final String pricing;

  PlasticSurgeryService({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.detailedDescription,
    required this.iconPath,
    this.videoPath,
    this.externalLink,
    required this.featureTags,
    required this.keyBenefits,
    required this.pricing,
  });
}

// Modal widget with video player, receives callbacks
class _ServiceVideoModal extends StatefulWidget {
  final PlasticSurgeryService service;
  final VoidCallback showConsultationDialog;
  final void Function(String url) launchURL;

  const _ServiceVideoModal({
    required this.service,
    required this.showConsultationDialog,
    required this.launchURL,
  });

  @override
  State<_ServiceVideoModal> createState() => _ServiceVideoModalState();
}

class _ServiceVideoModalState extends State<_ServiceVideoModal> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.service.videoPath != null) {
      _controller = VideoPlayerController.asset(widget.service.videoPath!)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isInitialized = true;
              _controller!.setLooping(true);
              _controller!.play();
            });
          }
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Header
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90E2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          service.iconPath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service.subtitle,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4A90E2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              service.pricing,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Video player or loading indicator
                if (_controller != null)
                  _isInitialized
                      ? Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: VideoPlayer(_controller!),
                          ),
                        )
                      : Container(
                          height: 200,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                if (_controller != null) const SizedBox(height: 24),

                // Description
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  service.detailedDescription,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                // Key Benefits
                const Text(
                  'Key Benefits',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 12),
                ...service.keyBenefits.map(
                  (benefit) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF27AE60),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            benefit,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: widget.showConsultationDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A90E2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Free Consultation',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (service.externalLink != null) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              widget.launchURL(service.externalLink!),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF4A90E2),
                            side: const BorderSide(color: Color(0xFF4A90E2)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Learn More',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
