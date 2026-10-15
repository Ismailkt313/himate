import 'package:flutter/material.dart';

class bottomscreentwo extends StatefulWidget {
  const bottomscreentwo({super.key});

  @override
  State<bottomscreentwo> createState() => _bottomscreentwoState();
}

class _bottomscreentwoState extends State<bottomscreentwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250.0,
            width: 470.0,
            decoration: const BoxDecoration(
              color: Colors.green,
            ),

          )
        ],
      ),
    );
  }
}