import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:himate/screen2.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6F8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.h, left: 20.w),
              child: Row(
                children: [
                  Image.asset(
                    "Asset/image/logo.png",
                    height: 70.h,
                    width: 130.w,
                  ),
                ],
              ),
            ),
            Image.asset(
              "Asset/image/img3.png",
              height: 410.h,
              width: 390.w,
            ),
            SizedBox(
              height: 200.h,
            ),
            SizedBox(
              height: 50.h,
              width: 420.w,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const Splashtwo()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF06C92),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
