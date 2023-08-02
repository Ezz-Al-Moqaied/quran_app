import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setPageNumber(int pageNumber) async {
    print(pageNumber);
    return await sharedPreferences.setInt('pageNumber', pageNumber);
  }

  static int get getPageNumber {
    print(sharedPreferences.getInt('pageNumber') ?? 0);
    return sharedPreferences.getInt('pageNumber') ?? 0;
  }
}
