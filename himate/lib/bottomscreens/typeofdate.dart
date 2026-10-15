

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:himate/bottomscreens/womensafty.dart';

class TypeOfDateScreen extends StatefulWidget {
  const TypeOfDateScreen({super.key});

  @override
  State<TypeOfDateScreen> createState() => _TypeOfDateScreenState();
}

class _TypeOfDateScreenState extends State<TypeOfDateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 26.w, top: 70.h),
              child: Row(
                children: [
                  _buildCard(
                    color: const Color(0xFFDF9CAA),
                    title: 'Move on',
                    titleColor: Colors.red,
                    imagePath: 'Asset/image/boy.png',
                  ),
                  SizedBox(width: 23.w),
                  _buildCard(
                    color: const Color(0xFFD2ECE9),
                    title: 'Marriage',
                    titleColor: Colors.green,
                    imagePath: 'Asset/image/marrage.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 26.w),
              child: Row(
                children: [
                  _buildCard(
                    color: const Color(0xFFD3B0D9),
                    title: 'Travel',
                    titleColor: Colors.purple,
                    imagePath: 'Asset/image/travelworld.png',
                  ),
                  SizedBox(width: 24.w),
                  _buildCard(
                    color: const Color(0xFFF7F0AF),
                    title: 'Books',
                    titleColor: Colors.black,
                    imagePath: 'Asset/image/read book.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 26.w),
              child: Row(
                children: [
                  _buildCard(
                    color: const Color(0xFFDF9CAA),
                    title: 'Move on',
                    titleColor: Colors.red,
                    imagePath: 'Asset/image/travelworld.png',
                  ),
                  SizedBox(width: 24.w),
                  _buildCard(
                    color: const Color(0xFFF7D0D8),
                    title: 'Movies',
                    titleColor: Colors.black,
                    imagePath: 'Asset/image/movies.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              height: 50.h,
              width: 400.w,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Safty()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    const Color(0xFFF06C92),
                  ),
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

  Widget _buildCard({
    required Color color,
    required String title,
    required Color titleColor,
    required String imagePath,
  }) {
    return Container(
      height: 240.h,
      width: 170.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 2.h),
          Text(
            title,
            style: TextStyle(fontSize: 24.sp, color: titleColor),
          ),
          SizedBox(height: 5.h),
          Image.asset(
            imagePath,
            height: 190.h,
            width: 150.w,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

