import 'package:flutter/material.dart';
import 'package:flutter_app/screens/place_detail.dart';

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

Widget _buildCategoryCard(ThemeData theme, String title, String imagePath) {
  return Container(
    width: 150,
    margin: const EdgeInsets.only(right: 12),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: theme.primaryColor.withOpacity(0.05),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/thailand.jpg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
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
            ),
            const SizedBox(height: 26),
            // Categories

            // Popular places
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Popular places",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
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
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Explore",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
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
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationCard(
      ThemeData theme, String title, String imagePath) {
    final destination = {'title': title, 'image': imagePath};
    final isFavorite = widget.favorites.any((fav) =>
        fav['title'] == destination['title'] &&
        fav['image'] == destination['image']);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetailScreen(
              title: title,
              imagePath: imagePath,
              toggleFavorite:
                  widget.toggleFavorite, // Pass the toggleFavorite function
              favorites: widget.favorites, // Pass the favorites list
            ),
          ),
        ).then((_) {
          setState(() {}); // Refresh HomeScreen when returning
        });
        ;
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent
                      ],
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
      ),
    );
  }
}
