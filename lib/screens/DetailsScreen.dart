import 'package:flutter/material.dart';

// DetailsScreen هو StatefulWidget يسمح بإعادة بناء الواجهة عند تغيير الحالة
class DetailsScreen extends StatefulWidget {
  final String title;
  final String body;
  const DetailsScreen({super.key, required this.title, required this.body});
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

// _DetailsScreenState هو الحالة لـ DetailsScreen
class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold يوفر الهيكل الأساسي للشاشة
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      // SingleChildScrollView يضمن أن الشاشة قابلة للتمرير إذا كان المحتوى أطول من الشاشة
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          // Column يرتب العناصر بشكل عمودي
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'عنوان التفاصيل',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0), // يوفر مسافة بين العناصر
              Text(
                'هذا نص تفصيلي يمكن أن يحتوي على معلومات حول الموضوع.',
                style: TextStyle(fontSize: 18),
              ),
              // ... يمكن إضافة المزيد من العناصر هنا
            ],
          ),
        ),
      ),
    );
  }
}
