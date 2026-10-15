
import 'package:flutter/material.dart';
import 'package:himate/stepper.dart';
import 'package:lottie/lottie.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen>
    with SingleTickerProviderStateMixin {
  bool isRecording = true;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.9,
      upperBound: 1.2,
    )..repeat(reverse: true); // Pulsating animation
  }

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
      if (isRecording) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.stop();
        _animationController.value = 1.0; // Reset to default size

        // Navigate to the next screen after a 5-second delay
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Stepperkyc()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Female audio test",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 200),
            const Center(
              child: Text(
                "What is your \nfavourite flower?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 200),
            Center(
              child: isRecording
                  ? const Text(
                      "Click button and read the above line",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    )
                  : const Text(
                      "Recording",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: toggleRecording,
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: isRecording
                      ? ScaleTransition(
                          scale: _animationController,
                          child: Image.asset(
                            "Asset/image/Group 12.png",
                            height: 70,
                            key: const ValueKey("recording"),
                          ),
                        )
                      : Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Lottie.asset('Asset/lotttie/9xoXUehQ4V.json',
                                height: 100, width: 700),
                            Image.asset(
                              "Asset/image/Group 12 (1).png",
                              height: 60,
                            )
                          ],
                        )),
            ),
          ],
        ),
      ),
    );
  }
}

// 