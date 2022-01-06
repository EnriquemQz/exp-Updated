import 'package:exp_app/pages/home_page.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UIProvider())
    ],
    child: const MyApp()
  )
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.dark().copyWith(
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
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColorDark: Colors.grey[850],
      ),
      initialRoute: 'home',
      routes: {
        'home' :       (_) => const HomePage(),
      },
    );
  }
}