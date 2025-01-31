import 'dart:convert'; // لتحويل الاستجابة من JSON إلى Map
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchNotifications(); // استدعاء دالة جلب الإشعارات عند بدء الواجهة
  }

  // دالة لجلب الإشعارات من API وهمي
  Future<void> fetchNotifications() async {
    final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts'); // رابط API الوهمي

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          notifications = data.map((item) => item['title'].toString()).toList();
        });
      } else {
        // التعامل مع رمز الاستجابة غير الناجح
      }
    } catch (e) {
      // التعامل مع الأخطاء مثل انقطاع الإنترنت
    }
  }

  // دالة لمسح جميع الإشعارات
  void clearNotifications() {
    setState(() {
      notifications.clear(); // مسح قائمة الإشعارات
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Theme.of(context).brightness == Brightness.dark; // جلب حالة الثيم

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: notifications.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator()) // عرض مؤشر التحميل إذا كانت القائمة فارغة
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Card(
                  color: isDarkMode ? Colors.grey[900] : Colors.white,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.notifications,
                        color: Colors.blue), // أيقونة الإشعارات
                    title: Text(
                      notifications[index],
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
