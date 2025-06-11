import 'package:chatapp/modules/CommunityScreen.dart';
import 'package:chatapp/modules/ProfileScreen.dart';
import 'package:chatapp/modules/ReportsScreen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/modules/SettingsScreen.dart';

import '../ChatBotScreen.dart';
import '../DiseaseLibraryScreen.dart';
import '../WeatherScreen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile Icon
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, ProfileScreen.id),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                  ),

                  // Right Side (Weather + Menu)
                  Row(
                    children: [
                      // Weather Button
                      IconButton(
                        icon: Icon(Icons.wb_sunny_outlined),
                        tooltip: 'Weather',
                        onPressed: () {
                          Navigator.pushNamed(context, WeatherScreen.id);
                        },
                      ),

                      // Popup Menu Button
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'Settings':
                              Navigator.pushNamed(context, SettingsScreen.id);
                              break;
                            case 'Feedback':
                            // Add feedback screen route if exists
                              break;
                            case 'Contact':
                            // Add contact & social route if exists
                              break;
                            case 'Legal':
                            // Add legal notices route if exists
                              break;
                            case 'QuickStart':
                            // Add quick start guide route if exists
                              break;
                            case 'Share':
                            // Implement share functionality
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(value: 'Settings', child: Text('Settings')),
                          PopupMenuItem(value: 'Feedback', child: Text('Give Feedback')),
                          PopupMenuItem(value: 'Contact', child: Text('Contact & Social')),
                          PopupMenuItem(value: 'Legal', child: Text('Legal Notices')),
                          PopupMenuItem(value: 'QuickStart', child: Text('Quick Start')),
                          PopupMenuItem(value: 'Share', child: Text('Share E-Crop app')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),


              const SizedBox(height: 20),

              // Test Your Rice
              const Text(
                'Test Your Rice',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Upload Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _iconWithLabel('assets/images/upload.png', 'Upload\nImage'),
                        Icon(Icons.arrow_forward),
                        _iconWithLabel('assets/images/diagnosis.png', 'See a\nDiagnosis\n& Treatment'),
                        Icon(Icons.arrow_forward),
                        _iconWithLabel('assets/images/medicine.png', 'Get\nMedicine'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'UploadImageScreen');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [Colors.purpleAccent, Colors.blue],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Upload Image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // All Features
              const Text(
                'All Features',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Features Grid
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.85,
                  children: [
                    _featureItem('assets/images/library.png', 'Disease\nLibrary', () {
                      Navigator.pushNamed(context, DiseaseLibraryScreen.id);

                    }),
                    _featureItem('assets/images/report.png', 'Reports and\nTreatment', () {
                      Navigator.pushNamed(context, ReportsScreen.id);
                    }),
                    _featureItem('assets/images/community.png', 'Community', () {
                      Navigator.pushNamed(context, CommunityScreen.id);
                    }),
                    _featureItem('assets/images/chat.png', 'Chat Bot', () {
                      Navigator.pushNamed(context, ChatBotScreen.id);
                    }),
                    _featureItem('assets/images/settings.png', 'Settings', () {
                      Navigator.pushNamed(context, SettingsScreen.id);
                    }),
                    _featureItem('assets/images/chat_blue.png', 'More', () {
                      // TODO: Add functionality
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconWithLabel(String assetPath, String label) {
    return Column(
      children: [
        Image.asset(assetPath, height: 40),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _featureItem(String assetPath, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset(
                assetPath,
                height: 40,
                width: 40,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
