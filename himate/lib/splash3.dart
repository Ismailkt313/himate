import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:himate/auth/screen/mobienumber.dart';

class Splashthree extends StatefulWidget {
  const Splashthree({super.key});

  @override
  State<Splashthree> createState() => _SplashthreeState();
}

class _SplashthreeState extends State<Splashthree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6F8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100.h, left: 20.w),
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
              "Asset/image/splash3.png",
              height: 410.h,
              width: 390.w,
            ),
            SizedBox(height: 270.h),
            SizedBox(
              height: 50.h,
              width: 420.w,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const Numberverification()));
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFF06C92)),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
