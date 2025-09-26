import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class DentistryPage extends StatefulWidget {
  const DentistryPage({Key? key}) : super(key: key);

  @override
  State<DentistryPage> createState() => _DentistryPageState();
}

class _DentistryPageState extends State<DentistryPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late VideoPlayerController _videoController;
  VideoPlayerController? _modalVideoController;

  @override
  void initState() {
    super.initState();

    _videoController =
        VideoPlayerController.asset('assets/videos/dentistry_header.mp4')
          ..setLooping(true)
          ..setVolume(0)
          ..initialize().then((_) {
            setState(() {});
            _videoController.play();
          });

    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _slideController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _slideController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    _videoController.dispose();
    _modalVideoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
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
    return Container(
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
                          'assets/images/tooth.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Dental Care',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Dental excellence in the heart of Tunisia',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
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
    final services = _getDentalServices();

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Our Specialized Treatments',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C5AA0),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tailor-made care combining medical and aesthetic expertise',
            style: TextStyle(fontSize: 14, color: Color(0xFF7F8C8D)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          SlideTransition(
            position: _slideAnimation,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: _buildServiceCard(services[index], index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(DentalService service, int index) {
    return GestureDetector(
      onTap: () => _showServiceDetails(service),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF4A90E2).withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Color(0xFF4A90E2).withOpacity(0.1),
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
                      gradient: LinearGradient(
                        colors: [Color(0xFF4A90E2), Color(0xFF2C5AA0)],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      service.imagePath,
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        Text(
                          service.subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7F8C8D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                service.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF5A6C7D),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: service.features.map((feature) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF4A90E2).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C5AA0),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    service.price,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF27AE60),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _showServiceDetails(service),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4A90E2),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Text('Learn more', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8FFFE), Color(0xFFE8F7F5)],
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.phone_in_talk, size: 40, color: Color(0xFF2C5AA0)),
          SizedBox(height: 15),
          Text(
            'Ready for your transformation?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C5AA0),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Contact our experts for a personalized consultation',
            style: TextStyle(fontSize: 14, color: Color(0xFF7F8C8D)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _contactUs,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF27AE60),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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

  void _showServiceDetails(DentalService service) {
    // Initialize video controller for modal if video exists
    if (service.videoPath != null) {
      _modalVideoController = VideoPlayerController.asset(service.videoPath!)
        ..setLooping(false)
        ..setVolume(0.5)
        ..initialize().then((_) {
          setState(() {});
        });
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF7F8C8D),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF4A90E2), Color(0xFF2C5AA0)],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            service.imagePath,
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C5AA0),
                                ),
                              ),
                              if (service.infoLink != null)
                                GestureDetector(
                                  onTap: () async {
                                    final Uri url = Uri.parse(
                                      service.infoLink!,
                                    );
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(
                                        url,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Could not launch the link',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Learn more →',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF4A90E2),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      service.detailedDescription,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF5A6C7D),
                        height: 1.5,
                      ),
                    ),

                    // VIDEO SECTION - BELOW DETAILED DESCRIPTION
                    if (service.videoPath != null) ...[
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xFF4A90E2).withOpacity(0.2),
                          ),
                        ),
                        child:
                            _modalVideoController != null &&
                                _modalVideoController!.value.isInitialized
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    VideoPlayer(_modalVideoController!),
                                    Center(
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
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.7,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            _modalVideoController!
                                                    .value
                                                    .isPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.video_library,
                                      size: 40,
                                      color: Color(0xFF4A90E2),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Procedure Video',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF7F8C8D),
                                      ),
                                    ),
                                    Text(
                                      'Loading...',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF7F8C8D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],

                    SizedBox(height: 20),
                    Text(
                      'Key Benefits:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: service.benefits.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF27AE60),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    service.benefits[index],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF5A6C7D),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _contactUs,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF27AE60),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Request Pricing',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).whenComplete(() {
      // Dispose video controller when modal closes
      _modalVideoController?.dispose();
      _modalVideoController = null;
    });
  }

  void _contactUs() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: [
            Text('🇹🇳', style: TextStyle(fontSize: 24)),
            SizedBox(width: 10),
            Text('Free Consultation !'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactInfo('📞 Call us:', '+216 XX XX XX XX'),
            _buildContactInfo('📧 Email :', 'contact@plasfora.tn'),
            _buildContactInfo('💬 WhatsApp :', 'disponible 24/7'),
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
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Color(0xFF2C3E50), fontSize: 14),
          children: [
            TextSpan(
              text: label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: ' $value'),
          ],
        ),
      ),
    );
  }

  List<DentalService> _getDentalServices() {
    return [
      DentalService(
        imagePath: 'assets/images/dental-implant.png',
        videoPath: 'assets/videos/Implant.mp4',
        infoLink: 'https://en.wikipedia.org/wiki/Dental_implant',
        title: 'Dental Implants',
        subtitle: 'Permanent Replacement',
        description:
            'Replace your missing teeth with durable, natural-looking implants to restore your full smile.',
        detailedDescription:
            'Permanent solution to replace one or more missing teeth with exceptional natural results. Our titanium implants integrate perfectly with the jawbone.',
        features: ['Durable', 'Natural', 'Comfortable'],
        benefits: [
          'Titanium biocompatible de qualité médicale',
          'Intégration osseuse naturelle et définitive',
          'Durabilité exceptionnelle (+ de 20 ans)',
          'Fonction masticatoire complètement restaurée',
          'Esthétique parfaite et naturelle',
        ],
        price: 'Starting from €400',
      ),
      DentalService(
        imagePath: 'assets/images/tooth-whitening.png',
        videoPath: 'assets/videos/dental_veneers_process.mp4',
        infoLink: 'https://en.wikipedia.org/wiki/Veneer_(dentistry)',
        title: 'Aesthetic Veneers',
        subtitle: 'Smile Transformation',
        description:
            'Transform your smile with ultra-thin porcelain veneers for a natural and radiant look.',
        detailedDescription:
            'Complete smile makeover with ultra-thin, high-quality European porcelain veneers. Guaranteed natural result.',
        features: ['Ultra-thin', 'Porcelain', 'Radiant'],
        benefits: [
          'Medical-grade biocompatible titanium',
          'Natural and permanent bone integration',
          'Exceptional durability (20+ years)',
          'Fully restored chewing function',
          'Perfect and natural aesthetics',
        ],
        price: 'Starting from €200',
      ),
      DentalService(
        imagePath: 'assets/images/endodontic.png',
        videoPath: 'assets/videos/root_canal_treatment.mp4',
        infoLink: 'https://en.wikipedia.org/wiki/Endodontics',
        title: 'Endodontic Treatment',
        subtitle: 'Tooth Preservation',
        description:
            'Save damaged teeth with precise, pain-free root canal therapy to preserve your natural dentition.',
        detailedDescription:
            'Rescue of compromised teeth using advanced, precise, and completely painless endodontic techniques.',
        features: ['Painless', 'Precise', 'Conservative'],
        benefits: [
          'Microscope opératoire haute précision',
          'Techniques rotatives NiTi modernes',
          'Anesthésie informatisée sans douleur',
          'Obturation 3D hermétique',
          'Taux de succès supérieur à 95%',
        ],
        price: 'Starting from €150',
      ),
      DentalService(
        imagePath: 'assets/images/cleanTooth.png',
        videoPath: 'assets/videos/Whiteness.mp4',
        infoLink: 'https://en.wikipedia.org/wiki/Tooth_whitening',
        title: 'Teeth Whitening',
        subtitle: 'Radiance Restored',
        description:
            'Restore your smile brightness safely with our advanced professional whitening techniques.',
        detailedDescription:
            'Get a dazzling smile safely with our next-generation professional whitening protocols.',
        features: ['Safe', 'Professional', 'Fast'],
        benefits: [
          'Gel de blanchiment premium certifié',
          'Activation LED sécurisée et efficace',
          'Protection gingivale totale',
          'Résultats visibles immédiatement',
          'Effet longue durée (2-3 ans)',
        ],
        price: 'Starting from €120',
      ),
      DentalService(
        imagePath: 'assets/images/tooth-drill.png',
        videoPath: 'assets/videos/cavity_treatment_procedure.mp4',
        infoLink: 'https://en.wikipedia.org/wiki/Dental_restoration',
        title: 'Cavity Treatment',
        subtitle: 'Gentle Restoration',
        description:
            'Stop cavities early with our gentle and effective restorative techniques to preserve your teeth.',
        detailedDescription:
            'Effective removal of cavities using biocompatible materials and modern conservative techniques.',
        features: ['Preventive', 'Gentle', 'Effective'],
        benefits: [
          'Détection précoce par imagerie numérique',
          'Matériaux composite esthétiques',
          'Préservation maximale de la dent',
          'Techniques adhésives modernes',
          'Finition totalement invisible',
        ],
        price: 'Starting from €80',
      ),
      DentalService(
        imagePath: 'assets/images/braces.png',
        videoPath: 'assets/videos/dental_prosthetics_process.mp4',
        infoLink: 'https://en.wikipedia.org/wiki/Dental_prosthesis',
        title: 'Dental Prosthetics',
        subtitle: 'Complete Restoration',
        description:
            'Restore function and aesthetics with custom-made dentures perfectly adapted to your morphology.',
        detailedDescription:
            'Full restoration with tailor-made dentures combining optimal comfort, perfect function, and natural aesthetics.',
        features: ['Custom-made', 'Functional', 'Aesthetic'],
        benefits: [
          'Empreintes numériques 3D précises',
          'Laboratoire intégré sur site',
          'Matériaux haut de gamme européens',
          'Ajustement personnalisé parfait',
          'Garantie étendue de 5 ans',
        ],
        price: 'Starting from €300',
      ),
    ];
  }
}

class DentalService {
  final String imagePath; // instead of IconData
  final String? videoPath; // Video path for detailed view
  final String? infoLink; // Information link (Wikipedia, etc.)
  final String title;
  final String subtitle;
  final String description;
  final String detailedDescription;
  final List<String> features;
  final List<String> benefits;
  final String price;

  DentalService({
    required this.imagePath,
    this.videoPath,
    this.infoLink,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.detailedDescription,
    required this.features,
    required this.benefits,
    required this.price,
  });
}
