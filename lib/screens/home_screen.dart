import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Map<String, String>> destinations = [
      {'title': 'Tokyo', 'image': 'assets/images/tokyo.jpg'},
      {'title': 'Thailand', 'image': 'assets/images/thailand.jpg'},
      {'title': 'Africa', 'image': 'assets/images/africa.jpg'},
      {'title': 'France', 'image': 'assets/images/france.jpg'},
      {'title': 'India', 'image': 'assets/images/india.jpg'},
    ];

    return Padding(
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
    );
  }

  Widget _buildDestinationCard(
      ThemeData theme, String title, String imagePath) {
    final destination = {'title': title, 'image': imagePath};
    final isFavorite = widget.favorites.any((fav) =>
        fav['title'] == destination['title'] &&
        fav['image'] == destination['image']);

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
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    widget.toggleFavorite(destination);
                  });
                },
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
