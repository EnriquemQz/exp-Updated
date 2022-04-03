import 'package:exp_app/widgets/setting_page_wt/dart_mode_switch.dart';
import 'package:exp_app/widgets/setting_page_wt/time_picker.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: const [
          DarkModeSwitch(),
          Divider(thickness: 2),
          TimePicker(),
          Divider(thickness: 2)
        ],
      ),
    );
  }
}