// import 'package:medi_ai/login.dart';
// import 'forgotemail.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'forgototp.dart';
//
// void main() {
//   runApp(forgotpass());
// }
//
// class forgotpass extends StatelessWidget {
//   const forgotpass({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: forgotpasssub(),
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Roboto',
//       ),
//     );
//   }
// }
//
// class forgotpasssub extends StatefulWidget {
//   const forgotpasssub({Key? key}) : super(key: key);
//
//   @override
//   State<forgotpasssub> createState() => _forgotpasssubState();
// }
//
// class _forgotpasssubState extends State<forgotpasssub> {
//   TextEditingController password = TextEditingController();
//   TextEditingController confirmpassword = TextEditingController();
//
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//
//   Future<void> _resetPassword() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     if (password.text != confirmpassword.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Passwords do not match'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       await http.post(
//         Uri.parse("${sh.getString("url")}/forgotpass"),
//         body: {
//           'email': sh.getString('email'),
//           'password': password.text,
//           'confirmpassword': confirmpassword.text
//         },
//       );
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Password reset successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//
//       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to reset password. Please try again.'),
//           backgroundColor: Colors.red,
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
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(24),
//             child: Column(
//               children: [
//                 // Back Button
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => forgotemail()));
//                     },
//                   ),
//                 ),
//
//                 // Header Section
//                 Container(
//                   margin: EdgeInsets.only(top: 20, bottom: 40),
//                   child: Column(
//                     children: [
//                       Icon(
//                         Icons.lock_reset,
//                         size: 80,
//                         color: Color(0xFF1976D2),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         'Reset Password',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF1976D2),
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         "Create a new password for your account",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                           height: 1.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Password Reset Card
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(24),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'New Password',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey[800],
//                             ),
//                           ),
//                           SizedBox(height: 20),
//
//                           // Password Field
//                           TextFormField(
//                             controller: password,
//                             obscureText: _obscurePassword,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter a password';
//                               }
//                               if (value.length < 6) {
//                                 return 'Password must be at least 6 characters';
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                               labelText: "New Password",
//                               prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[600]),
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                                   color: Colors.grey[600],
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     _obscurePassword = !_obscurePassword;
//                                   });
//                                 },
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Colors.grey[400]!),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Colors.grey[400]!),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
//                               ),
//                               errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Colors.red),
//                               ),
//                               focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Colors.red, width: 2),
//                               ),
//                               contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                             ),
//                           ),
//
//                           SizedBox(height: 16),
//
//                           // Confirm Password Field
//                           TextFormField(
//                             controller: confirmpassword,
//                             obscureText: _obscureConfirmPassword,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please confirm your password';
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                               labelText: "Confirm New Password",
//                               prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[600]),
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
//                                   color: Colors.grey[600],
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     _obscureConfirmPassword = !_obscureConfirmPassword;
//                                   });
//                                 },
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Colors.grey[400]!),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Colors.grey[400]!),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
//                               ),
//                               errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Colors.red),
//                               ),
//                               focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Colors.red, width: 2),
//                               ),
//                               contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                             ),
//                           ),
//
//                           SizedBox(height: 8),
//
//                           // Password Requirements
//                           Container(
//                             padding: EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: Colors.blue[50],
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Password Requirements:',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.blue[800],
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   '• At least 6 characters long',
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     color: Colors.blue[700],
//                                   ),
//                                 ),
//                                 Text(
//                                   '• Make sure both passwords match',
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     color: Colors.blue[700],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 30),
//
//                 // Reset Password Button
//                 Container(
//                   width: double.infinity,
//                   height: 56,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _resetPassword,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF1976D2),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 2,
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
//                         : Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.lock_reset, size: 20, color: Colors.white),
//                         SizedBox(width: 8),
//                         Text(
//                           'RESET PASSWORD',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//
//                 // Security Info
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.green[50],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.security,
//                         color: Colors.green,
//                         size: 20,
//                       ),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Text(
//                           "Your password has been securely updated. You can now log in with your new password.",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.green[800],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }












import 'package:medi_ai/login.dart';
import 'forgotemail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'forgototp.dart';

void main() {
  runApp(forgotpass());
}

class forgotpass extends StatelessWidget {
  const forgotpass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: forgotpasssub(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class forgotpasssub extends StatefulWidget {
  const forgotpasssub({Key? key}) : super(key: key);

  @override
  State<forgotpasssub> createState() => _forgotpasssubState();
}

class _forgotpasssubState extends State<forgotpasssub> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (password.text != confirmpassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      await http.post(
        Uri.parse("${sh.getString("url")}/forgotpass"),
        body: {
          'email': sh.getString('email'),
          'password': password.text,
          'confirmpassword': confirmpassword.text
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to reset password. Please try again.'),
          backgroundColor: Colors.red,
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => forgotemail()));
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
                                'Reset Password',
                                style: poppinsBold.copyWith(
                                  color: textColor,
                                  fontSize: 28,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Create a new password for your account",
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
                              Icon(Icons.lock_reset, color: Colors.white, size: 16),
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

                  // Password Reset Card - HomePage style card
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
                            // Password Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.lock_outlined, color: primary, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      "New Password",
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
                                    controller: password,
                                    obscureText: _obscurePassword,
                                    style: poppinsMedium.copyWith(
                                      color: textColor,
                                      fontSize: 14,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a password';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter new password",
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
                                          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
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
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Confirm Password Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.lock_outline, color: primaryLight, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Confirm Password",
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
                                    controller: confirmpassword,
                                    obscureText: _obscureConfirmPassword,
                                    style: poppinsMedium.copyWith(
                                      color: textColor,
                                      fontSize: 14,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm your password';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Re-enter new password",
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
                                          _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                          color: primaryLight,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureConfirmPassword = !_obscureConfirmPassword;
                                          });
                                        },
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Password Requirements - Simple text list
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: accent.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: accent.withOpacity(0.8)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Password Requirements:',
                                    style: poppinsSemiBold.copyWith(
                                      color: textColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.circle, size: 6, color: primaryLight),
                                      const SizedBox(width: 8),
                                      Text(
                                        'At least 6 characters long',
                                        style: poppinsRegular.copyWith(
                                          color: primaryLight,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.circle, size: 6, color: primaryLight),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Make sure both passwords match',
                                        style: poppinsRegular.copyWith(
                                          color: primaryLight,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Reset Password Button - HomePage style
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
                        onTap: _isLoading ? null : _resetPassword,
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
                            "RESET PASSWORD",
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

                  // Security Info - HomePage style
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
                                "Password Updated Securely",
                                style: poppinsSemiBold.copyWith(
                                  color: textColor,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Your password has been encrypted. You can now log in with your new password.",
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

                  const SizedBox(height: 10),

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