import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:himate/splash3.dart';

class Splashtwo extends StatefulWidget {
  const Splashtwo({super.key});

  @override
  State<Splashtwo> createState() => _SplashtwoState();
}

class _SplashtwoState extends State<Splashtwo> {
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive UI
    return ScreenUtilInit(
      designSize: const Size(428, 926), // Base design size (adjust based on Figma/XD)
      builder: (context, child) {
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
                  "Asset/image/splash2.png",
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
                        context,
                        MaterialPageRoute(builder: (context) => const Splashthree()),
                      );
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
      },
    );
  }
}
