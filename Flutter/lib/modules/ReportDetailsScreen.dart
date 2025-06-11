import 'dart:io';
import 'package:flutter/material.dart';

class ReportDetailsScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String diagnosis;
  final List<String> symptoms;
  final String additionalText;
  final String recommendation;

  const ReportDetailsScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.diagnosis,
    required this.symptoms,
    required this.additionalText,
    required this.recommendation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final File imageFile = File(imageUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text('Report Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          // عرض الصورة من ملف محلي
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageFile.existsSync()
                ? Image.file(
              imageFile,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey[300],
              child: Icon(Icons.broken_image, size: 60, color: Colors.grey[600]),
            ),
          ),
          SizedBox(height: 20),

          // نتيجة التشخيص
          Text(
            "Diagnosis:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            diagnosis,
            style: TextStyle(fontSize: 16),
          ),

          // الأعراض إن توفرت
          if (symptoms.isNotEmpty) ...[
            SizedBox(height: 20),
            Text(
              "Symptoms:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            ...symptoms.map((s) => Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text("- $s", style: TextStyle(fontSize: 16)),
            )),
          ],

          // النص الإضافي
          if (additionalText.isNotEmpty) ...[
            SizedBox(height: 20),
            Text(
              "Additional Information:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              additionalText,
              style: TextStyle(fontSize: 16),
            ),
          ],

          // التوصيات
          if (recommendation.isNotEmpty) ...[
            SizedBox(height: 20),
            Text(
              "Recommendation:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              recommendation,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ],
      ),
    );
  }
}
