import 'package:flutter/material.dart';

// Define the SettingsScreen as a StatelessWidget since it doesn't need to change state
class SettingsScreen extends StatelessWidget {
  final Function toggleTheme; // Function to toggle the theme (dark/light)
  final bool isDarkMode; // Current theme state (dark/light)

  const SettingsScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"), // Title in English
        centerTitle: true, // Center the title
        backgroundColor: theme
            .appBarTheme.backgroundColor, // AppBar color based on the theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dark mode toggle switch
            SwitchListTile(
              title: const Text("Dark Mode"), // Title text in English
              value: isDarkMode, // Switch value based on the theme state
              onChanged: (bool value) {
                toggleTheme(); // Call the toggleTheme function when the switch is changed
              },
            ),
            const Divider(), // Divider between items
            // Language change item
            ListTile(
              title: const Text("Language"), // Title text in English
              subtitle: const Text("English"), // Subtitle text in English
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
