import 'package:flutter/material.dart';
import 'package:himate/bottomscreens/custombottombar.dart';
import 'package:lottie/lottie.dart';

class Processingani extends StatefulWidget {
  const Processingani({super.key});

  @override
  State<Processingani> createState() => _ProcessinganiState();
}

class _ProcessinganiState extends State<Processingani> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Default duration
    );

    // Listen for animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAnimationCompleted = true;

          // Navigate to the next page after the animation is completed
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  const SimpleBottomNavBar()), // Replace with your next page
            );
          });
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _playAnimation();
  }

  void _playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation
            Lottie.asset(
              'Asset/lotttie/done.json', // Replace with your Lottie file path
              height: 150,
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
                _playAnimation();
              },
            ),
            const SizedBox(height: 20),

            // Show all three texts only after animation completes
            if (_isAnimationCompleted) ...[
              const Text(
                'Thanks! We are processing',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Your Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'This should only take a few seconds',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Dummy NextPage for navigation
class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next Page')),
      body: const Center(
        child: Text(
          'Welcome to the Next Page!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
