import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? _selectedTheme;

  ThemeData dark = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900]
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.green,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[800],
      foregroundColor: Colors.white
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.green
    ),
    dividerColor: Colors.grey,
    scaffoldBackgroundColor: Colors.grey[900],
    primaryColorDark: Colors.grey[850],
  );

  ThemeData light = ThemeData.light().copyWith(
    primaryTextTheme: Typography.material2018()
      .black.merge(Typography.englishLike2018),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[200],
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[300],
      selectedItemColor: Colors.green
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[300]
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[800],
      foregroundColor: Colors.white
    ),
    scaffoldBackgroundColor: Colors.grey[200],
    primaryColorDark: Colors.grey[300],
    dividerColor: Colors.black
  );

  ThemeProvider(bool isDark){
    _selectedTheme = (isDark) ? dark : light;
  }

  Future<void> swapTheme() async {
    if(_selectedTheme == dark){
      _selectedTheme = light;
    } else {
      _selectedTheme = dark;
    }
    notifyListeners();
  }

  ThemeData? getTheme() => _selectedTheme;
}