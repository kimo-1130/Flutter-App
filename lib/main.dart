import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/favorites_screen.dart';

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
  int _selectedIndex = 0;
  final List<Map<String, String>> favorites = [];

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Map<String, String> destination) {
    setState(() {
      if (favorites
          .any((favorite) => favorite['title'] == destination['title'])) {
        favorites.removeWhere(
            (favorite) => favorite['title'] == destination['title']);
      } else {
        favorites.add(destination);
      }
    });
  }

  ThemeData getTheme() {
    if (isDarkMode) {
      return ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
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
        primaryColor: Colors.blue,
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
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey[600],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(toggleFavorite: _toggleFavorite, favorites: favorites),
      GalleryScreen(),
      FavoritesScreen(favorites: favorites),
      const NotificationScreen(),
    ];

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
        '/home': (context) => Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                    onPressed: toggleTheme,
                  ),
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text(
                        "Menu",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings, color: Colors.blue),
                      title: Text(
                        "Settings",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.blue),
                      title: Text(
                        "Account Settings",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/accountSettings');
                      },
                    ),
                  ],
                ),
              ),
              body: _screens[_selectedIndex],
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                color: Colors.blue,
                buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
                height: 60,
                items: const <Widget>[
                  Icon(Icons.home, size: 30, color: Colors.white),
                  Icon(Icons.image, size: 30, color: Colors.white),
                  Icon(Icons.favorite, size: 30, color: Colors.white),
                  Icon(Icons.notifications, size: 30, color: Colors.white),
                ],
                onTap: _onItemTapped,
                animationDuration: const Duration(milliseconds: 300),
                animationCurve: Curves.easeInOut,
              ),
            ),
        '/gallery': (context) => GalleryScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/settings': (context) => SettingsScreen(
              toggleTheme: toggleTheme,
              isDarkMode: isDarkMode,
            ),
      },
    );
  }
}
