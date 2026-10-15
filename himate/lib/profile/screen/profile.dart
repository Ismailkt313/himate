import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:himate/bottomscreens/custombottombar.dart';
import 'package:himate/screenS/VoiceScreen.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  String? selectedGender; // Tracks the selected gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 27.w),
              child: Text(
                "Create your Profile",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(height: 50.h),
            TextField(
              decoration: InputDecoration(
                labelText: 'User Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.r)),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            TextField(
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.r)),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              "Gender",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GenderButton(
                  label: "Male",
                  isSelected: selectedGender == "Male",
                  onPressed: () {
                    setState(() {
                      selectedGender = "Male";
                    });
                  },
                ),
              //  SizedBox(width: 15.w),
                GenderButton(
                  label: "Female",
                  isSelected: selectedGender == "Female",
                  onPressed: () {
                    setState(() {
                      selectedGender = "Female";
                    });
                  },
                ),
              ],
            ),
          
           
          ],
        ),
      ),
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(left: 30 ),
        child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedGender == 'Male') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SimpleBottomNavBar()));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const VoiceScreen()));
                    }
                    print("User Name: [Fetch from TextField]");
                    print("Date of Birth: [Fetch from TextField]");
                    print("Selected Gender: $selectedGender");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF06C92),
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: 170.w, vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 10.sp, color: Colors.white),
                  ),
                ),
              ),
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const GenderButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 150.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.r),
          ),
          backgroundColor: isSelected ? const Color(0xFFB58EBB) : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 18.sp),
        ),
      ),
    );
  }
}
