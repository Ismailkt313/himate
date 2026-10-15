import 'package:flutter/material.dart';
import 'package:himate/bottomscreens/custombottombar.dart';

class Callbottm extends StatefulWidget {
  const Callbottm({super.key});

  @override
  State<Callbottm> createState() => _CallbottmState();
}

class _CallbottmState extends State<Callbottm> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are You Sure You Want to Exit?'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                   Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SimpleBottomNavBar ()));
                },
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    side:
                        WidgetStatePropertyAll(BorderSide(color: Colors.pink))),
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.pink),
                ),
              ),
              ElevatedButton(
                onPressed: () {
     Navigator.pop(context);

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Set button background to pink
                  side: const BorderSide(
                      color: Colors.pink), // Optional: Add pink border
                ),
                child: const Text(
                  "No",
                  style: TextStyle(
                    color: Colors.white, // Set text color to white
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF2D4F6), // Pink background for the tab bar
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                // _onTap(index);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'Asset/image/Group 264.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // _onTap(index);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'Asset/image/Group 265.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _showMyDialog();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'Asset/image/Group 266.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // _onTap(index);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'Asset/image/Group 267.png',
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
