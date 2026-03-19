// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medi_ai/ip.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:typed_data';
// import 'forgotemail.dart';
// import 'homepage.dart';
// import 'hospital_signup.dart';
// import 'main.dart';
//
// void main() {
//   return runApp(MaterialApp(
//     home: LoginPage(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
//
// class LoginPage extends StatefulWidget {
//   @override
//   _AdduserState createState() => _AdduserState();
// }
//
// class _AdduserState extends State<LoginPage> {
//   final txtUsername = new TextEditingController(text: "sangeeth@gmail.com");
//   final txtPassword = new TextEditingController(text: "Sangeeth@000");
//
//   bool _valEmail = false;
//   bool _valPassword = false;
//   bool _isLoading = false;
//   bool _obscurePassword = true;
//
//   bool error = false;
//   var data;
//   var holder_1 = [];
//   String a1 = "";
//
//   // Color palette matching HomePage
//   final Color primaryDark = const Color(0xFF1B3C53);
//   final Color primary = const Color(0xFF2A5170);
//   final Color primaryLight = const Color(0xFF4A7696);
//   final Color accent = const Color(0xFFF0F4F8);
//   final Color textColor = const Color(0xFF1E3A5F);
//
//   // Poppins Font Styles matching HomePage
//   TextStyle get poppinsRegular => const TextStyle(
//     fontFamily: 'Poppins',
//     fontWeight: FontWeight.w400,
//   );
//
//   TextStyle get poppinsMedium => const TextStyle(
//     fontFamily: 'Poppins',
//     fontWeight: FontWeight.w500,
//   );
//
//   TextStyle get poppinsSemiBold => const TextStyle(
//     fontFamily: 'Poppins',
//     fontWeight: FontWeight.w600,
//   );
//
//   TextStyle get poppinsBold => const TextStyle(
//     fontFamily: 'Poppins',
//     fontWeight: FontWeight.w700,
//   );
//
//   Future _saveDetails(String email, String password) async {
//     if (email.isEmpty || password.isEmpty) {
//       setState(() {
//         _valEmail = email.isEmpty;
//         _valPassword = password.isEmpty;
//       });
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? url = prefs.getString("url");
//       var data = await http.post(
//         Uri.parse(url.toString() + "/hosp_login"),
//         body: {"un": email, "ps": password},
//       ).timeout(const Duration(seconds: 30));
//
//       try {
//         var jsondata = json.decode(data.body);
//         print(jsondata);
//
//         if (jsondata["status"] == "no") {
//           if (mounted) {
//             setState(() {
//               _isLoading = false;
//             });
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                   'Invalid email or password',
//                   style: poppinsMedium.copyWith(color: Colors.white),
//                 ),
//                 backgroundColor: Colors.red,
//                 behavior: SnackBarBehavior.floating,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             );
//           }
//         } else if (jsondata["status"] == "ok") {
//           if (mounted) {
//             setState(() {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     'Login successful',
//                     style: poppinsMedium.copyWith(color: Colors.white),
//                   ),
//                   backgroundColor: Colors.green,
//                   behavior: SnackBarBehavior.floating,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               );
//             });
//
//             // Save the data returned from the server and navigate to the home page
//             String hid = jsondata["hid"].toString();
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             await prefs.setString("hid", hid);
//             await prefs.setString('password', password.toString());
//             print(jsondata);
//
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//           }
//         } else {
//           print("Error: Failed login.");
//           if (mounted) {
//             setState(() {
//               _isLoading = false;
//             });
//           }
//         }
//       } catch (e) {
//         print("Exception: " + e.toString());
//         if (mounted) {
//           setState(() {
//             _isLoading = false;
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'Connection error. Please try again.',
//                 style: poppinsMedium.copyWith(color: Colors.white),
//               ),
//               backgroundColor: Colors.red,
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       print("Network Error: " + e.toString());
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Network error. Please check your connection.',
//               style: poppinsMedium.copyWith(color: Colors.white),
//             ),
//             backgroundColor: Colors.red,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     txtUsername.dispose();
//     txtPassword.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(''),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios), // Custom back icon
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => IPPage()),
//             );
//           },
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               accent,
//               Colors.white,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Main Content
//                 Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 20),
//
//                       // Logo and Title - Similar to HomePage header
//                       Row(
//                         children: [
//                           Container(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.transparent,
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image.asset(
//                                 'assets/logoM.png',
//                                 fit: BoxFit.contain,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Container(
//                                     color: primary.withOpacity(0.1),
//                                     child: Icon(
//                                       Icons.medical_services,
//                                       color: primary,
//                                       size: 30,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: 'MEDI ',
//                                   style: poppinsBold.copyWith(
//                                     color: textColor,
//                                     fontSize: 24,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: 'AI',
//                                   style: poppinsBold.copyWith(
//                                     color: primaryLight,
//                                     fontSize: 24,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 40),
//
//                       // Welcome Text - Similar to HomePage section headers
//                       Text(
//                         "Welcome Back",
//                         style: poppinsBold.copyWith(
//                           color: textColor,
//                           fontSize: 28,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Sign in to access your medical dashboard",
//                         style: poppinsMedium.copyWith(
//                           color: primaryLight,
//                           fontSize: 16,
//                         ),
//                       ),
//
//                       const SizedBox(height: 40),
//
//                       // Email Field - Redesigned like HomePage inputs
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: _valEmail
//                                 ? Colors.red.withOpacity(0.5)
//                                 : accent.withOpacity(0.8),
//                             width: 1.5,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.03),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: TextField(
//                           controller: txtUsername,
//                           style: poppinsMedium.copyWith(
//                             color: textColor,
//                             fontSize: 15,
//                           ),
//                           decoration: InputDecoration(
//                             hintText: "Email Address",
//                             hintStyle: poppinsRegular.copyWith(
//                               color: primaryLight.withOpacity(0.5),
//                               fontSize: 15,
//                             ),
//                             prefixIcon: Container(
//                               width: 50,
//                               child: Icon(
//                                 Icons.email_outlined,
//                                 color: primary,
//                                 size: 20,
//                               ),
//                             ),
//                             border: InputBorder.none,
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 18,
//                             ),
//                           ),
//                           onChanged: (value) {
//                             if (_valEmail && value.isNotEmpty) {
//                               setState(() => _valEmail = false);
//                             }
//                           },
//                         ),
//                       ),
//                       if (_valEmail)
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 8),
//                           child: Text(
//                             'Email is required',
//                             style: poppinsRegular.copyWith(
//                               color: Colors.red,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//
//                       const SizedBox(height: 20),
//
//                       // Password Field - Redesigned like HomePage inputs
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: _valPassword
//                                 ? Colors.red.withOpacity(0.5)
//                                 : accent.withOpacity(0.8),
//                             width: 1.5,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.03),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: TextField(
//                           controller: txtPassword,
//                           obscureText: _obscurePassword,
//                           style: poppinsMedium.copyWith(
//                             color: textColor,
//                             fontSize: 15,
//                           ),
//                           decoration: InputDecoration(
//                             hintText: "Password",
//                             hintStyle: poppinsRegular.copyWith(
//                               color: primaryLight.withOpacity(0.5),
//                               fontSize: 15,
//                             ),
//                             prefixIcon: Container(
//                               width: 50,
//                               child: Icon(
//                                 Icons.lock_outlined,
//                                 color: primary,
//                                 size: 20,
//                               ),
//                             ),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _obscurePassword
//                                     ? Icons.visibility_outlined
//                                     : Icons.visibility_off_outlined,
//                                 color: primaryLight,
//                                 size: 20,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _obscurePassword = !_obscurePassword;
//                                 });
//                               },
//                             ),
//                             border: InputBorder.none,
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 18,
//                             ),
//                           ),
//                           onChanged: (value) {
//                             if (_valPassword && value.isNotEmpty) {
//                               setState(() => _valPassword = false);
//                             }
//                           },
//                         ),
//                       ),
//                       if (_valPassword)
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 8),
//                           child: Text(
//                             'Password is required',
//                             style: poppinsRegular.copyWith(
//                               color: Colors.red,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//
//                       const SizedBox(height: 30),
//
//                       // Forgot Password - Styled like HomePage link
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => forgotemail(),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 4,
//                             ),
//                             child: Text(
//                               "Forgot Password?",
//                               style: poppinsMedium.copyWith(
//                                 color: primaryLight,
//                                 fontSize: 14,
//                                 decoration: TextDecoration.underline,
//                                 decorationColor: primaryLight.withOpacity(0.3),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 30),
//
//                       // Login Button - Similar to HomePage buttons
//                       Container(
//                         width: double.infinity,
//                         height: 55,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [primary, primaryLight],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: primary.withOpacity(0.3),
//                               blurRadius: 15,
//                               offset: const Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         child: Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             onTap: _isLoading
//                                 ? null
//                                 : () {
//                               _saveDetails(
//                                 txtUsername.text,
//                                 txtPassword.text,
//                               );
//                             },
//                             borderRadius: BorderRadius.circular(16),
//                             child: Center(
//                               child: _isLoading
//                                   ? SizedBox(
//                                 width: 24,
//                                 height: 24,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2.5,
//                                   valueColor:
//                                   AlwaysStoppedAnimation<Color>(
//                                       Colors.white),
//                                 ),
//                               )
//                                   : Text(
//                                 "SIGN IN",
//                                 style: poppinsSemiBold.copyWith(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // Register Button - Similar to HomePage outline buttons
//                       Container(
//                         width: double.infinity,
//                         height: 55,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: primary.withOpacity(0.2),
//                             width: 1.5,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.02),
//                               blurRadius: 8,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => hpspital_signup(),
//                                 ),
//                               );
//                             },
//                             borderRadius: BorderRadius.circular(16),
//                             child: Center(
//                               child: Text(
//                                 "CREATE NEW ACCOUNT",
//                                 style: poppinsSemiBold.copyWith(
//                                   color: primary,
//                                   fontSize: 16,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 40),
//
//                       // Security Info - Similar to HomePage bottom info
//                       Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: accent.withOpacity(0.8),
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.02),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 48,
//                               height: 48,
//                               decoration: BoxDecoration(
//                                 color: primary.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Center(
//                                 child: Icon(
//                                   Icons.health_and_safety_outlined,
//                                   color: primary,
//                                   size: 24,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "HIPAA Compliant",
//                                     style: poppinsSemiBold.copyWith(
//                                       color: textColor,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     "Your medical data is encrypted and secure",
//                                     style: poppinsRegular.copyWith(
//                                       color: primaryLight,
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       const SizedBox(height: 20),
//
//                       // Version - Similar to HomePage
//                       Center(
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 8,
//                           ),
//                           decoration: BoxDecoration(
//                             color: accent.withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             "v2.1.0",
//                             style: poppinsMedium.copyWith(
//                               color: primaryLight,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medi_ai/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'forgotemail.dart';
import 'homepage.dart';
import 'hospital_signup.dart';
import 'main.dart';

void main() {
  return runApp(MaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class LoginPage extends StatefulWidget {
  @override
  _AdduserState createState() => _AdduserState();
}

class _AdduserState extends State<LoginPage> {
  final txtUsername = new TextEditingController(text: "sangeeth@gmail.com");
  final txtPassword = new TextEditingController(text: "Sangeeth@123");

  bool _valEmail = false;
  bool _valPassword = false;
  bool _isLoading = false;
  bool _obscurePassword = true;

  bool error = false;
  var data;
  var holder_1 = [];
  String a1 = "";

  // Color palette matching HomePage
  final Color primaryDark = const Color(0xFF1B3C53);
  final Color primary = const Color(0xFF2A5170);
  final Color primaryLight = const Color(0xFF4A7696);
  final Color accent = const Color(0xFFF0F4F8);
  final Color textColor = const Color(0xFF1E3A5F);

  // Poppins Font Styles matching HomePage
  TextStyle get poppinsRegular => const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  TextStyle get poppinsMedium => const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  TextStyle get poppinsSemiBold => const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );

  TextStyle get poppinsBold => const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  Future _saveDetails(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _valEmail = email.isEmpty;
        _valPassword = password.isEmpty;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      var data = await http.post(
        Uri.parse(url.toString() + "/hosp_login"),
        body: {"un": email, "ps": password},
      ).timeout(const Duration(seconds: 30));

      try {
        var jsondata = json.decode(data.body);
        print(jsondata);

        if (jsondata["status"] == "no") {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Invalid email or password',
                  style: poppinsMedium.copyWith(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        } else if (jsondata["status"] == "ok") {
          if (mounted) {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Login successful',
                    style: poppinsMedium.copyWith(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            });

            // Save the data returned from the server and navigate to the home page
            String hid = jsondata["hid"].toString();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString("hid", hid);
            await prefs.setString('password', password.toString());
            print(jsondata);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        } else {
          print("Error: Failed login.");
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        }
      } catch (e) {
        print("Exception: " + e.toString());
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Connection error. Please try again.',
                style: poppinsMedium.copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      }
    } catch (e) {
      print("Network Error: " + e.toString());
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Network error. Please check your connection.',
              style: poppinsMedium.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    txtUsername.dispose();
    txtPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // MERGED HEADER - HomePage style AppBar with back button
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/logoM.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.medical_services, color: primary, size: 30);
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'MEDI ',
                    style: poppinsBold.copyWith(
                      color: textColor,
                      fontSize: 20,
                    ),
                  ),
                  TextSpan(
                    text: 'AI',
                    style: poppinsBold.copyWith(
                      color: primaryLight,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(color: primaryDark),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: primaryDark),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => IPPage()),
            );
          },
        ),
      ),

      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accent,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Main Content
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // Welcome Header with Secure Badge - HomePage style
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome Back",
                                    style: poppinsBold.copyWith(
                                      color: textColor,
                                      fontSize: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Sign in to access your medical dashboard",
                                    style: poppinsMedium.copyWith(
                                      color: primaryLight,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [primary, primaryLight],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: primary.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.medical_services, color: Colors.white, size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Secure",
                                    style: poppinsSemiBold.copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Login Form Card - HomePage style card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: accent.withOpacity(0.8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              // Email Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.email_outlined, color: primary, size: 16),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Email Address",
                                        style: poppinsSemiBold.copyWith(
                                          color: textColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: accent.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: _valEmail
                                            ? Colors.red.withOpacity(0.5)
                                            : accent.withOpacity(0.8),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: txtUsername,
                                      style: poppinsMedium.copyWith(
                                        color: textColor,
                                        fontSize: 14,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Enter your email",
                                        hintStyle: poppinsRegular.copyWith(
                                          color: primaryLight.withOpacity(0.5),
                                          fontSize: 14,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (_valEmail && value.isNotEmpty) {
                                          setState(() => _valEmail = false);
                                        }
                                      },
                                    ),
                                  ),
                                  if (_valEmail)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12, top: 6),
                                      child: Text(
                                        'Email is required',
                                        style: poppinsRegular.copyWith(
                                          color: Colors.red,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Password Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.lock_outlined, color: primaryLight, size: 16),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Password",
                                        style: poppinsSemiBold.copyWith(
                                          color: textColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: accent.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: _valPassword
                                            ? Colors.red.withOpacity(0.5)
                                            : accent.withOpacity(0.8),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: txtPassword,
                                      obscureText: _obscurePassword,
                                      style: poppinsMedium.copyWith(
                                        color: textColor,
                                        fontSize: 14,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Enter your password",
                                        hintStyle: poppinsRegular.copyWith(
                                          color: primaryLight.withOpacity(0.5),
                                          fontSize: 14,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: primaryLight,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword = !_obscurePassword;
                                            });
                                          },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (_valPassword && value.isNotEmpty) {
                                          setState(() => _valPassword = false);
                                        }
                                      },
                                    ),
                                  ),
                                  if (_valPassword)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12, top: 6),
                                      child: Text(
                                        'Password is required',
                                        style: poppinsRegular.copyWith(
                                          color: Colors.red,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // Forgot Password - UNDERLINE REMOVED
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => forgotemail(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      "Forgot Password?",
                                      style: poppinsMedium.copyWith(
                                        color: primaryLight,
                                        fontSize: 12,
                                        // Removed decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Sign In Button - HomePage style
                      Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primary, primaryLight],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: primary.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _isLoading
                                ? null
                                : () {
                              _saveDetails(
                                txtUsername.text,
                                txtPassword.text,
                              );
                            },
                            borderRadius: BorderRadius.circular(14),
                            child: Center(
                              child: _isLoading
                                  ? SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                                  : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login_outlined,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "SIGN IN",
                                    style: poppinsSemiBold.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Create Account Button
                      Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: primary.withOpacity(0.2),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => hpspital_signup(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(14),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person_add_outlined,
                                    color: primary,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "CREATE NEW ACCOUNT",
                                    style: poppinsSemiBold.copyWith(
                                      color: primary,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Security Info
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: accent.withOpacity(0.8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [primary.withOpacity(0.1), primaryLight.withOpacity(0.1)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.shield_outlined,
                                  color: primary,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "HIPAA Compliant",
                                    style: poppinsSemiBold.copyWith(
                                      color: textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Your medical data is encrypted and secure",
                                    style: poppinsRegular.copyWith(
                                      color: primaryLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Version
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "v2.1.0",
                            style: poppinsMedium.copyWith(
                              color: primaryLight,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}