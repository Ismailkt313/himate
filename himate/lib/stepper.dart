import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:himate/processingani.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class Stepperkyc extends StatefulWidget {
  const Stepperkyc({super.key});

  @override
  State<Stepperkyc> createState() => _StepperkycState();
}

class _StepperkycState extends State<Stepperkyc> {
  int currentStep = 0;
  XFile? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  void continueStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep += 1;
      });
    } else {
      // Navigate to another page when on the last step
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Processingani(),
        ),
      );
    }
  }

  void cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  void onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlsBuilder(context, details) {
    return Padding(
      padding: EdgeInsets.only(top: 60.h, left: 50.w),
      child: Row(
        children: [
          SizedBox(
            height: 36.h,
            width: 140.w,
            child: ElevatedButton(
              onPressed: details.onStepContinue,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.pink),
              ),
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          SizedBox(
            height: 36.h,
            width: 140.w,
            child: OutlinedButton(
              onPressed: details.onStepCancel,
              child: const Text("Cancel"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50.h),
          Padding(
            padding: EdgeInsets.only(right: 200.w),
            child: Text(
              'KYC Verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.sp,
              ),
            ),
          ),
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              elevation: 0,
              currentStep: currentStep,
              onStepContinue: continueStep,
              onStepCancel: cancelStep,
              onStepTapped: onStepTapped,
              controlsBuilder: controlsBuilder,
              steps: [
                Step(
                  title: const Text(''),
                  content: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.h, right: 100.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Please provide your accurate information',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          children: [
                            SizedBox(height: 40.h),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Register name',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 12.h),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _buildTextField('Home address'),
                      SizedBox(height: 15.h),
                      _buildTextField('Phone number'),
                      SizedBox(height: 15.h),
                      _buildTextField('Email ID'),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Text(
                            'Bank Details',
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      _buildTextField('Registered Name'),
                      SizedBox(height: 15.h),
                      _buildTextField('IFSC Code'),
                      SizedBox(height: 15.h),
                      _buildTextField('Account No'),
                    ],
                  ),
                  isActive: currentStep >= 0,
                  state: currentStep >= 0 ? StepState.complete : StepState.disabled,
                ),
                Step(
                  title: const Text(''),
                  content: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 280.w),
                        child: Text(
                          'ID Verification',
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(right: 50.w),
                        child: const Text('Select a document type below to confirm your identity'),
                      ),
                      SizedBox(height: 50.h),
                      _buildVerificationOption('National ID Card'),
                      _buildDivider(),
                      _buildVerificationOption('Aadhar Card'),
                      _buildDivider(),
                      _buildVerificationOption('Driving License'),
                    ],
                  ),
                  isActive: currentStep >= 1,
                  state: currentStep >= 1 ? StepState.complete : StepState.disabled,
                ),
                Step(
                  title: const Text(''),
                  content: Column(
                    children: [
                      Text(
                        'Verification Step 3',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16.h),
                      _buildImageUploadContainer(),
                      SizedBox(height: 15.h),
                      _buildImageUploadContainer(),
                    ],
                  ),
                  isActive: currentStep >= 2,
                  state: currentStep >= 2 ? StepState.complete : StepState.disabled,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationOption(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 16.sp)),
          Icon(Icons.arrow_forward_ios_outlined, size: 16.sp),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 2.h, color: Colors.black12, thickness: 1);
  }

  Widget _buildImageUploadContainer() {
    return GestureDetector(
      onTap: pickImage,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12.r),
        dashPattern: const [6, 3],
        color: Colors.blue,
        strokeWidth: 2.w,
        child: Container(
          height: 150.h,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            'Tap to Select Image',
            style: TextStyle(color: Colors.grey, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}
