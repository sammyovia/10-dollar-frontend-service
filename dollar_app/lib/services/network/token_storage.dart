import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';
  static const _userId = 'userId';
  static const _userOnboarded = "userOnboarded";
  static const _userRegistered = "userRegistered";
  static const _userEmail = "userEmail";
  static const _userEmailVerified = "emailVerified";
  static const _userProfileVerified = "userProfile";
  static const _userLoggedIn = 'userLoggedIn';

  Future<void> saveTokens(
      {required String accessToken, required String refreshToken}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userId, userId);
  }

  Future<void> saveUserLoggedIN(bool login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userLoggedIn, login);
  }

  Future<void> userProfileVerified(bool verified) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userProfileVerified, verified);
  }
  Future<void> userEmailVerified(bool emailVerified) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userEmailVerified, emailVerified);
  }

  Future<void> saveUserOnboarded(bool onboarded) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userOnboarded, onboarded);
  }

  Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmail, email);
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmail);
  }

  Future<bool?> getEmailVerified() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userEmailVerified);
  }

  Future<bool?> userLoggedIN() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userLoggedIn);
  }
  Future<bool?> getUserProfileVerified() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userProfileVerified);
  }

  Future<void> saveUserRegistered(bool onboarded) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userRegistered, onboarded);
  }

  Future<bool?> getUserOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userOnboarded);
  }

  Future<bool?> getUserRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userRegistered);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userId);
  }

  Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userId);
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}
