import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  String currentLanguage = "ar";

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void changeLanguage(String language) {
    setState(() {
      currentLanguage = language;
    });
  }

  ThemeData getTheme() {
    if (isDarkMode) {
      return ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      );
    } else {
      return ThemeData.light().copyWith(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey[600],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(
              toggleTheme: toggleTheme,
              isDarkMode: isDarkMode,
            ),
        '/register': (context) => RegisterScreen(
              toggleTheme: toggleTheme,
              isDarkMode: isDarkMode,
            ),
        '/home': (context) => HomeScreen(
              toggleTheme: toggleTheme,
              isDarkMode: isDarkMode,
            ),
        '/gallery': (context) => GalleryScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/settings': (context) => SettingsScreen(
              toggleTheme: toggleTheme,
              changeLanguage: changeLanguage,
              isDarkMode: isDarkMode,
              currentLanguage: currentLanguage,
            ),
      },
    );
  }
}
