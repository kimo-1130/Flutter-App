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
  runApp(const MyApp()); // Entry point of the app
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false; // State to track dark mode
  int _selectedIndex = 0; // State to track selected bottom navigation index
  final List<Map<String, String>> favorites =
      []; // List to store favorite items

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode; // Toggle dark mode state
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
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
            color: Colors.blue,
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
      GalleryScreen(toggleFavorite: _toggleFavorite, favorites: favorites),
      FavoritesScreen(favorites: favorites, toggleFavorite: _toggleFavorite),
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
                      leading: const Icon(Icons.logout, color: Colors.blue),
                      title: Text(
                        "Log out",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (Route<dynamic> route) => false,
                        );
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
        '/gallery': (context) => GalleryScreen(
              toggleFavorite: _toggleFavorite,
              favorites: favorites,
            ),
        '/notifications': (context) => const NotificationScreen(),
        '/settings': (context) => SettingsScreen(
              toggleTheme: toggleTheme,
              isDarkMode: isDarkMode,
            ),
      },
    );
  }
}
