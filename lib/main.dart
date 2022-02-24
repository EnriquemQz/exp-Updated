import 'package:exp_app/pages/add_expenses.dart';
import 'package:exp_app/pages/categories_details.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';

import 'package:exp_app/pages/home_page.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UIProvider()),
      ChangeNotifierProvider(create: (_) => ExpensesProvider()),
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es')
      ],
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
        colorScheme: const ColorScheme.dark(
          primary: Colors.green
        ),
        dividerColor: Colors.grey,
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColorDark: Colors.grey[850],
      ),
      initialRoute: 'home',
      routes: {
        'home' : (_) => const HomePage(),
        'add_expenses' : (_) => const AddExpenses(),
        'cat_details' : (_) => const CategoriesDetails(),
      },
    );
  }
}