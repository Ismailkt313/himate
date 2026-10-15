import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';



class StepDottedBorderScreen extends StatefulWidget {
  const StepDottedBorderScreen({super.key});

  @override
  _StepDottedBorderScreenState createState() =>
      _StepDottedBorderScreenState();
}

class _StepDottedBorderScreenState extends State<StepDottedBorderScreen> {
  int currentStep = 0;
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steps with Dotted Border'),
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepTapped: (step) => setState(() {
          currentStep = step;
        }),
        onStepContinue: () {
          if (currentStep < 2) {
            setState(() {
              currentStep++;
            });
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep--;
            });
          }
        },
        steps: [
          Step(
            title: const Text('Step 1'),
            content: const Text('This is Step 1'),
            isActive: currentStep >= 0,
            state: currentStep >= 1
                ? StepState.complete
                : StepState.indexed,
          ),
          Step(
            title: const Text('Step 2'),
            content: const Text('This is Step 2'),
            isActive: currentStep >= 1,
            state: currentStep >= 2
                ? StepState.complete
                : StepState.indexed,
          ),
          Step(
            title: const Text(''),
            content: GestureDetector(
              onTap: _pickImage,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [8, 4],
                color: Colors.blue,
                strokeWidth: 2,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _selectedImage == null
                      ? const Center(
                          child: Text(
                            'Tap to select image',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            isActive: currentStep >= 2,
            state: currentStep >= 2
                ? StepState.complete
                : StepState.disabled,
          ),
        ],
      ),
    );
  }
}
