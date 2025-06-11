import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../Model/PostStore.dart';

class CommunityScreen extends StatefulWidget {
  static const String id = 'CommunityScreen';

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Optional popup actions
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search in Community',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          

          // Posts List
          Expanded(
            child: ListView.builder(
              itemCount: PostStore.posts.length,
              itemBuilder: (context, index) {
                final post = PostStore.posts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (post.image != null)
                          Image.file(post.image!, height: 200, width: double.infinity, fit: BoxFit.cover),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("You • Your Location", style: TextStyle(color: Colors.teal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(post.question),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("New post", style: TextStyle(color: Colors.grey)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Translate", style: TextStyle(color: Colors.blue)),
                              Spacer(),
                              Text("0 answers", style: TextStyle(color: Colors.grey)),
                              SizedBox(width: 8),
                              Icon(Icons.chat, color: Colors.green),
                            ],
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  post.upvotes++;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.thumb_up_alt_outlined, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text("Upvote (${post.upvotes})"),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  post.downvotes++;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.thumb_down_alt_outlined, color: Colors.red),
                                  SizedBox(width: 4),
                                  Text("Downvote (${post.downvotes})"),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Ask Community Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              icon: Icon(Icons.edit),
              label: Text("Ask Community"),
              onPressed: () {
                TextEditingController _questionController = TextEditingController();
                _selectedImage = null;

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Ask the Community", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              TextField(
                                controller: _questionController,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: "Write your question here...",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              if (_selectedImage != null)
                                Image.file(_selectedImage!, height: 150),
                              ElevatedButton.icon(
                                onPressed: _pickImage,
                                icon: Icon(Icons.image),
                                label: Text("Upload Image"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  foregroundColor: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  final question = _questionController.text.trim();
                                  if (question.isNotEmpty) {
                                    setState(() {
                                      PostStore.posts.insert(0, Post(question: question, image: _selectedImage));
                                      _selectedImage = null;
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text("Submit"),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
