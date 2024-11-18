import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PayListPage extends StatelessWidget {
  const PayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF1A1A2E),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: const Color(0xFF1A1A2E),
          title: const Text(
            'Pay List',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
        ),
        body: const Center(
          child: Text(
            'Please log in to view your payroll data.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text(
          'Pay List',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('payrolls')
            .where('userId', isEqualTo: user.uid) // Filter by user ID
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No payroll data available.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index];
              return Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white10,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Date and Time: ",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${data['date'].toDate()}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Salary Details",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Working Hour(s): ${data['workingHours'] ?? 'N/A'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Overtime Hours: ${data['overtimeHours'] ?? 'N/A'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Hourly Rate: ${data['hourlyRate'] ?? 'N/A'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Other: ${data['otherSalaryDetails']?.join(', ') ?? 'N/A'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Deductions",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    if (data['deductions'] != null)
                      ...data['deductions']
                          .map<Widget>((deduction) => Text(
                        "${deduction.keys.first}: ${deduction.values.first ?? 'N/A'}",
                        style: const TextStyle(color: Colors.white),
                      ))
                          .toList(),
                    if (data['deductions'] == null ||
                        data['deductions'].isEmpty)
                      const Text(
                        "No deductions available.",
                        style: TextStyle(color: Colors.white),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      "Gross Pay: ${data['grossPay'] ?? 'N/A'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Net Pay: ${data['netPay'] ?? 'N/A'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          // Delete the document from Firestore
                          await FirebaseFirestore.instance
                              .collection('payrolls')
                              .doc(data.id)
                              .delete();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
