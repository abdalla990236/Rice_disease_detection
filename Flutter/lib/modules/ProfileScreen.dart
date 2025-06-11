import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController(text: "***********");

  String dob = "23/05/2003";
  String country = "Egypt";
  String state = "Maharashtra";
  String city = "Sohag";
  String crop = "";

  List<String> countries = ['Egypt', 'KSA'];
  List<String> states = ['Maharashtra', 'Gujarat'];
  List<String> cities = ['Sohag', 'Assuit'];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emailController.text = user.email ?? '';
      nameController.text = user.displayName ?? ''; // Will be empty if not set
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Profile'),
        actions: [
          TextButton(
            onPressed: () {
              // Save changes logic
            },
            child: Text("Save changes", style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text(emailController.text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              const SizedBox(height: 20),
              _buildTextField("Name", nameController),
              _buildTextField("Email", emailController),
              _buildTextField("Password", passwordController, isPassword: true),
              _buildDropdown("Date of Birth", [dob], dob, (val) => setState(() => dob = val!)),
              _buildDropdown("Country/Region", countries, country, (val) => setState(() => country = val!)),
              _buildDropdown("State", states, state, (val) => setState(() => state = val!)),
              _buildDropdown("City", cities, city, (val) => setState(() => city = val!)),
              _buildTextField("Crop", TextEditingController(text: crop)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> items, String selectedItem, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButtonFormField<String>(
          value: selectedItem,
          items: items.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
