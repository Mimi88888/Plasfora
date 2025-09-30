import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'dart:math' as math;

class ProcessPage extends StatefulWidget {
  const ProcessPage({Key? key}) : super(key: key);

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

// Enhanced painter for animated dashed line
class AnimatedDashedLinePainter extends CustomPainter {
  final double animationValue;

  AnimatedDashedLinePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF3B82F6), Color(0xFF06B6D4), Color(0xFF8B5CF6)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width, size.height / 2);

    final dashedPath = dashPath(
      path,
      dashArray: CircularIntervalList<double>([8, 5]),
    );

    // Create animated effect
    final animatedPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          const Color(0xFF3B82F6).withOpacity(animationValue),
          const Color(0xFF06B6D4).withOpacity(animationValue),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Draw base dashed line with reduced opacity
    final basePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF3B82F6), Color(0xFF06B6D4), Color(0xFF8B5CF6)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Colors.blue.withOpacity(0.3);

    canvas.drawPath(dashedPath, basePaint);
    canvas.drawPath(dashedPath, animatedPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _ProcessPageState extends State<ProcessPage>
    with TickerProviderStateMixin {
  int activeStep = 0;
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late AnimationController _dashController;
  late AnimationController _cardController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _dashAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _dashController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _dashAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _dashController, curve: Curves.linear));
    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
    _pulseController.repeat(reverse: true);
    _dashController.repeat();
    _cardController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    _dashController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  final List<ProcessStep> steps = [
    ProcessStep(
      id: 1,
      title: "Contact & Consultation",
      subtitle: "Initial expert consultation",
      description:
          "Free online consultation with our medical experts to understand your needs and answer all questions. Our certified consultants are available 24/7 to guide you through every detail.",
      icon: Icons.video_call_rounded,
      colors: [const Color(0xFFFF6B6B), const Color(0xFFFF8E8E)],
      bgColor: const Color(0xFFFFF5F5),
      angle: 0,
    ),
    ProcessStep(
      id: 2,
      title: "Diagnosis & Custom Plan",
      subtitle: "Personalized treatment planning",
      description:
          "Comprehensive medical assessment by our specialists and creation of your personalized treatment plan with detailed cost breakdown and timeline.",
      icon: Icons.assignment_rounded,
      colors: [const Color(0xFF9C88FF), const Color(0xFFB8A9FF)],
      bgColor: const Color(0xFFF8F6FF),
      angle: 60,
    ),
    ProcessStep(
      id: 3,
      title: "Travel & Arrival",
      subtitle: "Seamless travel coordination",
      description:
          "Complete travel assistance including visa support, flight booking, airport pickup, and warm welcome to Tunisia with dedicated personal coordinator.",
      icon: Icons.flight_takeoff_rounded,
      colors: [const Color(0xFF4ECDC4), const Color(0xFF6DDDD6)],
      bgColor: const Color(0xFFF0FDFC),
      angle: 120,
    ),
    ProcessStep(
      id: 4,
      title: "Treatment Procedure",
      subtitle: "Expert medical care",
      description:
          "Professional medical treatment in state-of-the-art facilities with internationally certified surgeons and cutting-edge medical technology.",
      icon: Icons.medical_services_rounded,
      colors: [const Color(0xFF45B7D1), const Color(0xFF67C3DB)],
      bgColor: const Color(0xFFF0F9FF),
      angle: 180,
    ),
    ProcessStep(
      id: 5,
      title: "Recovery & Follow-up",
      subtitle: "Supervised recovery period",
      description:
          "Comfortable recovery in luxury accommodations with 24/7 medical supervision, physiotherapy sessions, and personalized care programs.",
      icon: Icons.spa_rounded,
      colors: [const Color(0xFF96CEB4), const Color(0xFFA8D5C4)],
      bgColor: const Color(0xFFF6FDF9),
      angle: 240,
    ),
    ProcessStep(
      id: 6,
      title: "Return & Aftercare",
      subtitle: "Ongoing support & care",
      description:
          "Safe return home with comprehensive aftercare package, telemedicine consultations, and continuous support for optimal long-term results.",
      icon: Icons.home_filled,
      colors: [const Color(0xFFFFB74D), const Color(0xFFFFCC80)],
      bgColor: const Color(0xFFFFF8E1),
      angle: 300,
    ),
  ];

  Offset getCirclePosition(double angle, double radius) {
    final radian = (angle - 90) * (math.pi / 180);
    return Offset(
      200 + radius * math.cos(radian),
      200 + radius * math.sin(radian),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8FAFF),
              Color(0xFFFFFFFF),
              Color(0xFFF0F9FF),
              Color(0xFFF8F6FF),
            ],
            stops: [0.0, 0.3, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                _buildAnimatedDashedLine(),
                _buildCircularDiagram(),
                _buildStepDetails(),
                _buildProgressIndicator(),
                _buildCallToAction(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Medical Tourism Excellence',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your Transformative\nMedical Journey',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1F2937),
                height: 1.2,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Experience world-class medical care with our proven 6-step process,\ndesigned to ensure your comfort, safety, and complete satisfaction.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
                height: 1.6,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStatCard('15K+', 'Happy Patients'),
                  const SizedBox(width: 24),
                  _buildStatCard('98%', 'Success Rate'),
                  const SizedBox(width: 24),
                  _buildStatCard('5★', 'Rating'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3B82F6),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedDashedLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: AnimatedBuilder(
        animation: _dashAnimation,
        builder: (context, child) {
          return CustomPaint(
            size: const Size(double.infinity, 4),
            painter: AnimatedDashedLinePainter(_dashAnimation.value),
          );
        },
      ),
    );
  }

  Widget _buildCircularDiagram() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: SizedBox(
        width: 400,
        height: 400,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                // Enhanced Connection Lines
                CustomPaint(
                  size: const Size(400, 400),
                  painter: EnhancedConnectionLinesPainter(
                    steps: steps,
                    animationValue: _fadeAnimation.value,
                    activeStep: activeStep,
                  ),
                ),
                // Enhanced Central Circle
                Positioned(
                  left: 200 - 56,
                  top: 200 - 56,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Container(
                            width: 112,
                            height: 112,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(56),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF667EEA,
                                  ).withOpacity(0.4),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(52),
                                color: Colors.white,
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.rocket_launch_rounded,
                                    color: Color(0xFF667EEA),
                                    size: 36,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'START',
                                    style: TextStyle(
                                      color: Color(0xFF667EEA),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Enhanced Step Circles
                ...steps.asMap().entries.map((entry) {
                  final index = entry.key;
                  final step = entry.value;
                  final position = getCirclePosition(
                    step.angle.toDouble(),
                    130,
                  );
                  final isActive = index == activeStep;
                  final isPassed = index < activeStep;

                  return AnimatedPositioned(
                    duration: Duration(milliseconds: 800 + (index * 150)),
                    curve: Curves.elasticOut,
                    left: position.dx - 48,
                    top: position.dy - 48,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => activeStep = index);
                        _cardController.reset();
                        _cardController.forward();
                      },
                      child: AnimatedScale(
                        scale: isActive ? 1.2 : 1.0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.elasticOut,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            gradient: LinearGradient(
                              colors: isActive
                                  ? [
                                      const Color(0xFF667EEA),
                                      const Color(0xFF764BA2),
                                    ]
                                  : isPassed
                                  ? [
                                      const Color(0xFF10B981),
                                      const Color(0xFF14B8A6),
                                    ]
                                  : step.colors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (isActive
                                            ? const Color(0xFF667EEA)
                                            : isPassed
                                            ? const Color(0xFF10B981)
                                            : step.colors[0])
                                        .withOpacity(0.4),
                                blurRadius: isActive ? 25 : 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(42),
                              color: step.bgColor,
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(
                                    step.icon,
                                    size: 32,
                                    color: isActive
                                        ? const Color(0xFF667EEA)
                                        : isPassed
                                        ? const Color(0xFF10B981)
                                        : step.colors[0],
                                  ),
                                ),
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: isPassed
                                          ? const Icon(
                                              Icons.check_rounded,
                                              size: 18,
                                              color: Color(0xFF10B981),
                                            )
                                          : Text(
                                              '${step.id}',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xFF374151),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStepDetails() {
    final currentStep = steps[activeStep];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: AnimatedBuilder(
        animation: _slideAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 30 * (1 - _slideAnimation.value)),
            child: Opacity(
              opacity: _slideAnimation.value,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: animation.drive(
                        Tween(
                          begin: const Offset(0.0, 0.3),
                          end: Offset.zero,
                        ).chain(CurveTween(curve: Curves.easeOut)),
                      ),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  key: ValueKey(activeStep),
                  width: double.infinity,
                  padding: const EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: currentStep.colors[0].withOpacity(0.2),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: currentStep.colors[0].withOpacity(0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: currentStep.colors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: currentStep.colors[0].withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(
                          currentStep.icon,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      Text(
                        currentStep.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1F2937),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentStep.subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: currentStep.colors[0],
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        currentStep.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B7280),
                          height: 1.6,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          // Step indicators
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: steps.asMap().entries.map((entry) {
                final index = entry.key;
                final step = entry.value;
                return GestureDetector(
                  onTap: () {
                    setState(() => activeStep = index);
                    _cardController.reset();
                    _cardController.forward();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    width: index == activeStep ? 32 : 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: index == activeStep
                          ? LinearGradient(colors: step.colors)
                          : null,
                      color: index == activeStep
                          ? null
                          : index < activeStep
                          ? const Color(0xFF10B981)
                          : const Color(0xFFE2E8F0),
                      boxShadow: index == activeStep
                          ? [
                              BoxShadow(
                                color: step.colors[0].withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          // Navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: activeStep > 0
                    ? () {
                        setState(() => activeStep--);
                        _cardController.reset();
                        _cardController.forward();
                      }
                    : null,
                icon: const Icon(Icons.arrow_back_rounded, size: 16),
                label: const Text('Previous'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF8FAFC),
                  foregroundColor: const Color(0xFF64748B),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  minimumSize: const Size(80, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Step ${activeStep + 1} of ${steps.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: activeStep < steps.length - 1
                    ? () {
                        setState(() => activeStep++);
                        _cardController.reset();
                        _cardController.forward();
                      }
                    : null,
                icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                label: const Text('Next'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  shadowColor: const Color(0xFF3B82F6).withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCallToAction() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(40.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2), Color(0xFF667EEA)],
          stops: [0.0, 0.5, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.health_and_safety_rounded,
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Ready to Transform Your Life?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Join 15,000+ satisfied patients who chose excellence',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFE0E7FF),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF667EEA),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 12,
              shadowColor: Colors.black.withOpacity(0.2),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.video_call_rounded, size: 20),
                SizedBox(width: 8),
                Text(
                  'Start Your Free Consultation',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTrustIndicator(Icons.schedule_rounded, 'Available 24/7'),
                const SizedBox(width: 5),
                _buildTrustIndicator(
                  Icons.verified_rounded,
                  'Certified Experts',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustIndicator(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ProcessStep {
  final int id;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final List<Color> colors;
  final Color bgColor;
  final int angle;

  ProcessStep({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.colors,
    required this.bgColor,
    required this.angle,
  });
}

class EnhancedConnectionLinesPainter extends CustomPainter {
  final List<ProcessStep> steps;
  final double animationValue;
  final int activeStep;

  EnhancedConnectionLinesPainter({
    required this.steps,
    required this.animationValue,
    required this.activeStep,
  });

  Offset getCirclePosition(double angle, double radius) {
    final radian = (angle - 90) * (math.pi / 180);
    return Offset(
      200 + radius * math.cos(radian),
      200 + radius * math.sin(radian),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = 200.0;
    final centerY = 200.0;
    final radius = 130.0;

    // Draw animated circular rings
    final ringPaint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Outer ring with gradient
    final outerRingPaint = Paint()
      ..shader =
          const LinearGradient(
            colors: [
              Color(0xFF667EEA),
              Color(0xFF764BA2),
              Color(0xFF3B82F6),
              Color(0xFF667EEA),
            ],
          ).createShader(
            Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
          )
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Draw multiple concentric rings for depth
    for (int i = 0; i < 3; i++) {
      final currentRadius = radius - (i * 15);
      final opacity = (0.4 - (i * 0.1)) * animationValue;

      ringPaint.color = const Color(0xFF667EEA).withOpacity(opacity);
      canvas.drawCircle(Offset(centerX, centerY), currentRadius, ringPaint);
    }

    // Draw outer decorative ring
    canvas.drawCircle(Offset(centerX, centerY), radius + 20, outerRingPaint);

    // Draw connection lines with enhanced styling
    for (int i = 0; i < steps.length; i++) {
      final position = getCirclePosition(steps[i].angle.toDouble(), radius);
      final isActiveConnection = i == activeStep;

      final linePaint = Paint()
        ..strokeWidth = isActiveConnection ? 4 : 2
        ..style = PaintingStyle.stroke;

      if (isActiveConnection) {
        // Active connection with gradient
        linePaint.shader = LinearGradient(
          colors: [
            const Color(0xFF667EEA).withOpacity(0.8),
            steps[i].colors[0],
          ],
        ).createShader(Rect.fromPoints(Offset(centerX, centerY), position));
      } else {
        linePaint.color = const Color(
          0xFF667EEA,
        ).withOpacity(0.2 * animationValue);
      }

      // Draw connection line
      canvas.drawLine(Offset(centerX, centerY), position, linePaint);

      // Draw small connecting dots
      final dotPaint = Paint()
        ..color = isActiveConnection
            ? steps[i].colors[0]
            : const Color(0xFF667EEA).withOpacity(0.5);

      final midPoint = Offset(
        centerX + (position.dx - centerX) * 0.7,
        centerY + (position.dy - centerY) * 0.7,
      );

      canvas.drawCircle(midPoint, isActiveConnection ? 4 : 2, dotPaint);
    }

    // Draw animated particles around the circle
    final particlePaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      final angle = (i * 45.0) + (animationValue * 360);
      final particlePosition = getCirclePosition(angle, radius + 35);

      particlePaint.color = const Color(
        0xFF667EEA,
      ).withOpacity(0.6 * (1 - ((i % 4) * 0.2)) * animationValue);

      canvas.drawCircle(particlePosition, 3, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
