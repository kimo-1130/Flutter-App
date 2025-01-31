import 'package:flutter/material.dart'; // لاستيراد مكتبة واجهات المستخدم

class GalleryScreen extends StatelessWidget {
  // قائمة الصور
  final List<String> images = [
    "assets/s.jpg", // مسار الصورة
  ];

  GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // التحقق من حالة الثيم (ليلي/نهاري)
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("معرض الصور"),
        centerTitle: true,
        backgroundColor: isDarkMode
            ? Colors.black
            : Colors.orange, // لون الشريط العلوي بناءً على حالة الثيم
      ),
      body: images.isEmpty
          ? const Center(
              child: Text(
                "لا توجد صور لعرضها",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey), // لون النص في حالة عدم وجود صور
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16), // مسافات حول الشبكة
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عدد الأعمدة
                crossAxisSpacing: 16, // المسافة بين الأعمدة
                mainAxisSpacing: 16, // المسافة بين الصفوف
              ),
              itemCount: images.length, // عدد العناصر في الشبكة
              itemBuilder: (context, index) {
                return Card(
                  color: isDarkMode
                      ? Colors.grey[900]
                      : Colors.white, // لون الخلفية بناءً على حالة الثيم
                  elevation: 4, // ارتفاع الظل
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // نصف قطر الزوايا الدائرية
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(15), // نصف قطر الزوايا الدائرية
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover, // ملائمة الصورة داخل البطاقة
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: Icon(Icons.broken_image,
                            size: 50,
                            color: Colors
                                .red), // أيقونة خطأ في حالة عدم تحميل الصورة
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
