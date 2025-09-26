import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

// REUSABLE PULSING ICON WIDGET
Widget buildPulsingIcon(
  String iconPath,
  Animation<double> pulseAnimation, {
  bool useWhiteOverlay = true,
}) {
  return AnimatedBuilder(
    animation: pulseAnimation,
    builder: (context, child) => Transform.scale(
      scale: pulseAnimation.value,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: useWhiteOverlay
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(
          iconPath,
          color: useWhiteOverlay ? Colors.white : null,
        ),
      ),
    ),
  );
}

class HairTransplantPage extends StatefulWidget {
  const HairTransplantPage({Key? key}) : super(key: key);

  @override
  State<HairTransplantPage> createState() => _HairTransplantPageState();
}

class _HairTransplantPageState extends State<HairTransplantPage>
    with TickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  final List<HairTransplantService> services = [
    HairTransplantService(
      title: "FUE Hair Transplant",
      subtitle: "Follicular Unit Extraction",
      description:
          "Advanced minimally invasive technique for natural-looking results",
      detailedDescription:
          "Follicular Unit Extraction (FUE) is the most advanced hair transplant technique, involving the extraction of individual hair follicles from the donor area and transplanting them to areas of hair loss. This minimally invasive procedure leaves no linear scar and provides natural-looking results with faster recovery time.",
      iconPath: "assets/HairTransplant/hair.png",
      videoPath: "assets/videos/fue_procedure.mp4",
      externalLink: "https://www.plasfora.com/procedures/fue-hair-transplant",
      featureTags: [
        "No Linear Scar",
        "Quick Recovery",
        "Natural Results",
        "Minimally Invasive",
      ],
      keyBenefits: [
        "No visible linear scarring",
        "Faster healing and recovery time",
        "Natural-looking hairline design",
        "Can harvest grafts from body hair if needed",
        "Suitable for all hair types and textures",
        "Minimal post-operative discomfort",
      ],
      pricing: "Starting from €1,200",
    ),
    HairTransplantService(
      title: "FUT Hair Transplant",
      subtitle: "Follicular Unit Transplantation",
      description: "Traditional strip method for maximum graft yield",
      detailedDescription:
          "Follicular Unit Transplantation (FUT), also known as the strip method, involves removing a strip of scalp from the donor area and dissecting it into individual follicular units. This technique allows for the transplantation of a large number of grafts in a single session, making it ideal for patients with extensive hair loss.",
      iconPath: "assets/HairTransplant/hairr.png",
      videoPath: "assets/videos/fut_procedure.mp4",
      externalLink: "https://www.plasfora.com/procedures/fut-hair-transplant",
      featureTags: [
        "Maximum Grafts",
        "Single Session",
        "Cost Effective",
        "High Density",
      ],
      keyBenefits: [
        "Maximum number of grafts in one session",
        "Cost-effective for extensive hair loss",
        "High survival rate of transplanted follicles",
        "Suitable for patients needing large coverage",
        "Experienced technique with proven results",
        "Can achieve high hair density",
      ],
      pricing: "Starting from €900",
    ),
    HairTransplantService(
      title: "DHI Hair Transplant",
      subtitle: "Direct Hair Implantation",
      description: "Premium technique using Choi implanter pens",
      detailedDescription:
          "Direct Hair Implantation (DHI) is a premium hair transplant technique that uses specialized Choi implanter pens to directly implant hair follicles without creating recipient sites beforehand. This method offers precise control over angle, depth, and direction of each implanted hair, resulting in maximum naturalness and density.",
      iconPath: "assets/HairTransplant/hair-transplant.png",
      videoPath: "assets/videos/dhi_procedure.mp4",
      externalLink: "https://www.plasfora.com/procedures/dhi-hair-transplant",
      featureTags: [
        "Choi Implanter",
        "Maximum Density",
        "Precise Control",
        "Premium Results",
      ],
      keyBenefits: [
        "No need to shave entire head",
        "Minimal bleeding and trauma",
        "Faster healing process",
        "Maximum hair density achievable",
        "Precise angle and direction control",
        "Reduced time outside the body for follicles",
      ],
      pricing: "Starting from €1,800",
    ),
    HairTransplantService(
      title: "Beard Transplant",
      subtitle: "Facial Hair Restoration",
      description: "Restore or enhance your beard with natural-looking results",
      detailedDescription:
          "Beard transplant involves transplanting hair follicles from the donor area (usually the back of the head) to the facial area to create or enhance beard growth. This procedure is perfect for men with patchy beards, scars, or those who want to achieve a fuller, more masculine appearance.",
      iconPath: "assets/HairTransplant/beard-trimming.png",
      videoPath: "assets/videos/beard_transplant.mp4",
      externalLink: "https://www.plasfora.com/procedures/beard-transplant",
      featureTags: [
        "Facial Hair",
        "Masculine Look",
        "Scar Coverage",
        "Natural Growth",
      ],
      keyBenefits: [
        "Permanent and natural-looking results",
        "Covers scars and patches effectively",
        "Enhances masculine appearance",
        "Can design custom beard shapes",
        "Low maintenance after healing",
        "Boosts confidence and self-esteem",
      ],
      pricing: "Starting from €1,500",
    ),
    HairTransplantService(
      title: "Eyebrow Transplant",
      subtitle: "Eyebrow Restoration",
      description: "Restore natural, well-defined eyebrows",
      detailedDescription:
          "Eyebrow transplant is a specialized procedure that involves transplanting hair follicles to the eyebrow area to restore natural, well-defined eyebrows. This treatment is ideal for those who have lost eyebrow hair due to over-plucking, medical conditions, or genetic factors.",
      iconPath: "assets/HairTransplant/eyebrowpng.png",
      videoPath: "assets/videos/eyebrow_transplant.mp4",
      externalLink: "https://www.plasfora.com/procedures/eyebrow-transplant",
      featureTags: [
        "Natural Shape",
        "Precision Work",
        "Facial Enhancement",
        "Permanent Results",
      ],
      keyBenefits: [
        "Natural-looking eyebrow restoration",
        "Precise follicle placement and angling",
        "Customizable eyebrow shape and arch",
        "Permanent solution to sparse eyebrows",
        "Enhanced facial symmetry and expression",
        "No daily makeup routine needed",
      ],
      pricing: "Starting from €1,200",
    ),
    HairTransplantService(
      title: "Women's Hair Transplant",
      subtitle: "Female Pattern Hair Loss",
      description:
          "Specialized techniques for women's unique hair loss patterns",
      detailedDescription:
          "Women's hair transplant addresses female pattern hair loss using specialized techniques that preserve existing hair while adding density. Our surgeons understand the unique challenges of women's hair loss and use advanced methods to achieve natural-looking results without compromising your existing hairstyle.",
      iconPath: "assets/HairTransplant/womanHair.png",
      videoPath: "assets/videos/women_hair_transplant.mp4",
      externalLink: "https://www.plasfora.com/procedures/women-hair-transplant",
      featureTags: [
        "Female Pattern",
        "Density Enhancement",
        "Existing Hair Preservation",
        "Natural Results",
      ],
      keyBenefits: [
        "Specialized approach for female hair loss",
        "Preserves existing hair while adding density",
        "Natural hairline design for women",
        "Minimal disruption to current hairstyle",
        "Improved hair volume and thickness",
        "Long-term confidence restoration",
      ],
      pricing: "Starting from €1,400",
    ),
    HairTransplantService(
      title: "PRP Hair Therapy",
      subtitle: "Platelet-Rich Plasma Treatment",
      description: "Non-surgical hair restoration and strengthening therapy",
      detailedDescription:
          "PRP (Platelet-Rich Plasma) hair therapy is a non-surgical treatment that uses your body's own platelets to stimulate hair growth and strengthen existing hair follicles. This treatment can be used alone for early-stage hair loss or in combination with hair transplant procedures to enhance results and promote faster healing.",
      iconPath: "assets/HairTransplant/prp.png",
      videoPath: "assets/videos/prp_therapy.mp4",
      externalLink: "https://www.plasfora.com/procedures/prp-hair-therapy",
      featureTags: [
        "Non-Surgical",
        "Natural Growth",
        "Follicle Strengthening",
        "Quick Treatment",
      ],
      keyBenefits: [
        "Non-surgical and minimally invasive",
        "Uses your body's natural healing factors",
        "Stimulates dormant hair follicles",
        "Strengthens existing hair",
        "Can prevent further hair loss",
        "Quick treatment with no downtime",
      ],
      pricing: "Starting from €300",
    ),
  ];

  @override
  void initState() {
    super.initState();

    _videoController =
        VideoPlayerController.asset('assets/videos/HairTransplant.mp4')
          ..initialize().then((_) {
            setState(() {});
            _videoController.setLooping(true);
            _videoController.play();
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
                  Container(color: Colors.black.withOpacity(0.4)),
                  SafeArea(
                    child: Center(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) => Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.asset(
                                    'assets/HairTransplant/hair-trans.png',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Hair Transplant',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Restore Your Confidence & Natural Beauty in Tunisia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
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

  Widget _buildServiceCard(HairTransplantService service) {
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

  void _showServiceModal(HairTransplantService service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _ServiceVideoModal(service: service);
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
            'Ready to Restore Your Confidence?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Get a free consultation with our expert hair transplant surgeons in Tunisia',
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
                'Restore your confidence with expert hair transplant in Tunisia. Our team will contact you within 2 hours!',
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

class HairTransplantService {
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

  HairTransplantService({
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

class _ServiceVideoModal extends StatefulWidget {
  final HairTransplantService service;
  const _ServiceVideoModal({required this.service});

  @override
  State<_ServiceVideoModal> createState() => _ServiceVideoModalState();
}

class _ServiceVideoModalState extends State<_ServiceVideoModal> {
  late VideoPlayerController? _controller;
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
    } else {
      _controller = null;
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
                // Modal top indicator bar
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Header with icon, title, subtitle, pricing
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
                              color: Colors.grey.shade600,
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

                // Video player or loader if video exists
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

                // Key benefits
                const Text(
                  'Key Benefits',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 12),
                ...service.keyBenefits.map((benefit) {
                  return Padding(
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
                  );
                }).toList(),

                const SizedBox(height: 32),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _showConsultationDialog(),
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
                          onPressed: () => _launchURL(service.externalLink!),
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
                'Restore your confidence with expert hair transplant in Tunisia. Our team will contact you within 2 hours!',
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
