import 'package:flutter/material.dart';

class Homeone extends StatefulWidget {
  const Homeone({super.key});

  @override
  State<Homeone> createState() => _HomeoneState();
}
class _HomeoneState extends State<Homeone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
       Image.asset(
        "Asset/image/logo.png",
        height: 30,
        width: 60,
       ),
      ],), 
    );
  }
}