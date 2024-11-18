
import 'package:flutter/material.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen1State();
}

class _Screen1State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 193,
        ),
        Image.asset('assets/images/thirdST.png'),
        SizedBox(
          height: 5,
        ),
        Text(
          'User-Friendly Interface',
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
            'User-Friendly Interface: Simple, intuitive design for seamless conversions, with clear navigation and easy access to all essential features at your fingertips.',
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
