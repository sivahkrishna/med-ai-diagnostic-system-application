// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'forgototp.dart';
// import 'login.dart';
//
// void main() {
//   runApp(forgotemail());
// }
//
// class forgotemail extends StatelessWidget {
//   const forgotemail({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: forgotemailsub(),
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Poppins',
//       ),
//     );
//   }
// }
//
// class forgotemailsub extends StatefulWidget {
//   const forgotemailsub({Key? key}) : super(key: key);
//
//   @override
//   State<forgotemailsub> createState() => _forgotemailsubState();
// }
//
// class _forgotemailsubState extends State<forgotemailsub> {
//   TextEditingController email = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//
//   // MEDI AI Color Palette
//   final Color primaryDark = const Color(0xFF1B3C53);
//   final Color primary = const Color(0xFF2A5170);
//   final Color primaryLight = const Color(0xFF4A7696);
//   final Color accent = const Color(0xFFF0F4F8);
//   final Color textColor = const Color(0xFF1E3A5F);
//
//   // Poppins Font Styles
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
//   Future<void> _checkEmail() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       sh.setString("email", email.text);
//
//       var res = await http.post(
//         Uri.parse("${sh.getString("url")}/forgotemail"),
//         body: {'email': email.text},
//       );
//
//       var decode = json.decode(res.body);
//
//       if (decode["status"] == "ok") {
//         sh.setString("otpp", decode['otpp'].toString());
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('OTP sent to your email!'),
//             backgroundColor: Colors.green,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//         );
//         Navigator.push(context, MaterialPageRoute(builder: (context) => forgototp()));
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text(
//               "Email Not Found",
//               style: poppinsSemiBold.copyWith(color: Colors.red),
//             ),
//             content: Text(
//               "The email address you entered is not registered.",
//               style: poppinsRegular.copyWith(color: textColor),
//             ),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: TextButton.styleFrom(foregroundColor: primary),
//                 child: Text("OK", style: poppinsSemiBold.copyWith(color: primary)),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text(
//             "Connection Error",
//             style: poppinsSemiBold.copyWith(color: Colors.red),
//           ),
//           content: Text(
//             "Please check your internet connection.",
//             style: poppinsRegular.copyWith(color: textColor),
//           ),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               style: TextButton.styleFrom(foregroundColor: primary),
//               child: Text("OK", style: poppinsSemiBold.copyWith(color: primary)),
//             ),
//           ],
//         ),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           children: [
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.transparent,
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.asset(
//                   'assets/logoM.png',
//                   fit: BoxFit.contain,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Icon(Icons.medical_services, color: primary, size: 30);
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: 'MEDI ',
//                     style: poppinsBold.copyWith(color: textColor, fontSize: 20),
//                   ),
//                   TextSpan(
//                     text: 'AI',
//                     style: poppinsBold.copyWith(color: primaryLight, fontSize: 20),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new, color: primaryDark, size: 20),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => LoginPage()),
//             );
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title
//                 Text(
//                   'Forgot password?',
//                   style: poppinsBold.copyWith(fontSize: 28, color: textColor),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   "Enter your email to receive OTP",
//                   style: poppinsRegular.copyWith(fontSize: 16, color: primaryLight),
//                 ),
//
//                 SizedBox(height: 40),
//
//                 // Email Input with Form
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Email Address',
//                         style: poppinsSemiBold.copyWith(fontSize: 14, color: textColor),
//                       ),
//                       SizedBox(height: 8),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: accent,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: TextFormField(
//                           controller: email,
//                           keyboardType: TextInputType.emailAddress,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your email address';
//                             }
//                             if (!value.contains('@')) {
//                               return 'Please enter a valid email address';
//                             }
//                             return null;
//                           },
//                           style: poppinsRegular.copyWith(color: textColor),
//                           decoration: InputDecoration(
//                             hintText: "Enter your registered email",
//                             hintStyle: poppinsRegular.copyWith(color: primaryLight.withOpacity(0.5)),
//                             prefixIcon: Icon(Icons.email_outlined, color: primary, size: 20),
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 8),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Text(
//                     'We will send a 6-digit OTP to this email',
//                     style: poppinsRegular.copyWith(fontSize: 12, color: primaryLight),
//                   ),
//                 ),
//
//                 SizedBox(height: 40),
//
//                 // Send OTP Button
//                 Container(
//                   width: double.infinity,
//                   height: 56,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [primary, primaryLight],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: primary.withOpacity(0.3),
//                         blurRadius: 15,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _checkEmail,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       shadowColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                     ),
//                     child: _isLoading
//                         ? SizedBox(
//                       height: 20,
//                       width: 20,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                       ),
//                     )
//                         : Text(
//                       'SEND OTP',
//                       style: poppinsSemiBold.copyWith(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//
//                 // Help Text - Minimal
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: accent,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.info_outline, color: primary, size: 18),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Text(
//                           "Check spam folder if not received",
//                           style: poppinsRegular.copyWith(fontSize: 13, color: textColor),
//                         ),
//                       ),
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
import 'package:shared_preferences/shared_preferences.dart';

import 'forgototp.dart';
import 'login.dart';

void main() {
  runApp(forgotemail());
}

class forgotemail extends StatelessWidget {
  const forgotemail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: forgotemailsub(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class forgotemailsub extends StatefulWidget {
  const forgotemailsub({Key? key}) : super(key: key);

  @override
  State<forgotemailsub> createState() => _forgotemailsubState();
}

class _forgotemailsubState extends State<forgotemailsub> {
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // MEDI AI Color Palette
  final Color primaryDark = const Color(0xFF1B3C53);
  final Color primary = const Color(0xFF2A5170);
  final Color primaryLight = const Color(0xFF4A7696);
  final Color accent = const Color(0xFFF0F4F8);
  final Color textColor = const Color(0xFF1E3A5F);

  // Poppins Font Styles
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

  Future<void> _checkEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      sh.setString("email", email.text);

      var res = await http.post(
        Uri.parse("${sh.getString("url")}/forgotemail"),
        body: {'email': email.text},
      );

      var decode = json.decode(res.body);

      if (decode["status"] == "ok") {
        sh.setString("otpp", decode['otpp'].toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OTP sent to your email!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => forgototp()));
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Email Not Found",
              style: poppinsSemiBold.copyWith(color: Colors.red),
            ),
            content: Text(
              "The email address you entered is not registered.",
              style: poppinsRegular.copyWith(color: textColor),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(foregroundColor: primary),
                child: Text("OK", style: poppinsSemiBold.copyWith(color: primary)),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Connection Error",
            style: poppinsSemiBold.copyWith(color: Colors.red),
          ),
          content: Text(
            "Please check your internet connection.",
            style: poppinsRegular.copyWith(color: textColor),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: primary),
              child: Text("OK", style: poppinsSemiBold.copyWith(color: primary)),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar matching HomePage exactly
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
              MaterialPageRoute(builder: (context) => LoginPage()),
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
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // Header Section with Badge - HomePage style
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Forgot Password?',
                                style: poppinsBold.copyWith(
                                  color: textColor,
                                  fontSize: 28,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Enter your email to receive OTP",
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
                              Icon(Icons.email_outlined, color: Colors.white, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                "Verify",
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

                  // Email Form Card - HomePage style card
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    border: Border.all(color: accent.withOpacity(0.8)),
                                  ),
                                  child: TextFormField(
                                    controller: email,
                                    keyboardType: TextInputType.emailAddress,
                                    style: poppinsMedium.copyWith(
                                      color: textColor,
                                      fontSize: 14,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email address';
                                      }
                                      if (!value.contains('@')) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter your registered email",
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
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Helper text
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'We will send a 6-digit OTP to this email',
                                style: poppinsRegular.copyWith(
                                  color: primaryLight,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Send OTP Button - HomePage style
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
                        onTap: _isLoading ? null : _checkEmail,
                        borderRadius: BorderRadius.circular(14),
                        child: Center(
                          child: _isLoading
                              ? SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                              : Text(
                            "SEND OTP",
                            style: poppinsSemiBold.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Info Card - HomePage style
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [primary.withOpacity(0.1), primaryLight.withOpacity(0.1)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.info_outline,
                              color: primary,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Check Spam Folder",
                                style: poppinsSemiBold.copyWith(
                                  color: textColor,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "If you don't receive the OTP, please check your spam folder",
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
          ),
        ),
      ),
    );
  }
}