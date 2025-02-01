import 'package:flutter/material.dart';
import 'package:flutter_app/screens/place_detail.dart';
import '../components/build_destination_card.dart';

class HomeScreen extends StatefulWidget {
  final Function(Map<String, String>) toggleFavorite;
  final List<Map<String, String>> favorites;

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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeBanner(theme),
              const SizedBox(height: 26),
              _buildSectionTitle(theme, "Popular Places"),
              _buildDestinationList(),
              const SizedBox(height: 30),
              _buildSectionTitle(theme, "Explore"),
              _buildDestinationList(),
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
          borderRadius: BorderRadius.circular(16),
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
          return DestinationCard(
            title: destinations[index]['title']!,
            imagePath: destinations[index]['image']!,
            isFavorite: widget.favorites.any((fav) =>
                fav['title'] == destinations[index]['title'] &&
                fav['image'] == destinations[index]['image']),
            toggleFavorite: widget.toggleFavorite,
          );
        },
      ),
    );
  }
}
