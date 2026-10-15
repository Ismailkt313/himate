import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onSelect;

  const LanguageWidget({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect, // Call the parent function to update selection
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 130.w,
        height: 130.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF640472) : const Color(0xFFFFE6F8), // Highlight if selected
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF640472).withValues(alpha: 0.5),
                    blurRadius: 10.r,
                    spreadRadius: 2.r,
                  )
                ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF640472), // Change text color when selected
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
