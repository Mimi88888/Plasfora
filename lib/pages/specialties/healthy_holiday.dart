import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class HealthyHolidayPage extends StatefulWidget {
  @override
  _HealthyHolidayPageState createState() => _HealthyHolidayPageState();
}

class _HealthyHolidayPageState extends State<HealthyHolidayPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _heroController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Contrôleur vidéo pour le hero background
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;

  String activeCategory = 'wellness';

  final categories = [
    {'id': 'wellness', 'name': 'Wellness Retreats', 'icon': Icons.landscape},
    {'id': 'spa', 'name': 'Spa & Thalasso', 'icon': Icons.waves},
    {'id': 'yoga', 'name': 'Yoga & Meditation', 'icon': Icons.favorite},
    {'id': 'detox', 'name': 'Detox Programs', 'icon': Icons.eco},
  ];

  final Map<String, List<Map<String, dynamic>>> retreats = {
    'wellness': [
      {
        'title': 'Sahara Oasis Retreat',
        'location': 'Douz, Tunisia',
        'duration': '7 days',
        'rating': 4.8,
        'price': '\$1,200',
        'image': 'assets/healthy_holiday/sahara_retreat.jpg',
        'features': [
          'Desert Meditation',
          'Traditional Hammam',
          'Camel Therapy',
        ],
      },
      {
        'title': 'Mediterranean Wellness Villa',
        'location': 'Hammamet, Tunisia',
        'duration': '5 days',
        'rating': 4.9,
        'price': '\$950',
        'image': 'assets/healthy_holiday/med_villa.jpg',
        'features': ['Sea View Yoga', 'Olive Oil Therapy', 'Organic Cuisine'],
      },
    ],
    'spa': [
      {
        'title': 'Royal Thalasso Center',
        'location': 'Sousse, Tunisia',
        'duration': '3 days',
        'rating': 4.7,
        'price': '\$680',
        'image': 'assets/healthy_holiday/thalasso.jpg',
        'features': ['Seawater Therapy', 'Marine Algae Wrap', 'Mineral Baths'],
      },
    ],
    'yoga': [
      {
        'title': 'Zen Desert Experience',
        'location': 'Tozeur, Tunisia',
        'duration': '4 days',
        'rating': 4.9,
        'price': '\$800',
        'image': 'assets/healthy_holiday/zen_desert.jpg',
        'features': ['Sunrise Yoga', 'Meditation Circles', 'Sound Healing'],
      },
    ],
    'detox': [
      {
        'title': 'Coastal Detox Retreat',
        'location': 'Mahdia, Tunisia',
        'duration': '6 days',
        'rating': 4.6,
        'price': '\$1,100',
        'image': 'assets/healthy_holiday/coastal_detox.jpg',
        'features': ['Juice Cleanse', 'Colon Hydrotherapy', 'Raw Food Diet'],
      },
    ],
  };

  final wellnessTips = [
    {
      'icon': Icons.wb_sunny,
      'title': 'Hydration is Key',
      'description': 'Drink plenty of water in Tunisia\'s warm climate',
    },
    {
      'icon': Icons.eco,
      'title': 'Try Local Superfoods',
      'description': 'Dates, argan oil, and mint tea for wellness',
    },
    {
      'icon': Icons.waves,
      'title': 'Embrace the Sea',
      'description': 'Mediterranean waters offer natural healing',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Initialisation du contrôleur vidéo avec un lien réseau (remplacez par votre vidéo)
    _videoController = VideoPlayerController.network(
      'assets/videos/healthy.mp4',
    );
    _initializeVideoPlayerFuture = _videoController.initialize().then((_) {
      _videoController.setLooping(true);
      _videoController.setVolume(0.0); // silence
      _videoController.play();
      setState(() {}); // Rafraîchir après init
    });

    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _heroController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
          ),
        );

    _animationController.forward();
    _heroController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _heroController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildCategoryNavigation(),
            _buildFeaturedRetreats(),
            _buildWellnessTips(),
            _buildCallToAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video en arrière-plan
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                );
              } else {
                // Afficher placeholder ou loader
                return Container(color: Color(0xFF0D7377));
              }
            },
          ),

          // Overlay dégradé sombre pour lire le texte
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),

          // Contenu texte animé par-dessus
          AnimatedBuilder(
            animation: _heroController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - _heroController.value)),
                child: Opacity(
                  opacity: _heroController.value,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Healthy Holiday',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Relax. Rejuvenate. Rediscover Tunisia.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
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

  Widget _buildPlayButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        color: Colors.white.withOpacity(0.15),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            HapticFeedback.lightImpact();
            // Ici, vous pouvez envisager d'ouvrir un modal vidéo ou une autre page vidéo si besoin.
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.play_arrow, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Watch Our Story',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryNavigation() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isActive = activeCategory == category['id'];

            return AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - _fadeAnimation.value)),
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            activeCategory = category['id'] as String;
                          });
                          HapticFeedback.selectionClick();
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: isActive
                                ? LinearGradient(
                                    colors: [
                                      Color(0xFF0D7377),
                                      Color(0xFF14A085),
                                    ],
                                  )
                                : null,
                            color: isActive ? null : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: isActive
                                    ? Color(0xFF0D7377).withOpacity(0.3)
                                    : Colors.grey.withOpacity(0.1),
                                blurRadius: isActive ? 15 : 10,
                                offset: Offset(0, isActive ? 8 : 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                category['icon'] as IconData,
                                color: isActive
                                    ? Colors.white
                                    : Color(0xFF0D7377),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                category['name'] as String,
                                style: TextStyle(
                                  color: isActive
                                      ? Colors.white
                                      : Color(0xFF0D7377),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeaturedRetreats() {
    final currentRetreats = retreats[activeCategory] ?? [];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categories.firstWhere((c) => c['id'] == activeCategory)['name']
                as String,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 24),
          ...currentRetreats.asMap().entries.map((entry) {
            return _buildRetreatCard(entry.value, entry.key);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRetreatCard(Map<String, dynamic> retreat, int index) {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - _fadeAnimation.value), 0),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              margin: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Material(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    HapticFeedback.lightImpact();
                    // Navigation vers détails retraite
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        child: Image.asset(
                          retreat['image'],
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              retreat['title'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      retreat['duration'],
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 16),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      retreat['rating'].toString(),
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: (retreat['features'] as List<String>)
                                  .map((feature) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF0D7377).withOpacity(0.1),
                                            Color(0xFF14A085).withOpacity(0.1),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        feature,
                                        style: TextStyle(
                                          color: Color(0xFF0D7377),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  })
                                  .toList(),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF0D7377),
                                    Color(0xFF14A085),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    // Action réservation
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Book Now',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWellnessTips() {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0D7377).withOpacity(0.05),
            Color(0xFF14A085).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Wellness Tips for Tunisia',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ...wellnessTips.asMap().entries.map((entry) {
            return AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - _fadeAnimation.value)),
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF0D7377), Color(0xFF14A085)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              entry.value['icon'] as IconData,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.value['title'] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  entry.value['description'] as String,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCallToAction() {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6B46C1), Color(0xFF0D7377), Color(0xFF14A085)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Ready for Your Healthy Holiday?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Start your wellness journey in Tunisia today',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  HapticFeedback.lightImpact();
                  // Handle trip planning here
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Text(
                    'Plan My Trip',
                    style: TextStyle(
                      color: Color(0xFF0D7377),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
