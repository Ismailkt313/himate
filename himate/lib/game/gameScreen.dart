
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class HeartCatchingGame extends StatefulWidget {
  const HeartCatchingGame({super.key});

  @override
  _HeartCatchingGameState createState() => _HeartCatchingGameState();
}

class _HeartCatchingGameState extends State<HeartCatchingGame> {
  double basketPosition = 0.0;
  List<Heart> hearts = [];
  double basketWidth = 80.0;
  double basketHeight = 20.0;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  late Timer gameTimer;
  late Timer heartTimer;
  Random random = Random();
  int score = 0;
  int timeLeft = 30; // Set the timer to 30 seconds

  @override
  void initState() {
    super.initState();

    // Start the game timer
    gameTimer = Timer.periodic(const Duration(milliseconds: 50), _gameLoop);

    // Start the countdown timer
    heartTimer = Timer.periodic(const Duration(seconds: 1), _countdownTimer);
  }

  @override
  void dispose() {
    gameTimer.cancel();
    heartTimer.cancel();
    super.dispose();
  }

  void _gameLoop(Timer timer) {
    setState(() {
      // Move hearts down
      for (var heart in hearts) {
        heart.move();
      }

      // Add new heart randomly
      if (random.nextDouble() < 0.05) {
        hearts.add(Heart(
          x: random.nextDouble() * (screenWidth - 40),
          y: 0,
        ));
      }

      // Detect collision with basket
      hearts.removeWhere((heart) {
        if (heart.y + 40 >= screenHeight - basketHeight &&
            heart.x >= basketPosition &&
            heart.x <= basketPosition + basketWidth) {
          // Increment score when a heart is caught
          score++;
          return true; // Remove heart
        }
        return false;
      });

      // Remove hearts that go out of bounds
      hearts.removeWhere((heart) => heart.y > screenHeight);
    });
  }

  // Countdown timer function
  void _countdownTimer(Timer timer) {
    if (timeLeft > 0) {
      setState(() {
        timeLeft--;
      });
    } else {
      gameTimer.cancel(); // Stop the game once time runs out
      heartTimer.cancel(); // Stop the countdown timer
      _showGameOverDialog();
    }
  }

  // Display game over dialog
  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Your Score: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  // Restart the game
  void _restartGame() {
    setState(() {
      score = 0;
      timeLeft = 30;
      hearts.clear();
      basketPosition = 0.0;
    });

    // Restart the timers
    gameTimer = Timer.periodic(const Duration(milliseconds: 50), _gameLoop);
    heartTimer = Timer.periodic(const Duration(seconds: 1), _countdownTimer);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            setState(() {
              basketPosition += details.delta.dx;
              // Prevent basket from going off-screen
              if (basketPosition < 0) basketPosition = 0;
              if (basketPosition > screenWidth - basketWidth) {
                basketPosition = screenWidth - basketWidth;
              }
            });
          },
          child: Stack(
            children: [
              // Background color
              Positioned.fill(
                child: Container(
                  color: const Color(0xFFFFE6F8), // Background color #FFE6F8
                ),
              ),
              ...hearts.map((heart) => Positioned(
                    left: heart.x,
                    top: heart.y,
                    child: const HeartWidget(),
                  )),
              Positioned(
                bottom: 0,
                left: basketPosition,
                child: Container(
                  width: basketWidth,
                  height: basketHeight,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
              // Score Display
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  'Score: $score',
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
              // Timer Display
              Positioned(
                top: 20,
                right: 20,
                child: Text(
                  'Time: $timeLeft',
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Heart {
  double x, y;

  Heart({required this.x, required this.y});

  void move() {
    y += 5; // Move down by 5 units every frame
  }
}

class HeartWidget extends StatelessWidget {
  const HeartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite,
      color: Colors.red,
      size: 40,
    );
  }
}

