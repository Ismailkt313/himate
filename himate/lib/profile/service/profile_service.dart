import 'dart:developer';

import 'package:himate/auth/service/api_service.dart';
import 'package:himate/utils/storage.dart';


class ProfileService {
  final ApiService _api = ApiService();

  /// Fetch Logged-In User Profile
  Future<Map<String, dynamic>> getProfile() async {
    log("📌 getProfile() called");

    try {
      final accessToken = await Storage.getAccessToken();
      log("🔐 Using Access Token: $accessToken");

      if (accessToken == null) {
        log("❌ No access token found → user must login again");
        return {"success": false, "message": "Unauthorized - No token found"};
      }

      /// API CALL
      final res = await _api.get(
        '/profile',
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      log("📥 Profile Response: ${res.data}");

      return res.data;

    } catch (e) {
      log("❌ getProfile() Error: $e");

      return {"success": false, "message": e.toString()};
    }
  }
}
