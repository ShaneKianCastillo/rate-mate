import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen1State();
}

class _Screen1State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 170,
        ),
        Image.asset('assets/images/secondST.png'),
        SizedBox(
          height: 5,
        ),
        Text(
          'Multi-Currency Support',
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
            'Convert between multiple currencies quickly and easily, allowing you to compare rates and make informed decisions when handling international transactions.',
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