
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:himate/bottomscreens/carousalslider.dart';
import 'package:himate/toprightdetailspage.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({super.key});

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD8F3),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30.w,
                ),
                Image.asset(
                  "Asset/image/logo.png",
                  height: 130.h,
                  width: 110.w,
                ),
                SizedBox(
                  width: 150.w,
                ),
                Image.asset(
                  "Asset/image/wallet2.png",
                  height: 60.h,
                  width: 60.w,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const detailsright(),
                    ),
                  ),
                  child: Image.asset(
                    "Asset/image/profile.png",
                    height: 50.h,
                    width: 60.w,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ProfileWidget(
                    imageUrl: "Asset/image/jeev.png",
                    name: 'Mrudul ',
                    description: 'Searching for a connection',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ProfileWidget(
                    imageUrl: "Asset/image/her.png",
                    name: 'Sayanah',
                    description: 'Fwb',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ProfileWidget(
                    imageUrl: "Asset/image/guy.png",
                    name: 'Preeth',
                    description: 'to marry someone',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            Container(
              width: 400.w,
              padding: const EdgeInsets.symmetric(horizontal:6,vertical: 20),
              height: 190.h,
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14.r)),
                border: Border.all(
                  color: const Color(0xFF2FB9A9),
                ),
                color: const Color(0xFFD2ECE9),
              ),
              child:  Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image(
                              image: const AssetImage('Asset/image/createcall.png'),
                              height: 70.h,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Create Call',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            )
                          ],
                        ),
                        
                        Image(
                          image: const AssetImage('Asset/image/create call.png'),
                          height: 130.h,
                          width: 110.w,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
        
            
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(
                          child: Text(
                        "Mystery Call",
                        style: TextStyle(color: Color(0xFF640472)),
                      )),
                      content: SizedBox(
                        height: 120.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                      const Color(0xFF8DF2F2),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "Asset/image/acall.png",
                                        height: 30.h,
                                        width: 23.w,
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      const Text(
                                        "Audio Call",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                      const Color(0xFFB177BA),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "Asset/image/call.png",
                                        height: 30.h,
                                        width: 23.w,
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      const Text(
                                        "Vedio Call",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 190.h,
                width: 400.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(14.r)),
                  color: const Color(0xFFB177BA),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 22.w),
                    const Text(
                      'Mystery Call',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Image(
                      image: const AssetImage('Asset/image/type.png'),
                      height: 280.h,
                      width:200.w,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 190.h,
              width: 400.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14.r)),
                color: const Color(0xFFDF9CAA),
              ),
              child:  Row(
                children: [
                  SizedBox(
                    width: 22.w,
                  ),
                  const Text(
                    'Whisper Line',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 26),
                  ),const SizedBox(width: 15,),
                  
                  Image(
                    image: const AssetImage('Asset/image/whisper line.png'),
                    height: 200.h,
                    width: 200.w,
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              color: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
