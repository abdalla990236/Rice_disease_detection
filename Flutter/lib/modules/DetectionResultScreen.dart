import 'dart:io';
import 'package:flutter/material.dart';

class DetectionResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;
  final File image;

  DetectionResultScreen({required this.result, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detection Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.file(image, height: 200),
            SizedBox(height: 20),
            Text("Result:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: result.entries.map((entry) {
                  return ListTile(
                    title: Text("${entry.key}"),
                    subtitle: Text("${entry.value}"),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
