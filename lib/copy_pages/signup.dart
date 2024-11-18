// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:projects/loginPage.dart';
//
// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});
//
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }
//
// class _SignUpPageState extends State<SignUpPage> {
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//   TextEditingController();
//
//   void registerUser() async {
//     showDialog(
//       context: context,
//       builder: (context) => Center(child: CircularProgressIndicator()),
//     );
//
//     if (passwordController.text != confirmPasswordController.text) {
//       Navigator.pop(context);
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Passwords don\'t match'),
//         ),
//       );
//     } else {
//       try {
//         UserCredential userCredential =
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: emailController.text,
//           password: passwordController.text,
//         );
//         Navigator.pop(context);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => RegisterScreen()),
//         );
//       } on FirebaseAuthException catch (e) {
//         Navigator.pop(context);
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text(e.message ?? 'Registration failed'),
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('images/login_bk.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Register',
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     color: Colors.blueAccent,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 _buildTextField(
//                   'Name',
//                   'Input Name',
//                   nameController,
//                   false,
//                 ),
//                 SizedBox(height: 20),
//                 _buildTextField(
//                   'Email',
//                   'Input Email',
//                   emailController,
//                   false,
//                 ),
//                 SizedBox(height: 20),
//                 _buildPasswordField(
//                   'Password',
//                   'Input Password',
//                   passwordController,
//                   _isPasswordVisible,
//                       () => setState(() {
//                     _isPasswordVisible = !_isPasswordVisible;
//                   }),
//                 ),
//                 SizedBox(height: 20),
//                 _buildPasswordField(
//                   'Confirm Password',
//                   'Input same password',
//                   confirmPasswordController,
//                   _isConfirmPasswordVisible,
//                       () => setState(() {
//                     _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                   }),
//                 ),
//                 SizedBox(height: 30),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: SizedBox(
//                     width: 150,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: registerUser,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Text(
//                         'Register',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       "Already have an account? Sign In",
//                       style: TextStyle(color: Colors.blueAccent),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, String hintText,
//       TextEditingController controller, bool isPassword) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.blueAccent,
//             fontSize: 16,
//           ),
//         ),
//         SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           obscureText: isPassword,
//           style: TextStyle(color: Colors.black),
//           decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: TextStyle(color: Colors.grey),
//             border: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.blueAccent),
//             ),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.blueAccent),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.blueAccent, width: 2),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPasswordField(
//       String label,
//       String hintText,
//       TextEditingController controller,
//       bool isVisible,
//       VoidCallback onToggleVisibility,
//       ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.blueAccent,
//             fontSize: 16,
//           ),
//         ),
//         SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           obscureText: !isVisible,
//           style: TextStyle(color: Colors.black),
//           decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: TextStyle(color: Colors.grey),
//             border: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.blueAccent),
//             ),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.blueAccent),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.blueAccent, width: 2),
//             ),
//             suffixIcon: IconButton(
//               icon: Icon(
//                 isVisible ? Icons.visibility : Icons.visibility_off,
//                 color: Colors.grey,
//               ),
//               onPressed: onToggleVisibility,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }