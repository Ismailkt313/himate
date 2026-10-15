
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:himate/containor.dart';
import 'package:himate/profile/screen/profile.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguagesState();
}

class _LanguagesState extends State<Language> {
  String? selectedLanguage; // To track the selected language

  void _onLanguageSelected(String language) {
    setState(() {
      selectedLanguage = language; // Update selected language
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLanguageRow(['English', 'हिन्दी', 'తెలుగు']),
              SizedBox(height: 10.h),
              _buildLanguageRow(['বাংলা', 'मराठी', 'മലയാളം']),
              SizedBox(height: 10.h),
              _buildLanguageRow(['ગુજરાતી', 'অসমীয়া', 'ಕನ್ನಡ']),
              SizedBox(height: 10.h),
              _buildLanguageRow(['नेपाली', 'தமிழ்', 'भोजपुरी']),
              SizedBox(height: 10.h),
              _buildLanguageRow(['اردو', 'हरयाणवी', 'राजस्थानी']),
              SizedBox(height: 10.h),
              _buildLanguageRow(['ਪੰਜਾਬੀ', 'ଓରିୟା', 'தமிழ்']),
              const SizedBox(height: 10,),
              Row(
               mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50.h,
                    width: 130.w,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Cancel', style: TextStyle(fontSize: 16.sp)),
                    ),
                  ),
                 
                  SizedBox(
                    width: 130.w,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Profilescreen()),
                        );
                      },
                      child: Text('Save', style: TextStyle(fontSize: 16.sp)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageRow(List<String> languages) {
    return Row(
      children: languages.map((lang) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: LanguageWidget(
            text: lang,
            isSelected: selectedLanguage == lang,
            onSelect: () => _onLanguageSelected(lang),
          ),
        );
      }).toList(),
    );
  }
}

