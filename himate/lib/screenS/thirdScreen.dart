import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:himate/groupcallscreen.dart';
import 'package:himate/screenS/widget/CustomWidget.dart';


class Thirdscreen extends StatelessWidget {
  const Thirdscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            height: 30,
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF640472)),
                borderRadius: BorderRadius.circular(30)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wallet,
                  color: Colors.pink,
                ),
                Text("100"),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCardWidget(
                name: "Deviya",
                title: "Madness",
                buttonText: "Join Group", // Dynamic button text
                onButtonPressed: () {
                  log("print");
                },
                isActive: true,
                color: "#D2ECE9", image: 'Asset/image/Group 66.png',
              ),
              CustomCardWidget(
                image: 'Asset/image/Group 65.png',
                name: "Nikita",
                title: "Dazzling Dose",
                buttonText: "Join Room",
                onButtonPressed: () {
                 //Groupcall
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Groupcall()));
                },
                isActive: false,
                color: "#ECCDF1",
              ),
              CustomCardWidget(
                image: 'Asset/image/guy.png',
                name: "Nikita",
                title: "Dazzling Dose",
                buttonText: "Join Room",
                onButtonPressed: () {},
                isActive: false,
                color: "#F8F2BC",
              ),
              CustomCardWidget(
                image: 'Asset/image/her.png',
                name: "Nikita",
                title: "Dazzling Dose",
                buttonText: "Join Room",
                onButtonPressed: () {

                },
                isActive: true,
                color: "#F7D0D8",
              ),
              CustomCardWidget(
                image: 'Asset/image/guy.png',
                name: "Nikita",
                title: "Dazzling Dose",
                buttonText: "Join Room",
                onButtonPressed: () {},
                isActive: true,
                color: "#D6E7F5",
              )
            ],
          ),
        ),
      ),
    );
  }
}
