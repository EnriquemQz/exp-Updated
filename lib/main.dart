import 'package:exp_app/providers/local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:exp_app/pages/add_expenses.dart';
import 'package:exp_app/pages/categories_details.dart';
import 'package:exp_app/pages/expenses_details.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/shared_pref.dart';
import 'package:exp_app/providers/theme_provider.dart';
import 'package:exp_app/pages/home_page.dart';
import 'package:exp_app/providers/ui_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  tz.initializeTimeZones();
  final prefs = UserPrefs();
  final notifs = LocalNotifications();

  await prefs.initPrefs();
  await notifs.initialize();

  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UIProvider()),
      ChangeNotifierProvider(create: (_) => ExpensesProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider(prefs.darkMode)),
    ],
    child: const MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Material App',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('es')
          ],
          theme: value.getTheme(),
          initialRoute: 'home',
          routes: {
            'home' : (_) => const HomePage(),
            'add_expenses' : (_) => const AddExpenses(),
            'exp_details' : (_) => const ExpensesDetails(),
            'cat_details' : (_) => const CategoriesDetails(),
          },
        );
      }
    );
  }
}