import 'package:flutter/material.dart';
import '../screens/place_detail.dart';

class GalleryScreen extends StatefulWidget {
  final Function(Map<String, String>)
      toggleFavorite; // Function to toggle favorite status
  final List<Map<String, String>> favorites; // List of favorite items

  const GalleryScreen({
    Key? key,
    required this.toggleFavorite,
    required this.favorites,
  }) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<Map<String, String>> images = [
    {'title': 'Tokyo', 'image': 'assets/images/tokyo.jpg'},
    {'title': 'Thailand', 'image': 'assets/images/thailand.jpg'},
    {'title': 'Africa', 'image': 'assets/images/africa.jpg'},
    {'title': 'France', 'image': 'assets/images/france.jpg'},
    {'title': 'India', 'image': 'assets/images/india.jpg'},
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
      appBar: AppBar(
        title: Text(
          "Gallery",
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black, // Set text color based on theme
          ),
        ),
        backgroundColor:
            theme.scaffoldBackgroundColor, // Set AppBar background color
        elevation: 0,
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: images.isEmpty
            ? const Center(
                child: Text(
                  "No images to display",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return _buildGalleryCard(
                    theme,
                    images[index]['title']!,
                    images[index]['image']!,
                  );
                },
              ),
      ),
    );
  }

  Widget _buildGalleryCard(ThemeData theme, String title, String imagePath) {
    final image = {'title': title, 'image': imagePath};
    final isFavorite = widget.favorites.any((fav) =>
        fav['title'] == image['title'] && fav['image'] == image['image']);

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
        ).then((_) {
          setState(() {}); // Refresh HomeScreen when returning
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, size: 50, color: Colors.red),
                ),
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
                  setState(
                    () {
                      widget.toggleFavorite(image);
                    },
                  );
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
