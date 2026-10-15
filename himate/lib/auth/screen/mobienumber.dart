// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:himate/home.dart';

// class Numberverification extends StatefulWidget {
//   const Numberverification({super.key});

//   @override
//   State<Numberverification> createState() => _NumberverificationState();
// }

// class _NumberverificationState extends State<Numberverification> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFE6F8),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 60.h, left: 20.w),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     "Asset/image/logo.png",
//                     height: 70.h,
//                     width: 130.w,
//                   ),
//                 ],
//               ),
//             ),
//             Image.asset(
//               "Asset/image/Verification.png",
//               height: 410.h,
//               width: 390.w,
//             ),
//             SizedBox(height: 70.h),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
//              height: 350.h,
//               width:double.infinity,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEEB2DC),
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Mobile Number',
//                     style: TextStyle(fontSize: 16.sp),
//                   ),
//                   SizedBox(height: 15.h),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 13.w),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12.r),
//                       border: Border.all(color: Colors.white),
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           '+91',
//                           style: TextStyle(
//                               color: Colors.grey.shade800,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 8.w),
//                         Expanded(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 10.w),
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.symmetric(vertical: 10.h),
//                                 border: InputBorder.none,
//                                 hintText: '',
//                                 hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp),
//                               ),
//                               keyboardType: TextInputType.phone,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10,),
//                   Text(
//                     'We Keep Your Number Confidential',
//                     style: TextStyle(fontSize: 14.sp),
//                   ),
//                   SizedBox(height: 40.h),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50.h,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context, MaterialPageRoute(builder: (context) => const thirdscreen()));
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFF06C92),
//                       ),
//                       child: Text(
//                         'Get OTP',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 25.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   Text(
//                     'By proceeding I accept all the ',
//                     style: TextStyle(fontSize: 10.sp),
//                   ),
//                   Text(
//                     'The User policy and terms and Conditions',
//                     style: TextStyle(fontSize: 10.sp),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:himate/auth/viewmodels/auth_viewmodel.dart';
import 'package:himate/auth/screen/home.dart';
import 'package:provider/provider.dart';

class Numberverification extends StatefulWidget {
  const Numberverification({super.key});

  @override
  State<Numberverification> createState() => _NumberverificationState();
}

class _NumberverificationState extends State<Numberverification> {
  final TextEditingController mobileController = TextEditingController();

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFE6F8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.h, left: 20.w),
              child: Image.asset("Asset/image/logo.png",
                  height: 70.h, width: 130.w),
            ),
            Image.asset("Asset/image/Verification.png", height: 410.h),
            SizedBox(height: 70.h),
            Container(
              padding: EdgeInsets.all(20.w),
              height: 350.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFEEB2DC),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mobile Number", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(height: 15.h),

                  // PHONE FIELD
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Text("+91",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: TextField(
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter mobile number",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),
                  Text("We Keep Your Number Confidential",
                      style: TextStyle(fontSize: 14.sp)),
                  SizedBox(height: 40.h),

                  // GET OTP BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: auth.loading
                          ? null
                          : () async {
                              final mobile = mobileController.text.trim();

                              if (mobile.length != 10) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Enter valid mobile number")),
                                );
                                return;
                              }

                              bool success = await auth.sendOtp(mobile);

                              if (success) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ThirdScreen(mobile: mobile),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(auth.error ??
                                          "Something went wrong")),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF06C92),
                      ),
                      child: auth.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Get OTP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 10.h),
                  Text("By proceeding I accept all the ",
                      style: TextStyle(fontSize: 10.sp)),
                  Text("User policy and Terms & Conditions",
                      style: TextStyle(fontSize: 10.sp)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
