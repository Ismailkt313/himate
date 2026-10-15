import 'package:flutter/material.dart';
import 'package:himate/screenS/widget/UserAvatar.dart';


class CustomUserRow extends StatelessWidget {
  final String name;
  final String time;
  final VoidCallback onCallPressed;
  final VoidCallback onBlockPressed;
  final bool isActive;
  final String image;

  const CustomUserRow({
    super.key,
    required this.name,
    required this.time,
    required this.onCallPressed,
    required this.onBlockPressed,
    required this.isActive, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 117,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserAvatar(
               image: image,
              name: name,
              statusColor: isActive ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 10), // Add spacing
            Text(
              time,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              height: 30,
              width: 75,
              child: ElevatedButton(
                onPressed: onCallPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[100], // Call button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Colors.green), // Border color
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Call",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold), // Text color
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 30,
              width: 75,
              child: ElevatedButton(
                onPressed: onBlockPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[100], // Block button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Colors.red), // Border color
                  ),
                ),
                child: const Text(
                  "Block",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold), // Text color
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
