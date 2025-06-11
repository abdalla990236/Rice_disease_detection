import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DetectionResultScreen.dart';

class UploadImageScreen extends StatefulWidget {
  static const id = 'UploadImageScreen';

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  bool _loading = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    Navigator.of(context).pop();

    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
      await _uploadImage(_image!);
    }
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Photo Gallery'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text('Cancel'),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadImage(File imageFile) async {
    setState(() => _loading = true);
    final uri = Uri.parse('https://web-production-f83cb.up.railway.app/predict');
    final request = http.MultipartRequest('POST', uri);

    final mimeType = lookupMimeType(imageFile.path);

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      ),
    );

    try {
      final response = await request.send();
      final resString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final result = json.decode(resString);
        print("Prediction result: $result");

        final diseaseTitle = result['predictions on'] ?? 'Unknown Disease';

        await _saveReport(
          title: diseaseTitle,
          imagePath: imageFile.path,
          diagnosis: json.encode(result),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetectionResultScreen(result: result, image: imageFile),
          ),
        );
      } else {
        _showError("Error ${response.statusCode}: $resString");
      }
    } catch (e) {
      _showError("Failed to connect to server: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveReport({
    required String title,
    required String imagePath,
    required String diagnosis,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList('reports') ?? [];

    final currentHash = await _calculateImageHash(File(imagePath));

    bool alreadyExists = existing.any((e) {
      final decoded = json.decode(e);
      return decoded['hash'] == currentHash;
    });

    if (alreadyExists) {
      print("Report for this image already exists. Skipping save.");
      return;
    }

    final report = {
      'title': title,
      'imagePath': imagePath,
      'diagnosis': diagnosis,
      'date': DateTime.now().toIso8601String(),
      'hash': currentHash,
    };

    existing.add(json.encode(report));
    await prefs.setStringList('reports', existing);
    print("Report saved successfully.");
  }

  Future<String> _calculateImageHash(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return sha256.convert(bytes).toString();
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : GestureDetector(
          onTap: _showPicker,
          child: Container(
            width: 250,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [Colors.orange.shade200, Colors.pink.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: _image == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/upload_icon.png', width: 60),
                SizedBox(height: 12),
                Text("Upload image", style: TextStyle(fontSize: 18)),
              ],
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.file(
                _image!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
