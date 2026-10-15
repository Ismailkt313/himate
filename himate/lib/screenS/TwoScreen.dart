import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Twoscreen extends StatelessWidget {
  const Twoscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: HexColor("#FFE6F8"),
            height: 100,
          ),
          Center(
            child: Image.asset(
              "Asset/image/zzz.png",
              height: 100,
            ),
          ),
          const Center(
            child: Text(
              'How to increase\nconversion rate?',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 300,
            //margin: const EdgeInsets.all(20),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2), // Adjust column width proportionally
                1: FlexColumnWidth(2),
              },
              //defaultColumnWidth: const FixedColumnWidth(120.0),
              border: TableBorder.all(
                  color: HexColor("#640472"),
                  style: BorderStyle.solid,
                  width: 1 ,
                  borderRadius: BorderRadius.circular(5)),

              children: [
                const TableRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // Header background color
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Badge',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Redeem Rate',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                    decoration: BoxDecoration(
                      color: HexColor("#FFE6F8"),
                    ),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Image.asset(
                              "Asset/image/Group 191.png",
                              height: 30,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )),
                    ]),
                TableRow(
                    decoration: BoxDecoration(
                      color: HexColor("#FFE6F8"),
                    ),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Image.asset(
                              "Asset/image/Group 192.png",
                              height: 30,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )),
                    ]),
                TableRow(
                    decoration: BoxDecoration(
                      color: HexColor("#FFE6F8"),
                    ),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Image.asset(
                              "Asset/image/Group 193.png",
                              height: 30,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )),
                    ]),
                TableRow(
                    decoration: BoxDecoration(
                      color: HexColor("#FFE6F8"),
                    ),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Image.asset(
                              "Asset/image/Group 194.png",
                              height: 30,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )),
                    ]),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              'Get gifts, play games, and level up your\nbadge—unlock higher earnings with \neach red heart.',
              textAlign: TextAlign.left,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStateProperty.all(
                HexColor("#F06C92"),
              ),
            ),
            onPressed: () {
              // Open the third bottom sheet
              // Navigator.pop(context);
              // showThirdBottomSheet(context);
            },
            child: const Text(
              "Create Call",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
