import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart'; // For setting orientation
import 'package:intl/intl.dart'; // For date formatting

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Lock orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Reset orientation when leaving the page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Reset orientation when navigating back
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF1A1A2E),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, // Set the back arrow color
          ),
          backgroundColor: Color(0xFF1A1A2E),
          title: const Text('Admin Dashboard',style: TextStyle(color: Colors.white),),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No users found.'),
              );
            }

            final users = snapshot.data!.docs;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Email',style: TextStyle(color: Colors.white),)),
                  DataColumn(label: Text('Name',style: TextStyle(color: Colors.white),)),
                  DataColumn(label: Text('Date',style: TextStyle(color: Colors.white),)),
                  DataColumn(label: Text('Country',style: TextStyle(color: Colors.white),)),
                ],
                rows: users.map((user) {
                  final email = user['email'] ?? 'Unknown';
                  final name = '${user['firstName']} ${user['lastName']}';
                  final country = user['country'] ?? 'Unknown';

                  // Format the date
                  final timestamp = user['date'] as Timestamp?;
                  final formattedDate = timestamp != null
                      ? DateFormat.yMMMd().format(timestamp.toDate())
                      : 'Unknown';

                  return DataRow(cells: [
                    DataCell(Text(email, style: const TextStyle(color: Colors.white))),
                    DataCell(Text(name, style: const TextStyle(color: Colors.white))),
                    DataCell(Text(formattedDate, style: const TextStyle(color: Colors.white))),
                    DataCell(Text(country, style: const TextStyle(color: Colors.white))),
                  ]);
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
