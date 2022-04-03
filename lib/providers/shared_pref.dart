
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static const darkmode = 'DarkMode';
  static const nothour = 'notif_hour';
  static const notminute = 'notif_minute';

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

  int get hour {
    return _prefs!.getInt(nothour) ?? 99;   
  }
  set hour(int value) {
    _prefs!.setInt(nothour, value);
  }

  int get minute {
    return _prefs!.getInt(notminute) ?? 99;
  }
  set minute(int value) {
    _prefs!.setInt(notminute, value);
  }

  deleteTime(){
    _prefs!.remove(nothour);
    _prefs!.remove(notminute);
  }
}