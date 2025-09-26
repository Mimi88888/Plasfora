import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class IVFPage extends StatefulWidget {
  const IVFPage({Key? key}) : super(key: key);

  @override
  State<IVFPage> createState() => _IVFPageState();
}

class _IVFPageState extends State<IVFPage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late VideoPlayerController _videoController;

  final List<IVFService> services = [
    IVFService(
      title: "IVF Treatment",
      subtitle: "Comprehensive IVF protocols",
      description:
          "Expert care with personalized protocols tailored to each patient. Advanced lab technology to maximize success.",
      detailedDescription:
          "Our IVF treatments use cutting-edge Assisted Reproductive Technologies to maximize your chance of parenthood. Our specialists personalize protocols and provide detailed monitoring throughout.",
      iconPath: 'assets/IVF/ivf-treatment.png',
      videoPath: 'assets/videos/ivf_treatment.mp4',
      externalLink: 'https://www.plasfora.com/procedures/ivf-treatment',
      featureTags: ["Personalized Care", "Advanced Lab", "Success Focused"],
      keyBenefits: [
        "High fertilization rates",
        "Detailed hormone monitoring",
        "Cutting-edge techniques",
      ],
      pricing: "Starting from €3,000",
    ),
    IVFService(
      title: "ICSI Procedure",
      subtitle: "Sperm Injection Fertilization",
      description:
          "Perfect for cases with male infertility to improve fertilization rates.",
      detailedDescription:
          "ICSI allows direct injection of sperm into eggs increasing fertilization success especially in male infertility cases.",
      iconPath: 'assets/IVF/icsi_procedure.png',
      videoPath: 'assets/videos/icsi_procedure.mp4',
      externalLink: 'https://www.plasfora.com/procedures/icsi',
      featureTags: [
        "Male Infertility",
        "Precision Injection",
        "High Fertilization",
      ],
      keyBenefits: [
        "Improved fertilization rates for difficult cases",
        "Expert embryologists involvement",
      ],
      pricing: "Starting from €1,500",
    ),
    IVFService(
      title: "Egg Freezing",
      subtitle: "Fertility Preservation",
      description: "Freeze eggs for future family planning.",
      detailedDescription:
          "Freeze your eggs at peak fertility using advanced cryopreservation to preserve your fertility options for the future.",
      iconPath: 'assets/IVF/egg_freezing.png',
      videoPath: 'assets/videos/egg_freezing.mp4',
      externalLink: 'https://www.plasfora.com/procedures/egg-freezing',
      featureTags: ["Cryopreservation", "Future Family Planning"],
      keyBenefits: [
        "Safe and proven freezing methods",
        "Extended fertility options",
      ],
      pricing: "Starting from €2,000",
    ),
  ];

  @override
  void initState() {
    super.initState();

    _videoController =
        VideoPlayerController.asset('assets/videos/ivf_header.mp4')
          ..setLooping(true)
          ..setVolume(0)
          ..initialize().then((_) {
            if (mounted) {
              setState(() {});
              _videoController.play();
            }
          });

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _slideController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildServicesSection(),
            _buildContactSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 280,
      child: Stack(
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
              : Container(color: Colors.black12),
          Container(color: Colors.black.withOpacity(0.4)),
          SafeArea(
            child: Center(
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
                          'assets/IVF/ivf-icon.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'IVF (In Vitro Fertilization)',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Achieve Your Dream of Parenthood with IVF in Tunisia',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Our IVF Services',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C5AA0),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Personalized care combining advanced technology',
            style: TextStyle(fontSize: 14, color: Color(0xFF7F8C8D)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          SlideTransition(
            position: _slideAnimation,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildServiceCard(services[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(IVFService service) {
    return GestureDetector(
      onTap: () => _showServiceModal(service),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4A90E2).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: const Color(0xFF4A90E2).withOpacity(0.1),
            width: 1,
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
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF2C5AA0)],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(service.iconPath, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      Text(
                        service.subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF7F8C8D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              service.description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF5A6C7D),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: service.featureTags.map((feature) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A90E2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    feature,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2C5AA0),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  service.pricing,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF27AE60),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showServiceModal(service),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Learn more',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8FFFE), Color(0xFFE8F7F5)],
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.phone_in_talk, size: 40, color: Color(0xFF2C5AA0)),
          const SizedBox(height: 15),
          const Text(
            'Ready for your parenthood journey?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C5AA0),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Contact our IVF specialists for a personalized consultation',
            style: TextStyle(fontSize: 14, color: Color(0xFF7F8C8D)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _contactUs,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF27AE60),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.phone, size: 20),
                SizedBox(width: 8),
                Text(
                  'Free Consultation',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showServiceModal(IVFService service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _IVFServiceVideoModal(
          service: service,
          onContactPressed: _contactUs,
        );
      },
    );
  }

  void _contactUs() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: const [
            Text('🇹🇳', style: TextStyle(fontSize: 24)),
            SizedBox(width: 10),
            Text('Free Consultation !'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('📞 Call us: +216 XX XX XX XX'),
            SizedBox(height: 8),
            Text('📧 Email : contact@plasfora.tn'),
            SizedBox(height: 8),
            Text('💬 WhatsApp : disponible 24/7'),
            SizedBox(height: 15),
            Text(
              'Our team will contact you within 2 hours!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF27AE60),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Modal widget to display the video and details per service
class _IVFServiceVideoModal extends StatefulWidget {
  final IVFService service;
  final VoidCallback onContactPressed;

  const _IVFServiceVideoModal({
    required this.service,
    required this.onContactPressed,
  });

  @override
  State<_IVFServiceVideoModal> createState() => _IVFServiceVideoModalState();
}

class _IVFServiceVideoModalState extends State<_IVFServiceVideoModal> {
  VideoPlayerController? _modalVideoController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.service.videoPath != null) {
      _modalVideoController =
          VideoPlayerController.asset(widget.service.videoPath!)
            ..initialize().then((_) {
              if (mounted) {
                setState(() {
                  _isInitialized = true;
                  _modalVideoController!.setLooping(false);
                  _modalVideoController!.setVolume(0.5);
                  _modalVideoController!.play();
                });
              }
            });
    }
  }

  @override
  void dispose() {
    _modalVideoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
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
                              color: Color(0xFF2C5AA0),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service.subtitle,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            service.pricing,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF27AE60),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Video player or spinner while loading
                if (_modalVideoController != null)
                  _isInitialized
                      ? AspectRatio(
                          aspectRatio: _modalVideoController!.value.aspectRatio,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: VideoPlayer(_modalVideoController!),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_modalVideoController!
                                            .value
                                            .isPlaying) {
                                          _modalVideoController!.pause();
                                        } else {
                                          _modalVideoController!.play();
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black45,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        _modalVideoController!.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 48,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 200,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                const SizedBox(height: 20),

                Text(
                  service.detailedDescription,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5A6C7D),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Key Benefits',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),

                const SizedBox(height: 15),

                // List of key benefits
                ...service.keyBenefits.map((benefit) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Color(0xFF27AE60),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            benefit,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF5A6C7D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                const SizedBox(height: 30),

                // Request Pricing button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.onContactPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF27AE60),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Request Pricing',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

// IVFService data model
class IVFService {
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

  IVFService({
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
