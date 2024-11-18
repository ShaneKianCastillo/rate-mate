import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projects/pages/pay_list_page.dart';
import 'package:projects/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Variables for user data
  String firstName = '';
  String lastName = '';
  String email = '';

  // Controllers for the edit fields
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  // Fetch the current user data from Firebase
  Future<void> _getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        email = user.email ?? '';
      });

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          firstName = userDoc['firstName'] ?? '';
          lastName = userDoc['lastName'] ?? '';
        });
        _firstNameController.text = firstName;
        _lastNameController.text = lastName;
      }
    }
  }

  // Update user's name
  Future<void> _updateUserName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Update the Firestore document with new name
      await _firestore.collection('users').doc(user.uid).update({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
      });

      setState(() {
        firstName = _firstNameController.text;
        lastName = _lastNameController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Default icon in place of image
              CircleAvatar(
                radius: 60,
                child: Icon(Icons.person, size: 60), // Default icon for the profile
              ),
              const SizedBox(height: 10),
              Text(
                firstName.isNotEmpty && lastName.isNotEmpty
                    ? '$firstName $lastName'
                    : 'Name Not Available',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 250,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    _editProfileDialog(context);
                  },
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.black26,
                thickness: 1,
                indent: 50,
                endIndent: 50,
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 110),
                leading: const Icon(Icons.payment, color: Colors.black, size: 30),
                title: const Text('Pay List',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PayListPage()),
                  );
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 110),
                leading: const Icon(Icons.logout, color: Colors.red, size: 30),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red, fontSize: 25),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog for editing the profile
  void _editProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _updateUserName();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
