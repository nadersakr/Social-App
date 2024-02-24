import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static SharedPreferences? sharedPreference;

  static Future<void> initSharedPreferences() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static Future<bool> setbool(
      {required String key, required bool value}) async {
    return await sharedPreference!.setBool(key, value);
  }

  static bool? getValue({required String value}) {
    return sharedPreference?.getBool(value);
  }

  // static Future<bool> setDate(
  //     {required String key, required String value}) async {
  //   return await sharedPreference!.setString(key, value);
  // }
}
