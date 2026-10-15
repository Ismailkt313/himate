
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:himate/bottomscreens/typeofdate.dart';

class Secondbottomscreen extends StatefulWidget {
  const Secondbottomscreen({super.key});

  @override
  State<Secondbottomscreen> createState() => _SecondbottomscreenState();
}

class _SecondbottomscreenState extends State<Secondbottomscreen> {
  final bool _animate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 260.h,
            width: 500.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Asset/image/Group 277.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 26.w, top: 20.h),
                  child: Row(
                    children: [
                      SizedBox(width: 250.w),
                      Image.asset(
                        'Asset/image/profile.png',
                        height: 60.h,
                        width: 80.w,
                      ),
                      Image.asset(
                        'Asset/image/Group 278.png',
                        height: 60.h,
                        width: 50.w,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'Asset/image/heher.png',
                    height: 180.h,
                    width: 200.w,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 260.h,
            width: 500.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Asset/image/Group 279.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TypeOfDateScreen(),
                            ),
                          );
                        },
                        child: AvatarGlow(
                          startDelay: const Duration(milliseconds: 1000),
                          glowColor: Colors.white,
                          glowShape: BoxShape.circle,
                          animate: _animate,
                          curve: Curves.fastOutSlowIn,
                          child: const Material(
                            elevation: 8.0,
                            shape: CircleBorder(),
                            color: Colors.transparent,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('Asset/image/Group 65.png'),
                              radius: 50.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      child: Text(
                        'Riya',
                        style: TextStyle(fontSize: 20.sp, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 60.h),
                    Padding(
                      padding: EdgeInsets.only(right: 240.w),
                      child: AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.white,
                        glowShape: BoxShape.circle,
                        animate: _animate,
                        curve: Curves.fastOutSlowIn,
                        child: const Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('Asset/image/Group 65.png'),
                            radius: 50.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(right: 240.w),
                      child: TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        child: Text(
                          'Sheela',
                          style: TextStyle(fontSize: 20.sp, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 80.h),
                    AvatarGlow(
                      startDelay: const Duration(milliseconds: 1000),
                      glowColor: Colors.grey,
                      glowShape: BoxShape.circle,
                      animate: _animate,
                      curve: Curves.fastOutSlowIn,
                      child: const Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        color: Colors.transparent,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('Asset/image/Group 66.png'),
                          radius: 40.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(right: 240.w),
                      child: TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        child: Text(
                          'Sheela',
                          style: TextStyle(fontSize: 20.sp, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
