import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Selectedavaterscreen extends StatelessWidget {
  Selectedavaterscreen({super.key});

  List<String> avatars = [
    'Asset/image/Group 65.png',
    'Asset/image/Group 66.png',
    'Asset/image/Group 67.png',
    'Asset/image/Group 186.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              // autoPlay: true,
              // aspectRatio: 2.0,
              // enlargeCenterPage: true,
              // enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: avatars.map((avatar) {
              return CircleAvatar(
                radius: 50,  // Adjust the size of the CircleAvatar
                backgroundImage: AssetImage(avatar),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
