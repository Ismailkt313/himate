// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// import 'package:himate/languages.dart';
// import 'package:himate/viewmodels/auth_viewmodel.dart';

// class ThirdScreen extends StatefulWidget {
//   final String mobile;

//   const ThirdScreen({super.key, required this.mobile});

//   @override
//   State<ThirdScreen> createState() => _ThirdScreenState();
// }

// class _ThirdScreenState extends State<ThirdScreen> {
//   String otp = "";

//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthViewModel>(context);

//     return Scaffold(
//       backgroundColor: const Color(0xFFFFE6F8),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(right: 200.w, top: 30.h),
//             child: Image.asset(
//               "Asset/image/logo.png",
//               height: 50.h,
//               width: 80.w,
//               fit: BoxFit.contain,
//             ),
//           ),
//           SizedBox(height: 10.h),
//           Image.asset(
//             "Asset/image/otp.png",
//             height: 420.h,
//             width: 300.w,
//             fit: BoxFit.contain,
//           ),
//           SizedBox(height: 20.h),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 10.w),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEEB2DC),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10.r),
//                   topRight: Radius.circular(10.r),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header
//                   Padding(
//                     padding: EdgeInsets.all(10.w),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Auto detecting OTP',
//                           style: TextStyle(fontSize: 16.sp),
//                         ),

//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: Text(
//                             'Change no',
//                             style: TextStyle(fontSize: 18.sp, color: Colors.purple),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: 20.h),

//                   // OTP Input Box
//                   PinCodeTextField(
//                     appContext: context,
//                     length: 5,
//                     obscureText: false,
//                     animationType: AnimationType.fade,
//                     pinTheme: PinTheme(
//                       shape: PinCodeFieldShape.box,
//                       borderRadius: BorderRadius.circular(5.r),
//                       fieldHeight: 56.h,
//                       fieldWidth: 56.w,
//                       activeFillColor: Colors.white,
//                       inactiveFillColor: Colors.white,
//                       selectedFillColor: Colors.white,
//                       activeColor: Colors.blue,
//                       inactiveColor: Colors.white,
//                       selectedColor: Colors.blueAccent,
//                     ),
//                     animationDuration: const Duration(milliseconds: 300),
//                     backgroundColor: Colors.transparent,
//                     enableActiveFill: true,
//                     onChanged: (value) {
//                       otp = value;
//                     },
//                     onCompleted: (value) {
//                       otp = value;
//                     },
//                   ),

//                   SizedBox(height: 10.h),

//                   // Submit button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 55.h,
//                     child: ElevatedButton(
//                       onPressed: auth.loading
//                           ? null
//                           : () async {
//                               if (otp.length != 5) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text("Enter full OTP")),
//                                 );
//                                 return;
//                               }

//                               bool ok = await auth.verifyOtp(widget.mobile, otp);

//                               if (ok) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const Language(),
//                                   ),
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text(auth.error ?? "OTP failed")),
//                                 );
//                               }
//                             },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFF06C92),
//                       ),
//                       child: auth.loading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : Text(
//                         'Done',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18.sp,
//                         ),
//                       ),
//                     ),
//                   ),

//                   SizedBox(height: 10.h),

//                   // Resend OTP
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Didn’t receive the OTP ?',
//                         style: TextStyle(fontSize: 16.sp, color: Colors.black),
//                       ),
//                       TextButton(
//                         onPressed: auth.loading
//                             ? null
//                             : () async {
//                                 await auth.sendOtp(widget.mobile);
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text("OTP Resent")),
//                                 );
//                               },
//                         child: Text(
//                           'Resend OTP',
//                           style:
//                               TextStyle(fontSize: 16.sp, color: Colors.black87),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:himate/languages.dart';
import 'package:himate/auth/viewmodels/auth_viewmodel.dart';

class ThirdScreen extends StatefulWidget {
  final String mobile;

  const ThirdScreen({super.key, required this.mobile});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFE6F8),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 200.w, top: 30.h),
            child: Image.asset(
              "Asset/image/logo.png",
              height: 50.h,
              width: 80.w,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 10.h),
          Image.asset(
            "Asset/image/otp.png",
            height: 420.h,
            width: 300.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20.h),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEEB2DC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Auto detecting OTP', style: TextStyle(fontSize: 16.sp)),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Change no',
                            style: TextStyle(fontSize: 18.sp, color: Colors.purple),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // OTP INPUT
                  PinCodeTextField(
                    appContext: context,
                    length: 5,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5.r),
                      fieldHeight: 56.h,
                      fieldWidth: 56.w,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeColor: Colors.blue,
                      inactiveColor: Colors.white,
                      selectedColor: Colors.blueAccent,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,

                    onChanged: (value) {
                      otp = value;
                      print("[log] 🔄 OTP typing: $otp");
                    },

                    onCompleted: (value) {
                      otp = value;
                      print("[log] 🔐 OTP Completed: $otp");
                    },
                  ),

                  SizedBox(height: 15.h),

                  // SUBMIT BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      onPressed: auth.loading
                          ? null
                          : () async {
                              print("[log] ▶️ Verify Button Pressed");
                              print("[log] 📱 Mobile: ${widget.mobile}");
                              print("[log] 🔢 Entered OTP: $otp");

                              if (otp.length != 5) {
                                print("[log] ❌ OTP incomplete");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Enter full OTP")),
                                );
                                return;
                              }

                              bool ok = await auth.verifyOtp(widget.mobile, otp);

                              if (ok) {
                                print("[log] 🎉 OTP Verified Successfully → Navigate");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Language()),
                                );
                              } else {
                                print("[log] ❌ OTP Verify Failed: ${auth.error}");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(auth.error ?? "OTP failed")),
                                );
                              }
                            },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF06C92),
                      ),
                      child: auth.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text('Done',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                              )),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // RESEND OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Didn’t receive the OTP ?',
                          style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                      
                      TextButton(
                        onPressed: auth.loading
                            ? null
                            : () async {
                                print("[log] 🔁 Resend OTP Pressed for: ${widget.mobile}");
                                await auth.sendOtp(widget.mobile);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(content: Text("OTP Resent")));
                              },
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
