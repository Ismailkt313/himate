import 'dart:developer';
import 'package:himate/auth/service/api_service.dart';
import '../../utils/storage.dart';

class AuthService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> sendOtp(String mobile) async {
    log("🚀 sendOtp() called with mobile: $mobile");

    try {
      final res = await _api.post('/auth/send-otp', data: {
        'mobileNumber': mobile,
      });

      log("✅ OTP Sent Response: ${res.data}");
      return res.data;

    } catch (e) {
      log("❌ sendOtp() Error: $e");
      return {"success": false, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String mobile, String otp) async {
    log("🚀 verifyOtp() called with mobile: $mobile, otp: $otp");

    try {
      final res = await _api.post('/auth/verify-otp', data: {
        'mobileNumber': mobile,
        'otp': otp,
      });

      log("📥 Server Response: ${res.data}");

      if (res.statusCode == 200) {
        final d = res.data;

        if (d['accessToken'] != null) {
          log("🔐 Saving access token...");
          await Storage.saveAccessToken(d['accessToken']);
        }

        if (d['refreshToken'] != null) {
          log("🔄 Saving refresh token...");
          await Storage.saveRefreshToken(d['refreshToken']);
        }
      }
      return res.data;

    } catch (e) {
      log("❌ verifyOtp() Error: $e");
      return {"success": false, "message": e.toString()};
    }
  }

  Future<bool> refreshAccessToken() async {
   log("🔁 refreshAccessToken() called");

    final refresh = await Storage.getRefreshToken();
    log("🔎 Found refresh token: $refresh");

    if (refresh == null) {
      log("⚠️ No refresh token found!");
      return false;
    }

    try {
      final res = await _api.post('/auth/refresh', data: {
        'refreshToken': refresh,
      });

      log("📥 Refresh Response: ${res.data}");

      if (res.statusCode == 200 && res.data['accessToken'] != null) {
        await Storage.saveAccessToken(res.data['accessToken']);
        log("✅ Access token refreshed successfully!");
        return true;
      }

    } catch (e) {
      log("❌ refreshAccessToken() Error: $e");
      return false;
    }

    log("⚠️ refreshAccessToken() failed");
    return false;
  }

  static Future<bool> tryRefresh() async {
    log("🔄 tryRefresh() called");
    final service = AuthService();
    return service.refreshAccessToken();
  }

  Future<void> logout() async {
    log("🚪 Logging out... deleting tokens");
    await Storage.deleteAllTokens();
  }
}
