// forex_rate_display.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForexRateDisplay extends StatefulWidget {
  @override
  _ForexRateDisplayState createState() => _ForexRateDisplayState();
}

class _ForexRateDisplayState extends State<ForexRateDisplay> {
  String fromCurrency = 'USD';
  String toCurrency = 'PHP';
  String fromAED = 'AED';
  double rate = 0.0;
  double rateAED = 0.0;


  @override
  void initState() {
    super.initState();
    _getRateUSD();
    _getRateAED();
  }

  Future<void> _getRateUSD() async {
    try {
      var response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'));
      var data = json.decode(response.body);

      setState(() {
        rate = data['rates'][toCurrency];
      });
    } catch (e) {
      print("Error fetching rate: $e");
      // Handle the error appropriately
    }
  }
  Future<void> _getRateAED() async {
    try {
      var response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromAED'));
      var data = json.decode(response.body);

      setState(() {
        rateAED = data['rates'][toCurrency];
      });
    } catch (e) {
      print("Error fetching rate: $e");
      // Handle the error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Current Exchange Rate', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '1 $fromCurrency -> ${rate.toStringAsFixed(2)} $toCurrency',
                style: TextStyle(color: Colors.greenAccent, fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Exchange Rate from $fromCurrency to $toCurrency',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '1 $fromAED -> ${rateAED.toStringAsFixed(2)} $toCurrency',
                style: TextStyle(color: Colors.greenAccent, fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Exchange Rate from $fromAED to $toCurrency',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
