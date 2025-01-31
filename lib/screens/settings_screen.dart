import 'package:flutter/material.dart';

// Define the SettingsScreen as a StatelessWidget since it doesn't need to change state
class SettingsScreen extends StatelessWidget {
  final Function toggleTheme; // Function to toggle the theme (dark/light)
  final bool isDarkMode; // Current theme state (dark/light)
  final String currentLanguage = "ar"; // Current language

  const SettingsScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    // Check the current theme state (dark/light)
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentLanguage == "ar"
            ? "إعدادات البرنامج"
            : "Settings"), // Title based on the language
        centerTitle: true, // Center the title
        backgroundColor: isDarkMode
            ? Colors.black
            : Colors.orange, // AppBar color based on the theme state
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dark mode toggle switch
            SwitchListTile(
              title: Text(currentLanguage == "ar"
                  ? "الوضع الليلي"
                  : "Dark Mode"), // Title text based on the language
              value: isDarkMode, // Switch value based on the theme state
              onChanged: (bool value) {
                toggleTheme(); // Call the toggleTheme function when the switch is changed
              },
            ),
            const Divider(), // Divider between items
            // Language change item
            ListTile(
              title: Text(currentLanguage == "ar"
                  ? "اللغة"
                  : "Language"), // Title text based on the language
              subtitle: Text(currentLanguage == "ar"
                  ? "العربية"
                  : "English"), // Subtitle text based on the language
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
