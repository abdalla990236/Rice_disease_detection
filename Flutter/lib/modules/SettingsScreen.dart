import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const id = 'SettingsScreen';


  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, bool> notificationSettings = {
    'Information about my crops': true,
    'Popular Post': true,
    'Answer to your post': true,
    'Upvote to your post': true,
    'New Follower!': false,
    'Post from someone you follow': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: BackButton(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _sectionTitle('General'),
          _infoTile('Select your Language', 'English'),
          _infoTile('Country', 'India'),
          Divider(height: 32),
          _sectionTitle('Notifications'),
          ...notificationSettings.keys.map((title) {
            return _switchTile(
              title,
              notificationSettings[title]!,
                  (value) {
                setState(() {
                  notificationSettings[title] = value;
                });
              },
            );
          }).toList(),
          Divider(height: 32),
          _sectionTitle('Application'),
          ListTile(
            title: Text('Version: 3.9.0'),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.green.shade700,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _switchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green,
    );
  }
}
