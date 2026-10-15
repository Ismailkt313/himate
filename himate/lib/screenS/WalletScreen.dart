import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:himate/screenS/TwoScreen.dart';
import 'package:lottie/lottie.dart';

class Walletscreen extends StatefulWidget {
  const Walletscreen({super.key});

  @override
  State<Walletscreen> createState() => _WalletscreenState();
}

class _WalletscreenState extends State<Walletscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FFE6F8"),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        backgroundColor: HexColor("#FFE6F8"),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 200,
                  width: 700,
                  child: Image.asset(
                    "Asset/image/Group 253.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Red Heart",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Text(
                            "10",
                            style: TextStyle(
                                color: HexColor("#B177BA"),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                  Image.asset(
                    "Asset/image/Group 251.png",
                    height: 40,
                  ),
                  Column(
                    children: [
                      const Text(
                        "Money",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "20",
                        style: TextStyle(
                            color: HexColor("#B177BA"),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              Positioned(
                bottom: 40,
                child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            backgroundColor:
                                WidgetStatePropertyAll(HexColor("#F06C92"))),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                height: 700,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 250,
                                      width: double.infinity,
                                      color: Colors.grey[200],
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Withdraw Your Money',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "Your UPI Id",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 10,
                                            ),
                                            hintText: '',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            suffixIcon:
                                                Icon(CupertinoIcons.pen),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Amount of money",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 10,
                                            ),
                                            hintText: '',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("5% TDS"),
                                          Text("₹26"),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 40,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  HexColor("#F06C92")),
                                        ),
                                        onPressed: () {
                                          // Close the first modal and open the second
                                          Navigator.pop(context);
                                          showSecondBottomSheet(context);
                                        },
                                        child: const Text(
                                          "Withdraw",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                          "Withdraw",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
              ),
              const Positioned(
                bottom: 1,
                child: Row(
                  children: [
                    Text(
                      "Conversion rate:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Text(
                      '1₹2.0',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            height: 300,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Center(
                                  child: Image.asset(
                                    "Asset/image/money.png",
                                    height: 100,
                                  ),
                                ),
                                const Center(
                                  child: Text(
                                    'How to earn more?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: HexColor("#B177BA"),
                                      child: const Center(
                                          child: Text(
                                        "1",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      'Create your call',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: HexColor("#B177BA"),
                                      child: const Center(
                                          child: Text(
                                        "2",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      'Talk & get Red Heart',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: HexColor("#B177BA"),
                                      child: const Center(
                                          child: Text(
                                        "3",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      'Earn real money from',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
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
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    height: 128,
                    width: 166,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: HexColor("#ECCDF1")),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "How to \nearn more?",
                          style: TextStyle(color: Colors.white),
                        ),
                        Image.asset(
                          "Asset/image/money.png",
                          height: 75,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Twoscreen()),
                    );
                  },
                  child: Container(
                    height: 128,
                    width: 166,
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: HexColor("#ECCDF1")),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "How to increase \nconversion rate?",
                          style: TextStyle(color: Colors.white),
                        ),
                        Image.asset(
                          "Asset/image/Group 254.png",
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: HexColor("#F5E9F7"),
                //color: Colors.red,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      //color: HexColor("#F5E9F7"),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        "Recent Transactions",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void showSecondBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: 250,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Withdraw in your Bank Account',
              style: TextStyle(
                color: HexColor("#640472"),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Manually input the UPI ID',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              "Your Mobile Number",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10, // Horizontal padding for the text
                    ),
                    hintText: 'PhonePe, Gpay, Paytm UPI no.',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsets.all(10.0), // Padding for the icon
                      child: Image.asset(
                        "Asset/image/Group 255 (1).png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16, // Ensures text and hint are visually balanced
                  ),
                  textAlignVertical:
                      TextAlignVertical.center, // Centers the text vertically
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
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
                  Navigator.pop(context);
                  showThirdBottomSheet(context);
                },
                child: const Text(
                  "Withdrawal",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showThirdBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: 250,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Lottie.asset(
              'Asset/lotttie/done.json', // Replace with your Lottie file path
              height: 130,
              // controller: _controller,
              // onLoaded: (composition) {
              //   _controller.duration = composition.duration;
              //   _playAnimation();
              // },
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor: WidgetStateProperty.all(HexColor("#F06C92")),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Withdrawal",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
