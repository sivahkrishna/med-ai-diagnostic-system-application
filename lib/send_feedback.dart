// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medi_ai/homepage.dart';
// import 'package:medi_ai/ip.dart';
// import 'package:medi_ai/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SendFeedbackPage extends StatefulWidget {
//   const SendFeedbackPage({super.key});
//
//   @override
//   State<SendFeedbackPage> createState() => _SendFeedbackPageState();
// }
//
// class _SendFeedbackPageState extends State<SendFeedbackPage> {
//   final TextEditingController _feedbackController = TextEditingController();
//
//   bool _isLoading = false;
//
//   // Validation flags
//   bool _hasMinLength = false;
//
//   String? _hid;
//
//   getdata() async {
//     SharedPreferences sh=await SharedPreferences.getInstance();
//     _hid=sh.getString("hid");;
//   }
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
//   @override
//   void initState() {
//     super.initState();
//     getdata();
//   }
//
//   void _validatePassword(String password) {
//     setState(() {
//       _hasMinLength = password.length >= 6;
//     });
//   }
//
//   Future<void> _changePassword() async {
//     if (_hid == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'User data not found. Please login again.',
//             style: poppinsMedium.copyWith(color: Colors.white),
//           ),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//       return;
//     }
//
//     // Validate inputs
//     if (_feedbackController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Feedback cannot be null',
//             style: poppinsMedium.copyWith(color: Colors.white),
//           ),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//       return;
//     }
//
//     if (_feedbackController.text.length < 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Feedback must be at least 6 characters',
//             style: poppinsMedium.copyWith(color: Colors.white),
//           ),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//       return;
//     }
//
//     setState(() => _isLoading = true);
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String? url = sh.getString("url");
//
//       final response = await http.post(
//         Uri.parse("$url/hospital_send_feedback"),
//         body: {
//           'hid': _hid!,
//           'feed': _feedbackController.text,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         if (response.body.contains('"status":"ok"') || response.body.contains('success')) {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                   'Feedback sent successfully',
//                   style: poppinsMedium.copyWith(color: Colors.white),
//                 ),
//                 backgroundColor: Colors.green,
//                 behavior: SnackBarBehavior.floating,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             );
//             Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//           }
//         } else {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                   'Feedback sent successfully',
//                   style: poppinsMedium.copyWith(color: Colors.white),
//                 ),
//                 backgroundColor: Colors.green,
//                 behavior: SnackBarBehavior.floating,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             );
//             Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//           }
//         }
//       } else {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'Server error: ${response.statusCode}',
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
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Error: ${e.toString()}',
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
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // AppBar matching HomePage style
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Container(
//               width: 36,
//               height: 36,
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
//                     return Container(
//                       color: Colors.white.withOpacity(0.2),
//                       child: Icon(
//                         Icons.medical_services,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: 'MEDI ',
//                     style: poppinsBold.copyWith(
//                       color: Colors.white,
//                       fontSize: 20,
//                     ),
//                   ),
//                   TextSpan(
//                     text: 'AI',
//                     style: poppinsBold.copyWith(
//                       color: Colors.white.withOpacity(0.9),
//                       fontSize: 20,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: primary,
//         elevation: 2,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//
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
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 10),
//
//                   // Header Section - Similar to HomePage
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Send Feedback",
//                           style: poppinsBold.copyWith(
//                             color: textColor,
//                             fontSize: 28,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           "Share your experience with us",
//                           style: poppinsMedium.copyWith(
//                             color: primaryLight,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Current Password Card - Matching HomePage card style
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: accent.withOpacity(0.8)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.03),
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: primary.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Icon(
//                                   Icons.comment,
//                                   color: primary,
//                                   size: 18,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 "Your feedback",
//                                 style: poppinsSemiBold.copyWith(
//                                   color: textColor,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           _buildPasswordField(
//                             controller: _feedbackController,
//                             hint: "Enter your feedback",
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   // Change Password Button - Matching HomePage button style
//                   Container(
//                     width: double.infinity,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [primary, primaryLight],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: primary.withOpacity(0.3),
//                           blurRadius: 15,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: _isLoading ? null : _changePassword,
//                         borderRadius: BorderRadius.circular(16),
//                         child: Center(
//                           child: _isLoading
//                               ? SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2.5,
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                   Colors.white),
//                             ),
//                           )
//                               : Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.lock_reset_outlined,
//                                 color: Colors.white,
//                                 size: 20,
//                               ),
//                               const SizedBox(width: 10),
//                               Text(
//                                 "SEND FEEDBACK",
//                                 style: poppinsSemiBold.copyWith(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 30),
//
//                   // Security Info - Similar to HomePage bottom info
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: accent.withOpacity(0.8)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.02),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: primary.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Center(
//                             child: Icon(
//                               Icons.security_outlined,
//                               color: primary,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Secure Password Update",
//                                 style: poppinsSemiBold.copyWith(
//                                   color: textColor,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 "Your password is encrypted and securely transmitted",
//                                 style: poppinsRegular.copyWith(
//                                   color: primaryLight,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRequirementTile(String text, bool isMet) {
//     return Row(
//       children: [
//         Icon(
//           isMet ? Icons.check_circle : Icons.circle_outlined,
//           color: isMet ? Colors.green : primaryLight.withOpacity(0.5),
//           size: 16,
//         ),
//         const SizedBox(width: 8),
//         Text(
//           text,
//           style: poppinsRegular.copyWith(
//             color: isMet ? Colors.green : primaryLight.withOpacity(0.7),
//             fontSize: 12,
//             decoration: isMet ? TextDecoration.lineThrough : null,
//             decorationColor: Colors.green,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPasswordField({
//     required TextEditingController controller,
//     required String hint,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: accent.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: accent.withOpacity(0.5)),
//       ),
//       child: TextField(
//         controller: controller,
//         style: poppinsMedium.copyWith(
//           color: textColor,
//           fontSize: 14,
//         ),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: poppinsRegular.copyWith(
//             color: primaryLight.withOpacity(0.5),
//             fontSize: 14,
//           ),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 16,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _feedbackController.dispose();
//     super.dispose();
//   }
// }
//
//





import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medi_ai/homepage.dart';
import 'package:medi_ai/ip.dart';
import 'package:medi_ai/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key});

  @override
  State<SendFeedbackPage> createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();

  bool _isLoading = false;

  // Validation flags
  bool _hasMinLength = false;

  String? _hid;

  getdata() async {
    SharedPreferences sh=await SharedPreferences.getInstance();
    _hid=sh.getString("hid");;
  }

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

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void _validateFeedback(String feedback) {
    setState(() {
      _hasMinLength = feedback.length >= 6;
    });
  }

  Future<void> _sendFeedback() async {
    if (_hid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'User data not found. Please login again.',
            style: poppinsMedium.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    // Validate inputs
    if (_feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Feedback cannot be empty',
            style: poppinsMedium.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    if (_feedbackController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Feedback must be at least 6 characters',
            style: poppinsMedium.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? url = sh.getString("url");

      final response = await http.post(
        Uri.parse("$url/hospital_send_feedback"),
        body: {
          'hid': _hid!,
          'feed': _feedbackController.text,
        },
      );

      if (response.statusCode == 200) {
        if (response.body.contains('"status":"ok"') || response.body.contains('success')) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Feedback sent successfully',
                  style: poppinsMedium.copyWith(color: Colors.white),
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Feedback sent successfully',
                  style: poppinsMedium.copyWith(color: Colors.white),
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Server error: ${response.statusCode}',
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${e.toString()}',
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
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
          icon: Icon(Icons.arrow_back, color: primaryDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // Body with HomePage background gradient
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Simple Header - Matching HomePage style
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Send Feedback",
                                style: poppinsBold.copyWith(
                                  color: textColor,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Share your experience with us",
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
                              Icon(Icons.feedback, color: Colors.white, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                "Feedback",
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

                  // Feedback Form Card - Designed to match HomePage service cards
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
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
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Header with icon
                          Row(
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
                                    Icons.chat_bubble_outline,
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
                                      "Your Feedback Matters",
                                      style: poppinsSemiBold.copyWith(
                                        color: textColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Help us improve your experience",
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

                          const SizedBox(height: 20),

                          // Feedback Input Field
                          Container(
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: accent.withOpacity(0.8)),
                            ),
                            child: TextField(
                              controller: _feedbackController,
                              maxLines: 5,
                              style: poppinsMedium.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                              onChanged: _validateFeedback,
                              decoration: InputDecoration(
                                hintText: "Type your feedback here...",
                                hintStyle: poppinsRegular.copyWith(
                                  color: primaryLight.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(16),
                              ),
                            ),
                          ),

                          // Character count and validation
                          if (_feedbackController.text.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                children: [
                                  Icon(
                                    _hasMinLength ? Icons.check_circle : Icons.info_outline,
                                    color: _hasMinLength ? Colors.green : primaryLight,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _hasMinLength
                                          ? "Feedback length is good (${_feedbackController.text.length} characters)"
                                          : "Minimum 6 characters required (${_feedbackController.text.length}/6)",
                                      style: poppinsRegular.copyWith(
                                        color: _hasMinLength ? Colors.green : primaryLight,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Send Feedback Button - Matching HomePage button style
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
                        onTap: _isLoading ? null : _sendFeedback,
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
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.send_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "SEND FEEDBACK",
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

                  const SizedBox(height: 20),

                  // Quick Feedback Tips - Compact info section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: accent.withOpacity(0.8)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb_outline, color: primary, size: 18),
                            const SizedBox(width: 10),
                            Text(
                              "Feedback Tips",
                              style: poppinsSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTipChip("Be specific", Icons.edit_outlined),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildTipChip("Be constructive", Icons.thumb_up_outlined),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTipChip("Include details", Icons.details_outlined),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildTipChip("Suggest improvements", Icons.trending_up_outlined),
                            ),
                          ],
                        ),
                      ],
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

  // Tip chip widget
  Widget _buildTipChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withOpacity(0.8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: primary, size: 12),
          const SizedBox(width: 4),
          Text(
            text,
            style: poppinsRegular.copyWith(
              color: textColor,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}