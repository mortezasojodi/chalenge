import 'package:shared_preferences/shared_preferences.dart';

localStorageSet(String key, String value) async {
  // ignore: invalid_use_of_visible_for_testing_member
  // SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString(key, value);
}

Future<String?> localStorageGet(String key) async {
  // ignore: invalid_use_of_visible_for_testing_member
  // SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString(key);
}

Future<bool> localStorageDel(String key) async {
  // ignore: invalid_use_of_visible_for_testing_member
  // SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove(key);
}
