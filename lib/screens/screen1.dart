import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 150,
        ),
        Image.asset('assets/images/firstST.png'),
        SizedBox(
          height: 5,
        ),
        Text(
          'Real-Time Rates',
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            'Our currency converter app keeps you updated with real-time exchange rates, ensuring accurate and instant conversions for smarter financial decisions, anytime, anywhere.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}