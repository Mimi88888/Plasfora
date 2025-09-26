import 'package:flutter/material.dart';

class VisitTunisiaPage extends StatefulWidget {
  const VisitTunisiaPage({super.key});

  @override
  State<VisitTunisiaPage> createState() => _VisitTunisiaPageState();
}

class _VisitTunisiaPageState extends State<VisitTunisiaPage>
    with TickerProviderStateMixin {
  int selectedCategoryIndex = 0;

  final List<CategoryItem> categories = [
    CategoryItem(
      'Clinics',
      'assets/visit_tunisia/clinic.png', // your local image path
      const Color(0xFF667eea),
      const Color(0xFF764ba2),
    ),
    CategoryItem(
      'Hotels',
      'assets/visit_tunisia/hotel.png',
      const Color(0xFFf093fb),
      const Color(0xFFf5576c),
    ),
    CategoryItem(
      'Wellness',
      'assets/visit_tunisia/lotus.png',
      const Color(0xFF4facfe),
      const Color(0xFF00f2fe),
    ),
    CategoryItem(
      'Tours',
      'assets/visit_tunisia/museum.png',
      const Color(0xFF43e97b),
      const Color(0xFF38f9d7),
    ),
    CategoryItem(
      'Food',
      'assets/visit_tunisia/dinner.png',
      const Color(0xFFfa709a),
      const Color(0xFFfee140),
    ),
  ];

  final List<PackageCard> packages = [
    PackageCard(
      'Premium Dental & Spa',
      'Sidi Bou Said',
      'From \$2,500',
      '5 days • All inclusive',
      'assets/visit_tunisia/spa.jpg',
    ),
    PackageCard(
      'Cosmetic & Recovery',
      'Hammamet',
      'From \$3,200',
      '7 days • Luxury resort',
      'assets/visit_tunisia/cosmetic.jpg',
    ),
    PackageCard(
      'Hair Transplant Package',
      'Tunis',
      'From \$1,800',
      '4 days • Premium clinic',
      'assets/visit_tunisia/hair.jpg',
    ),
  ];
  final List<DestinationCard> destinations = [
    DestinationCard(
      'Carthage',
      const Color(0xFF4facfe),
      'assets/visit_tunisia/Carthage.jpg',
    ),
    DestinationCard(
      'Sidi Bou Said',
      const Color(0xFF667eea),
      'assets/visit_tunisia/sidiBou (2).jpg',
    ),
    DestinationCard(
      'Sahara Desert',
      const Color(0xFFfa709a),
      'assets/visit_tunisia/Sahara.jpg',
    ),
    DestinationCard(
      'Hammamet',
      const Color(0xFF43e97b),
      'assets/visit_tunisia/hammamet.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background gradient
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFf8fbff), Color(0xFFe8f4fd)],
                ),
              ),
            ),

            // Main content
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: screenHeight * 0.25,
                  pinned: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(background: _buildHeader()),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildCategoryNavigation(screenHeight),
                          _buildFeaturedPackages(screenHeight, screenWidth),
                          _buildPopularDestinations(screenHeight, screenWidth),
                          _buildWellnessSection(screenWidth),
                          const SizedBox(
                            height: 20,
                          ), // fixed value instead of proportional
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF40c9ff), Color(0xFFe81cff)],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/visit_tunisia/montagne.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.1),
                    BlendMode.overlay,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Visit Tunisia',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 4,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Medical Excellence Meets Mediterranean Beauty',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryNavigation(double screenHeight) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: screenHeight * 0.10,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = selectedCategoryIndex == index;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [category.startColor, category.endColor],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: category.startColor.withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Image.asset(
                          category.iconPath,
                          width: 30,
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF40c9ff)
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeaturedPackages(double screenHeight, double screenWidth) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Featured Packages',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1a1a1a),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF40c9ff),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: screenHeight * 0.32, // a bit taller to avoid overflow
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index];
                return _buildPackageCard(package, screenHeight, screenWidth);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(
    PackageCard package,
    double screenHeight,
    double screenWidth,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: screenWidth * 0.7, // <-- dynamic width here

      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.18,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: AssetImage(package.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1a1a1a),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text('📍', style: TextStyle(fontSize: 12)),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              package.location,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        package.duration,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF40c9ff),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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

  Widget _buildPopularDestinations(double screenHeight, double screenWidth) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Popular Destinations',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1a1a1a),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF40c9ff),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: (screenWidth / 2) / (screenHeight * 0.18),
            ),
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return _buildDestinationCard(destination);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(DestinationCard destination) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(destination.imagePath),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                destination.color.withOpacity(0.6),
                destination.color.withOpacity(0.9),
              ],
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Text(
                  destination.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 4,
                        color: Colors.black26,
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

  Widget _buildWellnessSection(double screenWidth) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Wellness Retreats',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Combine healing with luxury spa experiences in Tunisia\'s finest resorts',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Colors.white.withOpacity(0.3)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Discover Packages',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

// Data models
class CategoryItem {
  final String name;
  final String iconPath; // changed from String icon emoji to image path
  final Color startColor;
  final Color endColor;

  CategoryItem(this.name, this.iconPath, this.startColor, this.endColor);
}

class PackageCard {
  final String title;
  final String location;
  final String price;
  final String duration;
  final String imagePath;

  PackageCard(
    this.title,
    this.location,
    this.price,
    this.duration,
    this.imagePath,
  );
}

class DestinationCard {
  final String name;
  final Color color;
  final String imagePath; // new field for image asset path

  DestinationCard(this.name, this.color, this.imagePath);
}
