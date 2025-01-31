import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    Key? key,
    required this.toggleTheme,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Map<String, String>> destinations = [
    {'title': 'Tokyo', 'image': 'assets/images/tokyo.jpg'},
    {'title': 'Thailand', 'image': 'assets/images/thailand.jpg'},
    {'title': 'Africa', 'image': 'assets/images/africa.jpg'},
    {'title': 'France', 'image': 'assets/images/france.jpg'},
    {'title': 'India', 'image': 'assets/images/india.jpg'},
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, '/gallery');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/notifications');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
              child: Text(
                "Menu",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: theme.colorScheme.primary),
              title: Text(
                "Settings",
                style: theme.textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: theme.colorScheme.primary),
              title: Text(
                "Account Settings",
                style: theme.textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/accountSettings');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Popular places",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  return _buildDestinationCard(
                    theme,
                    destinations[index]['title']!,
                    destinations[index]['image']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: theme.colorScheme.primary),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image, color: theme.colorScheme.primary),
            label: "Places",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: theme.colorScheme.primary),
            label: "Notifications",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.onSurface,
        backgroundColor: theme.scaffoldBackgroundColor,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDestinationCard(
      ThemeData theme, String title, String imagePath) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
