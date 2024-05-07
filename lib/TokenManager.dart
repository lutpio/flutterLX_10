import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class TokenManager {
  static Future<String> generateToken(String name) async {
    String token = Uuid().v4();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
    await prefs.setString('user_name', name); // Menyimpan nama
    return token;
  }

  static Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token'); // Menghapus token
    await prefs.remove('user_name'); // Menghapus token
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getString('user_token'); // Mengambil token
    return prefs.getString('user_name'); // Mengambil token
  }

  static Future<bool> getTokenAvailability() async {
    String? token = await getToken();
    return token != null;
  }
}
