import 'package:flutter/material.dart';
import 'package:flutter_app/screens/place_detail.dart';

class HomeScreen extends StatefulWidget {
  final Function(Map<String, String>)
      toggleFavorite; // Function to toggle favorite status
  final List<Map<String, String>> favorites; // List of favorite items

  const HomeScreen({
    Key? key,
    required this.toggleFavorite,
    required this.favorites,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> destinations = [
    {'title': 'Tokyo', 'image': 'assets/images/tokyo.jpg'},
    {'title': 'Thailand', 'image': 'assets/images/thailand.jpg'},
    {'title': 'Africa', 'image': 'assets/images/africa.jpg'},
    {'title': 'France', 'image': 'assets/images/france.jpg'},
    {'title': 'India', 'image': 'assets/images/india.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme
    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor, // Set background color based on theme
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeBanner(theme), // Build the welcome banner
              const SizedBox(height: 26),
              _buildSectionTitle(
                  theme, "Popular Places"), // Build the section title
              _buildDestinationList(), // Build the destination list
              const SizedBox(height: 30),
              _buildSectionTitle(
                  theme, "Explore"), // Build another section title
              _buildDestinationList(), // Build another destination list
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner(ThemeData theme) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16), // Set border radius
          child: Image.asset(
            'assets/images/france.jpg',
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            "Welcome to TravelApp",
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.7),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildDestinationList() {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          return _buildDestinationCard(
            destinations[index]['title']!,
            destinations[index]['image']!,
          );
        },
      ),
    );
  }

  Widget _buildDestinationCard(String title, String imagePath) {
    final isFavorite = widget.favorites.any((fav) => fav['title'] == title);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetailScreen(
              title: title,
              imagePath: imagePath,
              toggleFavorite: widget.toggleFavorite,
              favorites: widget.favorites,
            ),
          ),
        ).then((_) => setState(() {})); // Refresh HomeScreen when returning
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 5,
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
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      widget
                          .toggleFavorite({'title': title, 'image': imagePath});
                    });
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
