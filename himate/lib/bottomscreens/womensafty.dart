import 'package:flutter/material.dart';
import 'package:himate/callscreen/callcsreen2.dart';

class Safty extends StatefulWidget {
  const Safty({super.key});

  @override
  State<Safty> createState() => _SaftyState();
}

class _SaftyState extends State<Safty> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Callscreen()), // Replace NextPage with your actual page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('Asset/image/womensafty.png', width: 319),
      ),
    );
  }
}
