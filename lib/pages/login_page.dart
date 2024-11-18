import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'admin_login_page.dart'; // Import Admin Login Page
import 'sign_up_page.dart';
import 'start_up_screens.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to handle user login
  Future<void> loginUser() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _usernameController.text,
          password: _passwordController.text,
        );

        // Navigate to StartUpScreens if login is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StartUpScreens()),
        );
      } on FirebaseAuthException catch (e) {
        // Display error dialog for failed login
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid credentials'),
            content: Text('Please check your email and password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Login bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Admin Icon in the Top-Right Corner
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.admin_panel_settings, color: Colors.white),
              onPressed: () {
                // Navigate to the Admin Login Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLoginPage()),
                );
              },
              tooltip: "Admin Login",
            ),
          ),

          // Login Form
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 85),
              child: Container(
                width: 280,
                height: 380,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 14),
                      // Email TextField
                      SizedBox(
                        width: 270,
                        height: 50,
                        child: TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Input your Email',
                            filled: true,
                            fillColor: Colors.grey[800]?.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: TextStyle(color: Color(0xFFACACAC)),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      // Password TextField
                      Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: SizedBox(
                          width: 270,
                          height: 50,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              filled: true,
                              fillColor: Colors.grey[800]?.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: TextStyle(color: Color(0xFFACACAC)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black45,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Color(0xFFACACAC),
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(text: "Don't have an account yet? "),
                              TextSpan(
                                text: 'Sign Up here',
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpPage()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Login Button
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          height: 60,
                          width: 270,
                          child: TextButton(
                            onPressed: loginUser,
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF13294C),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
