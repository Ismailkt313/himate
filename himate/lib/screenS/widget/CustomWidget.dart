import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:himate/screenS/widget/UserAvatar.dart';


class CustomCardWidget extends StatelessWidget {
  final String name;
  final String title;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool isActive;
  final String color;
  final String image;

  const CustomCardWidget({
    super.key,
    required this.name,
    required this.title,
    required this.buttonText,
    required this.onButtonPressed,
    required this.isActive, required this.color, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: HexColor(color),
          // color: ,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Profile Section
            Expanded(
              flex: 3,
              child: UserAvatar(
                image: image,
                name: "Deviya",
                statusColor: isActive ? Colors.green : Colors.red,
                // avatarRadius: 50,
                // statusIndicatorSize: 20,
              ),
            ),
            // Info Section
            Expanded(
              flex: 4,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: Stack(
                        children: [
                          _buildIconContainer(),
                          Positioned(left: 30, child: _buildIconContainer()),
                          Positioned(left: 60, child: _buildIconContainer()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Button Section
            Expanded(
              flex: 4,
              child: SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: onButtonPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF06C92), // #F06C92
                        ),
                        child: Text(
                          buttonText,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildIconContainer() {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}
