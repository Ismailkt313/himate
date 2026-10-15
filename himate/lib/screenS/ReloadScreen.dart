import 'package:flutter/material.dart';
import 'package:himate/screenS/widget/CustomRow.dart';


class Reloadscreen extends StatelessWidget {
  const Reloadscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recent Call",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              CustomUserRow(
                image: 'Asset/image/guy.png',
                name: "Tommy",
                time: "12.06 minutes",
                onCallPressed: () {},
                onBlockPressed: () {},
                isActive: true,
              ),
              CustomUserRow(
                image: 'Asset/image/Group 66.png',
                name: "Raj",
                time: "12.06 minutes",
                onCallPressed: () {},
                onBlockPressed: () {},
                isActive: false,
              ),
              CustomUserRow(
                name: "Raj",
                time: "12.06 minutes",
                onCallPressed: () {},
                onBlockPressed: () {},
                isActive: true, 
                image: 'Asset/image/Group 65.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
