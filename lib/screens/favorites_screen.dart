import 'package:flutter/material.dart';
import 'package:flutter_app/screens/place_detail.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Map<String, String>> favorites; // List of favorite items
  final Function(Map<String, String>)
      toggleFavorite; // Function to toggle favorite status

  const FavoritesScreen({
    Key? key,
    required this.favorites,
    required this.toggleFavorite,
  }) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
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
        child: widget.favorites.isEmpty
            ? Center(
                child: Text(
                  "No favorites yet!",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
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
                itemCount: widget.favorites.length,
                itemBuilder: (context, index) {
                  return _buildFavoriteCard(
                    context,
                    theme,
                    widget.favorites[index]['title']!,
                    widget.favorites[index]['image']!,
                  );
                },
              ),
      ),
    );
  }

  Widget _buildFavoriteCard(
      BuildContext context, ThemeData theme, String title, String imagePath) {
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
      },
      child: Container(
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
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
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
