import 'package:flutter/material.dart';

Widget typeofdate({
  required String imageUrl,
  required String name,
  bool isAsset = true, // Add this flag to decide between asset or network image
}) {
  return Container(
    width: 200,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
      image: DecorationImage(
        image: isAsset
            ? AssetImage(imageUrl) // Use asset image
            : NetworkImage(imageUrl) as ImageProvider, // Use network image
        fit: BoxFit.cover, // Adjust the image to fill the container
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Ensure text is visible on background
          ),
        ),
        const SizedBox(height: 10),
        Image.asset('Asset/image/Group167.png'), // Another asset if required
        const SizedBox(height: 20),
      ],
    ),
  );
}
