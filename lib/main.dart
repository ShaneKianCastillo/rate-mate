import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projects/firebase_options.dart';
import 'package:projects/pages/forex_page.dart';
import 'package:projects/pages/forex_rate_display.dart';
import 'package:projects/pages/home_page.dart';
import 'package:projects/pages/sign_up_page.dart';
import 'package:projects/pages/start_up_screens.dart';
import 'pages/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

