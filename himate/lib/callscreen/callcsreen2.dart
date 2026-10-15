// import 'package:flutter/material.dart';
// import 'package:himate/callscreen/callbottm.dart';

// class Callscreen extends StatefulWidget {
//   const Callscreen({super.key});

//   @override
//   State<Callscreen> createState() => _CallscreenState();
// }

// class _CallscreenState extends State<Callscreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Container(
//               // height: 450,
//               // width: 500,
//               color: Color(0xFFF2D4F6),
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: Image.asset(
//                       'Asset/image/badge.png',
//                       height: 80,
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 60),
//                       child: Image.asset(
//                         'Asset/image/profile.png',
//                         height: 160,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Container(
//               // height: 500,
//               // width: 500,
//               color: Colors.white,
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 7,
//                     child: Container(
//                       color: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [

//                           Image.asset(
//                             'Asset/image/glass.png',
//                             height: 160,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Container(
//                       color: Colors.white,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           //SizedBox(height: 80,),
//                           Text(
//                             'Follow',
//                             style: TextStyle(
//                                 fontSize: 24,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               color: Color(0xFFF2D4F6),
//                             ),
//                             child: Image.asset(
//                               'Asset/image/game.png',
//                               height: 50,
//                             ),
//                           ),
//                           Text(
//                             'Game',
//                             style: TextStyle(fontSize: 24, color: Colors.black),
//                           ),
//                           SizedBox(
//                             height: 30,
//                           ),

//                           Image.asset(
//                             'Asset/image/gift 1.png',
//                             height: 50,
//                           ),

//                           Text(
//                             'Gift',
//                             style: TextStyle(fontSize: 20, color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),

//               // child: Column(
//               //   children: [
//               //   Align(
//               //     alignment: Alignment.topRight,
//               //     child: Image.asset('Asset/image/badge.png', height: 80,),
//               //   ),
//               //   Center(
//               //     child: Padding(
//               //       padding: const EdgeInsets.only(top: 60),
//               //       child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.center,
//               //         children: [
//               //           Image.asset('Asset/image/glass.png', height: 160,),

//               //              Image.asset('Asset/image/gift 1.png', height: 50,),

//               //         ],
//               //       ),
//               //     ),
//               //   ),
//               //   ],
//               // ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: Callbottm(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:himate/callscreen/callbottm.dart';
import 'package:himate/game/gameScreen.dart';

class Callscreen extends StatefulWidget {
  const Callscreen({super.key});

  @override
  State<Callscreen> createState() => _CallscreenState();
}

class _CallscreenState extends State<Callscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Top Section
          Expanded(
            flex: 5,
            child: Container(
              color: const Color(0xFFF2D4F6),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                      child: Image.asset(
                        'Asset/image/badge.png',
                        height: 80,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Image.asset(
                        'Asset/image/profile.png',
                        height: 160,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  // Glass Image Section
                  Expanded(
                    flex: 7,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'Asset/image/glass.png',
                        height: 160,
                      ),
                    ),
                  ),
                  // Follow, Game, Gift Section
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Follow',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFFF2D4F6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => const HeartCatchingGame()),
                                );
                              },
                              child: Image.asset(
                                'Asset/image/game.png',
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Game',
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 500,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        "Send Gift",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              'Asset/image/rose.png',
                                              height: 60,
                                            ),
                                            Image.asset(
                                              'Asset/image/heart.png',
                                              height: 70,
                                            ),
                                            Image.asset(
                                              'Asset/image/ecited.png',
                                              height: 70,
                                            )
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              'Asset/image/love.png',
                                              height: 70,
                                            ),
                                            Image.asset(
                                              'Asset/image/data.png',
                                              height: 70,
                                            ),
                                            Image.asset(
                                              'Asset/image/happy.png',
                                              height: 70,
                                            )
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              'Asset/image/data.png',
                                              height: 70,
                                            ),
                                            Image.asset(
                                              'Asset/image/data.png',
                                              height: 70,
                                            ),
                                            Image.asset(
                                              'Asset/image/data.png',
                                              height: 70,
                                            )
                                          ]),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Image.asset(
                            'Asset/image/gift 1.png',
                            height: 50,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Gift',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const Callbottm(), // Custom Floating Action Button
    );
  }
}
