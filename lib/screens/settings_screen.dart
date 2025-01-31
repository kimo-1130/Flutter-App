import 'package:flutter/material.dart'; // لاستيراد مكتبة واجهات المستخدم

// تعريف واجهة الإعدادات كـ StatelessWidget لأنها لا تحتاج إلى تغيير الحالة
class SettingsScreen extends StatelessWidget {
  final Function toggleTheme; // دالة لتبديل الثيم (ليلي/نهاري)
  final Function changeLanguage; // دالة لتغيير اللغة
  final bool isDarkMode; // حالة الثيم (ليلي/نهاري)
  final String currentLanguage; // اللغة الحالية

  const SettingsScreen({
    super.key,
    required this.toggleTheme,
    required this.changeLanguage,
    required this.isDarkMode,
    required this.currentLanguage,
  });

  @override
  Widget build(BuildContext context) {
    // التحقق من حالة الثيم (ليلي/نهاري)
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentLanguage == "ar"
            ? "إعدادات البرنامج"
            : "Settings"), // عنوان الواجهة بناءً على اللغة
        centerTitle: true, // محاذاة العنوان في المنتصف
        backgroundColor: isDarkMode
            ? Colors.black
            : Colors.orange, // لون الشريط العلوي بناءً على حالة الثيم
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // مسافات داخلية حول المحتوى
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنصر تبديل الوضع الليلي
            SwitchListTile(
              title: Text(currentLanguage == "ar"
                  ? "الوضع الليلي"
                  : "Dark Mode"), // نص العنوان بناءً على اللغة
              value: isDarkMode, // قيمة التبديل بناءً على حالة الثيم
              onChanged: (bool value) {
                toggleTheme(); // استدعاء دالة تبديل الثيم عند تغيير التبديل
              },
            ),
            const Divider(), // فاصل بين العناصر
            // عنصر تغيير اللغة
            ListTile(
              title: Text(currentLanguage == "ar"
                  ? "اللغة"
                  : "Language"), // نص العنوان بناءً على اللغة
              subtitle: Text(currentLanguage == "ar"
                  ? "العربية"
                  : "English"), // النص الفرعي بناءً على اللغة
              onTap: () {
                changeLanguage(currentLanguage == "ar"
                    ? "en"
                    : "ar"); // استدعاء دالة تغيير اللغة عند الضغط على العنصر
              },
            ),
            const Divider(), // فاصل بين العناصر
            // عنصر إعدادات الحساب
            ListTile(
              title: Text(currentLanguage == "ar"
                  ? "إعدادات الحساب"
                  : "Account Settings"), // نص العنوان بناءً على اللغة
              onTap: () {
                Navigator.pushNamed(context, '/accountSettings'); // الانتقال إلى واجهة إعدادات الحساب
              },
            ),
          ],
        ),
      ),
    );
  }
}
