
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static const darkmode = 'DarkMode';
  static final UserPrefs _instance = UserPrefs._();

  factory UserPrefs(){
    return _instance;
  }

  UserPrefs._();
  SharedPreferences? _prefs; 

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get darkMode{
    return _prefs!.getBool(darkmode) ?? true;
  }
  set darkMode(bool value){
    _prefs!.setBool(darkmode, value);
  }
}