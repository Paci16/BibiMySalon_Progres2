import 'package:flutter/material.dart';

// Halaman Profile dengan informasi pengguna
class Profile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  String name = 'whitney';
  String email = 'whitney@gmail.com';
  String phone = '123';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00148D), // Warna biru tua yang konsisten
        toolbarHeight: 80.0,
        title: Stack(
          children: [
            Center( // Menempatkan logo di tengah
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Image.asset(
                  'img/logo.jpg', // Path ke logo
                  height: 50, // Sesuaikan ukuran logo
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul halaman dengan gaya yang lebih dekoratif
            Center(
              child: Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00148D), // Warna biru tua untuk judul
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildProfileRow('Name:', name),
            SizedBox(height: 10),
            _buildProfileRow('Email:', email),
            SizedBox(height: 10),
            _buildProfileRow('Phone:', phone),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showEditDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEAE3), // Tombol dengan warna biru tua
                ),
                child: Text('Edit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Membuat widget untuk menampilkan informasi profil
  Widget _buildProfileRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  // Dialog untuk mengedit informasi profil
  void _showEditDialog() {
    final TextEditingController nameController = TextEditingController(text: name);
    final TextEditingController emailController = TextEditingController(text: email);
    final TextEditingController phoneController = TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  email = emailController.text;
                  phone = phoneController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
