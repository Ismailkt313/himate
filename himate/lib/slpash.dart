import 'package:flutter/material.dart';
import 'package:himate/splash1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();

    _animation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Make the logo visible from the start and fade smoothly
    _fadeAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear), // Always visible
      ),
    );

    // Navigate to the next screen after animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ScreenOne()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxRadius = size.height * 1.5;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: Container(color: Colors.white)), // Background

          // Expanding wave animation
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return ClipPath(
                clipper: WaveClipper(_animation.value * maxRadius),
                child: Container(color: const Color(0xFFF2D4F6)),
              );
            },
          ),

          // Centered logo - Always visible
          Positioned(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                "Asset/image/logo.png",
                width: 200,
                height: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double radius;

  WaveClipper(this.radius);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    ));
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => true;
}