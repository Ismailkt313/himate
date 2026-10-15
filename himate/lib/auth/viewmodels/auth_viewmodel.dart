import 'package:flutter/material.dart';
import 'package:himate/auth/service/auth_service.dart';
import 'package:himate/models/usermodel.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _auth = AuthService();

  bool loading = false;
  String? error;
  User? user;

  // -------------------------------
  // SEND OTP
  // -------------------------------
  Future<bool> sendOtp(String mobile) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final res = await _auth.sendOtp(mobile);

      loading = false;
      notifyListeners();
      return res['success'] == true;

    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // -------------------------------
  // VERIFY OTP
  // -------------------------------
  Future<bool> verifyOtp(String mobile, String otp) async {
    loading = true;
    error = null;
    notifyListeners();
    
    try {
      final res = await _auth.verifyOtp(mobile, otp);

      loading = false;

      if (res['success'] == true) {
        if (res['user'] != null) {
          user = User.fromJson(res['user']);
        }
        notifyListeners();
        return true;
      }

      error = res['message']?.toString();
      notifyListeners();
      return false;

    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // -------------------------------
  // LOGOUT
  // -------------------------------
  Future<void> logout() async {
    await _auth.logout();
    user = null;
    notifyListeners();
  }
}
