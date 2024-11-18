import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PayrollPage extends StatefulWidget {
  @override
  State<PayrollPage> createState() => _PayrollPageState();
}

class _PayrollPageState extends State<PayrollPage> {
  final TextEditingController _workingHoursController = TextEditingController();
  final TextEditingController _overtimeHoursController = TextEditingController();
  final TextEditingController _hourlyRateController = TextEditingController();
  final TextEditingController _sssController = TextEditingController();
  final TextEditingController _pagibigController = TextEditingController();
  final TextEditingController _philhealthController = TextEditingController();

  List<TextEditingController> _otherSalaryDetailsControllers = [];
  List<TextEditingController> _otherDeductionsControllers = [];

  double grossPay = 0.0;
  double netPay = 0.0;

  void _addOtherSalaryDetail() {
    setState(() {
      _otherSalaryDetailsControllers.add(TextEditingController());
    });
    _recalculatePay();
  }

  void _addOtherDeduction() {
    setState(() {
      _otherDeductionsControllers.add(TextEditingController());
    });
    _recalculatePay();
  }

  void _removeSalaryDetail(int index) {
    setState(() {
      _otherSalaryDetailsControllers[index].dispose();
      _otherSalaryDetailsControllers.removeAt(index);
    });
    _recalculatePay();
  }

  void _removeDeduction(int index) {
    setState(() {
      _otherDeductionsControllers[index].dispose();
      _otherDeductionsControllers.removeAt(index);
    });
    _recalculatePay();
  }

  void _recalculatePay() {
    double workingHours = double.tryParse(_workingHoursController.text) ?? 0;
    double overtimeHours = double.tryParse(_overtimeHoursController.text) ?? 0;
    double hourlyRate = double.tryParse(_hourlyRateController.text) ?? 0;

    // Calculate Gross Pay
    grossPay = (workingHours + overtimeHours) * hourlyRate;

    // Add Other Salary Details
    for (var controller in _otherSalaryDetailsControllers) {
      double value = double.tryParse(controller.text) ?? 0;
      grossPay += value;
    }

    // Calculate Deductions
    double totalDeductions = 0;
    totalDeductions += double.tryParse(_sssController.text) ?? 0;
    totalDeductions += double.tryParse(_pagibigController.text) ?? 0;
    totalDeductions += double.tryParse(_philhealthController.text) ?? 0;

    for (var controller in _otherDeductionsControllers) {
      double value = double.tryParse(controller.text) ?? 0;
      totalDeductions += value;
    }

    // Calculate Net Pay
    netPay = grossPay - totalDeductions;

    setState(() {});
  }

  void _storePayrollData() async {
    final user = FirebaseAuth.instance.currentUser; // Get the currently logged-in user
    if (user == null) {
      // Handle the case where no user is logged in
      return;
    }

    final data = {
      'userId': user.uid, // Associate payroll with the user's unique ID
      'workingHours': _workingHoursController.text,
      'overtimeHours': _overtimeHoursController.text,
      'hourlyRate': _hourlyRateController.text,
      'grossPay': grossPay.toStringAsFixed(2),
      'netPay': netPay.toStringAsFixed(2),
      'otherSalaryDetails': _otherSalaryDetailsControllers.map((e) => e.text).toList(),
      'deductions': [
        {'SSS': _sssController.text},
        {'Pag-IBIG': _pagibigController.text},
        {'PhilHealth': _philhealthController.text},
        ..._otherDeductionsControllers.map((e) => {'Other Deduction': e.text}).toList(),
      ],
      'date': DateTime.now(),
    };

    await FirebaseFirestore.instance.collection('payrolls').add(data);

    // Clear fields after storing
    _workingHoursController.clear();
    _overtimeHoursController.clear();
    _hourlyRateController.clear();
    _sssController.clear();
    _pagibigController.clear();
    _philhealthController.clear();
    _otherSalaryDetailsControllers.forEach((controller) => controller.clear());
    _otherDeductionsControllers.forEach((controller) => controller.clear());

    setState(() {
      grossPay = 0;
      netPay = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // UI Sections for Salary Details, Deductions, and Summary
              _buildSalaryDetailsSection(),
              const SizedBox(height: 20),
              _buildDeductionsSection(),
              const SizedBox(height: 20),
              _buildPaySummarySection(),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _storePayrollData,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black38
                  ),
                  child: const Text("Store",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalaryDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Salary Details", _addOtherSalaryDetail),
          const SizedBox(height: 16),
          _buildStaticTextField(_workingHoursController, "Working Hours"),
          const SizedBox(height: 16),
          _buildStaticTextField(_overtimeHoursController, "Overtime Hours"),
          const SizedBox(height: 16),
          _buildStaticTextField(_hourlyRateController, "Hourly Rate"),
          ..._buildDynamicFields(_otherSalaryDetailsControllers, _removeSalaryDetail),
        ],
      ),
    );
  }

  Widget _buildDeductionsSection() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Deductions", _addOtherDeduction),
          const SizedBox(height: 16),
          _buildStaticTextField(_sssController, "SSS"),
          const SizedBox(height: 16),
          _buildStaticTextField(_pagibigController, "Pag-IBIG"),
          const SizedBox(height: 16),
          _buildStaticTextField(_philhealthController, "PhilHealth"),
          ..._buildDynamicFields(_otherDeductionsControllers, _removeDeduction),
        ],
      ),
    );
  }

  Widget _buildPaySummarySection() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Net & Gross Pay",
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildReadOnlyField("Gross Pay", grossPay.toStringAsFixed(2)),
          const SizedBox(height: 16),
          _buildReadOnlyField("Net Pay", netPay.toStringAsFixed(2)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onAdd) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: onAdd,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black38
          ),
          child: const Text("Add", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildStaticTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(color: Colors.white),
      onChanged: (_) => _recalculatePay(),
    );
  }

  List<Widget> _buildDynamicFields(List<TextEditingController> controllers, void Function(int) onRemove) {
    return List<Widget>.generate(controllers.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),  // Add padding to introduce spacing
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controllers[index],
                decoration: const InputDecoration(
                  labelText: "Other",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: const TextStyle(color: Colors.white),
                onChanged: (_) => _recalculatePay(),
              ),
            ),
            const SizedBox(width: 8),  // Space between text field and delete icon
            IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () => onRemove(index),
            ),
          ],
        ),
      );
    });
  }


  Widget _buildReadOnlyField(String label, String value) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
      ),
      controller: TextEditingController(text: value),
      style: const TextStyle(color: Colors.white),
    );
  }
}
