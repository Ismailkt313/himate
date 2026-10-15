import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String name;
  final Color statusColor;
  final double avatarRadius;
  final double statusIndicatorSize;
  final String image;

  const UserAvatar({
    super.key,
    required this.name,
    this.statusColor = Colors.green,
    this.avatarRadius = 40,
    this.statusIndicatorSize = 15,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Stack(
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: AssetImage(image),
                  ),
                  Positioned(
                    right: 5,
                    top: 3,
                    child: Container(
                      height: statusIndicatorSize,
                      width: statusIndicatorSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: statusColor,
                        border: Border.all(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 15,
          child: Container(
            height: 25,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
