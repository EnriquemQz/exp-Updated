import 'package:exp_app/providers/shared_pref.dart';
import 'package:exp_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({Key? key}) : super(key: key);

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool _darkMode = false;
  final prefs = UserPrefs();

  @override
  void initState() {
    super.initState();
    _darkMode = prefs.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _darkMode, 
      title: const Text(
        'Modo Oscuro',
        style: TextStyle(
          fontSize: 14.0
        ),
      ),
      subtitle: const Text(
        'El modo oscuro ayuda ahorrar batería'
      ),
      onChanged: (value){
        setState(() {
          _darkMode = value;
          prefs.darkMode = value;
          context.read<ThemeProvider>().swapTheme();
        });
      }
    );
  }
}