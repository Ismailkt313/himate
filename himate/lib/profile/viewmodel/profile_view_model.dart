import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:himate/profile/service/profile_service.dart';


class ProfileViewModel with ChangeNotifier {
  final ProfileService _service = ProfileService();

  bool loading = false;
  Map<String, dynamic>? profileData;

  Future<void> fetchProfile() async {
    loading = true;
    notifyListeners();

    final res = await _service.getProfile();
    log("👤 ProfileViewModel Data: $res");

    if (res["success"] == true) {
      profileData = res;
    }

    loading = false;
    notifyListeners();
  }
}
