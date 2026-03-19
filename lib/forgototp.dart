// import 'dart:convert';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'forgotemail.dart';
// import 'forgotpass.dart';
//
// void main() {
//   runApp(forgototp());
// }
//
// class forgototp extends StatelessWidget {
//   const forgototp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: forgototpsub(),
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Roboto',
//       ),
//     );
//   }
// }
//
// class forgototpsub extends StatefulWidget {
//   const forgototpsub({Key? key}) : super(key: key);
//
//   @override
//   State<forgototpsub> createState() => _forgototpsubState();
// }
//
// class _forgototpsubState extends State<forgototpsub> {
//   // List of 6 TextEditingController for each OTP digit
//   List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
//   List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
//
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   bool _isResending = false;
//   int _resendCooldown = 0;
//   int _otpExpirySeconds = 600; // 10 minutes = 600 seconds
//   Timer? _resendTimer;
//   Timer? _expiryTimer;
//   DateTime? _otpGeneratedTime;
//   bool _isOtpExpired = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadOtpGenerationTime();
//     _startResendCooldown();
//     _startOtpExpiryTimer();
//
//     // Set up focus listeners for auto-navigation
//     for (int i = 0; i < focusNodes.length; i++) {
//       focusNodes[i].addListener(() {
//         if (!focusNodes[i].hasFocus && i < 5 && otpControllers[i].text.isNotEmpty) {
//           FocusScope.of(context).requestFocus(focusNodes[i + 1]);
//         }
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _resendTimer?.cancel();
//     _expiryTimer?.cancel();
//     for (var controller in otpControllers) {
//       controller.dispose();
//     }
//     for (var focusNode in focusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }
//
//   // Get the complete OTP from all boxes
//   String getCompleteOTP() {
//     return otpControllers.map((controller) => controller.text).join();
//   }
//
//   // Clear all OTP boxes
//   void clearOTP() {
//     for (var controller in otpControllers) {
//       controller.clear();
//     }
//     FocusScope.of(context).requestFocus(focusNodes[0]);
//   }
//
//   // Handle text input for each OTP box
//   void _handleOTPInput(String value, int index) {
//     if (value.length == 1 && index < 5) {
//       // Move to next box
//       FocusScope.of(context).requestFocus(focusNodes[index + 1]);
//     } else if (value.isEmpty && index > 0) {
//       // Move to previous box on backspace
//       FocusScope.of(context).requestFocus(focusNodes[index - 1]);
//     }
//   }
//
//   Future<void> _loadOtpGenerationTime() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String? timestamp = sh.getString('otp_generated_time');
//       if (timestamp != null) {
//         _otpGeneratedTime = DateTime.parse(timestamp);
//         _updateOtpExpiryStatus();
//       }
//     } catch (e) {
//       print("Error loading OTP time: $e");
//     }
//   }
//
//   void _updateOtpExpiryStatus() {
//     if (_otpGeneratedTime != null) {
//       DateTime now = DateTime.now();
//       Duration difference = now.difference(_otpGeneratedTime!);
//       int remainingSeconds = 600 - difference.inSeconds;
//
//       remainingSeconds = remainingSeconds.clamp(0, 600);
//
//       setState(() {
//         _otpExpirySeconds = remainingSeconds;
//         _isOtpExpired = remainingSeconds <= 0;
//       });
//     }
//   }
//
//   void _startOtpExpiryTimer() {
//     _expiryTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_otpExpirySeconds > 0) {
//         setState(() {
//           _otpExpirySeconds--;
//           if (_otpExpirySeconds <= 0) {
//             _isOtpExpired = true;
//           }
//         });
//       } else {
//         setState(() {
//           _isOtpExpired = true;
//         });
//         timer.cancel();
//       }
//     });
//   }
//
//   void _startResendCooldown() {
//     setState(() {
//       _resendCooldown = 30;
//     });
//
//     _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_resendCooldown > 0) {
//         setState(() {
//           _resendCooldown--;
//         });
//       } else {
//         timer.cancel();
//       }
//     });
//   }
//
//   String _formatTime(int totalSeconds) {
//     if (totalSeconds.isNaN || totalSeconds < 0) {
//       return "00:00";
//     }
//
//     totalSeconds = totalSeconds.clamp(0, 600);
//
//     int minutes = totalSeconds ~/ 60;
//     int seconds = totalSeconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }
//
//   Future<void> _verifyOTP() async {
//     String otp = getCompleteOTP();
//
//     if (otp.length != 6) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text(
//             "Incomplete OTP",
//             style: TextStyle(
//               color: Colors.orange,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: Text(
//             "Please enter all 6 digits of the OTP.",
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[700],
//             ),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 FocusScope.of(context).requestFocus(focusNodes[0]);
//               },
//               child: Text(
//                 "OK",
//                 style: TextStyle(
//                   color: Color(0xFF1976D2),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//       return;
//     }
//
//     if (_isOtpExpired) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text(
//             "OTP Expired",
//             style: TextStyle(
//               color: Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: Text(
//             "This OTP has expired. Please request a new one.",
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[700],
//             ),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _resendOTP();
//               },
//               child: Text(
//                 "GET NEW OTP",
//                 style: TextStyle(
//                   color: Color(0xFF1976D2),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
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
//         Uri.parse("${sh.getString("ip")}/forgototp"),
//         body: {'otp': otp},
//       );
//
//       String? otpp = sh.getString('otpp');
//       if (otp == otpp) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('OTP verified successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         Navigator.push(context, MaterialPageRoute(builder: (context) => forgotpass()));
//       } else {
//         // Shake animation or clear OTP for wrong input
//         clearOTP();
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text(
//               "Invalid OTP",
//               style: TextStyle(
//                 color: Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             content: Text(
//               "The OTP you entered is incorrect. Please check and try again.",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[700],
//               ),
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   FocusScope.of(context).requestFocus(focusNodes[0]);
//                 },
//                 child: Text(
//                   "TRY AGAIN",
//                   style: TextStyle(
//                     color: Color(0xFF1976D2),
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
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
//             "Verification Failed",
//             style: TextStyle(
//               color: Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: Text(
//             "Unable to verify OTP. Please check your connection and try again.",
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[700],
//             ),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 "OK",
//                 style: TextStyle(
//                   color: Color(0xFF1976D2),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
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
//   Future<void> _resendOTP() async {
//     setState(() {
//       _isResending = true;
//     });
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String? email = sh.getString("email");
//
//       if (email != null) {
//         var res = await http.post(
//           Uri.parse("${sh.getString("ip")}/forgotemail"),
//           body: {'email': email},
//         );
//
//         var decode = json.decode(res.body);
//         if (decode["status"] == "ok") {
//           sh.setString("otpp", decode['otpp'].toString());
//           sh.setString("otp_generated_time", DateTime.now().toIso8601String());
//
//           setState(() {
//             _otpGeneratedTime = DateTime.now();
//             _isOtpExpired = false;
//             _otpExpirySeconds = 600;
//           });
//
//           _resendTimer?.cancel();
//           _expiryTimer?.cancel();
//           _startResendCooldown();
//           _startOtpExpiryTimer();
//
//           // Clear OTP boxes when new OTP is sent
//           clearOTP();
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('New OTP sent to your email!'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to resend OTP. Please try again.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() {
//         _isResending = false;
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
//                         Icons.verified_user,
//                         size: 80,
//                         color: Color(0xFF1976D2),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         'Enter OTP',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF1976D2),
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         "We've sent a 6-digit verification code to your email",
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
//                 // OTP Expiry Timer Widget
//                 if (_otpExpirySeconds >= 0)
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: _isOtpExpired ? Colors.red[50] : Colors.blue[50],
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: _isOtpExpired ? Colors.red[200]! : Colors.blue[200]!,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           _isOtpExpired ? Icons.warning : Icons.timer,
//                           color: _isOtpExpired ? Colors.red : Color(0xFF1976D2),
//                           size: 20,
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           _isOtpExpired
//                               ? 'OTP Expired!'
//                               : 'Expires in ${_formatTime(_otpExpirySeconds)}',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: _isOtpExpired ? Colors.red : Color(0xFF1976D2),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                 SizedBox(height: 20),
//
//                 // OTP Input Card with 6 boxes
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(24),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Verification Code',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.grey[800],
//                           ),
//                         ),
//                         SizedBox(height: 20),
//
//                         // OTP Boxes Row
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: List.generate(6, (index) {
//                               return Container(
//                                 width: 50,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: focusNodes[index].hasFocus
//                                         ? Color(0xFF1976D2)
//                                         : Colors.grey[400]!,
//                                     width: focusNodes[index].hasFocus ? 2 : 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                 ),
//                                 child: Center(
//                                   child: TextFormField(
//                                     controller: otpControllers[index],
//                                     focusNode: focusNodes[index],
//                                     keyboardType: TextInputType.number,
//                                     textAlign: TextAlign.center,
//                                     maxLength: 1,
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey[800],
//                                     ),
//                                     decoration: InputDecoration(
//                                       counterText: '',
//                                       border: InputBorder.none,
//                                       contentPadding: EdgeInsets.zero,
//                                     ),
//                                     onChanged: (value) {
//                                       _handleOTPInput(value, index);
//                                       setState(() {});
//                                     },
//                                   ),
//                                 ),
//                               );
//                             }),
//                           ),
//                         ),
//
//                         SizedBox(height: 20),
//
//                         // Clear OTP Button
//                         Container(
//                           width: double.infinity,
//                           child: OutlinedButton(
//                             onPressed: clearOTP,
//                             style: OutlinedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               side: BorderSide(color: Colors.grey[400]!),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.clear, size: 16, color: Colors.grey[600]),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   'CLEAR OTP',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//
//                         SizedBox(height: 8),
//                         Text(
//                           'Tap each box to enter the 6-digit code',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[500],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 30),
//
//                 // Verify Button
//                 Container(
//                   width: double.infinity,
//                   height: 56,
//                   child: ElevatedButton(
//                     onPressed: (_isLoading || _isOtpExpired) ? null : _verifyOTP,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: _isOtpExpired ? Colors.grey[400]! : Color(0xFF1976D2),
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
//                         Icon(Icons.verified, size: 20, color: Colors.white),
//                         SizedBox(width: 8),
//                         Text(
//                           _isOtpExpired ? 'OTP EXPIRED' : 'VERIFY OTP',
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
//                 // Resend OTP Section
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[50],
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey[300]!),
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Didn't receive the code?",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       _resendCooldown > 0
//                           ? Column(
//                         children: [
//                           Text(
//                             "Resend OTP in $_resendCooldown seconds",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.orange[700],
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           LinearProgressIndicator(
//                             value: _resendCooldown / 30,
//                             backgroundColor: Colors.grey[300],
//                             color: Colors.orange,
//                           ),
//                         ],
//                       )
//                           : Container(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _isResending ? null : _resendOTP,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             foregroundColor: Color(0xFF1976D2),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               side: BorderSide(color: Color(0xFF1976D2)),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: _isResending
//                               ? SizedBox(
//                             height: 16,
//                             width: 16,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1976D2)),
//                             ),
//                           )
//                               : Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.refresh, size: 16),
//                               SizedBox(width: 8),
//                               Text('RESEND OTP'),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//
//                 // Help Text
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.info_outline,
//                             color: Color(0xFF1976D2),
//                             size: 20,
//                           ),
//                           SizedBox(width: 8),
//                           Text(
//                             "OTP Information",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF1976D2),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         "• Each OTP is valid for 10 minutes only\n"
//                             "• Request a new OTP if it expires\n"
//                             "• Make sure to enter the code exactly as it appears\n"
//                             "• Use clear button to reset all boxes",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.blue[800],
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
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'forgotemail.dart';
import 'forgotpass.dart';

void main() {
  runApp(forgototp());
}

class forgototp extends StatelessWidget {
  const forgototp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: forgototpsub(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
    );
  }
}

class forgototpsub extends StatefulWidget {
  const forgototpsub({Key? key}) : super(key: key);

  @override
  State<forgototpsub> createState() => _forgototpsubState();
}

class _forgototpsubState extends State<forgototpsub> {
  // List of 6 TextEditingController for each OTP digit
  List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isResending = false;
  int _resendCooldown = 0;
  int _otpExpirySeconds = 600; // 10 minutes = 600 seconds
  Timer? _resendTimer;
  Timer? _expiryTimer;
  DateTime? _otpGeneratedTime;
  bool _isOtpExpired = false;

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

  @override
  void initState() {
    super.initState();
    _loadOtpGenerationTime();
    _startResendCooldown();
    _startOtpExpiryTimer();

    // Set up focus listeners for auto-navigation
    for (int i = 0; i < focusNodes.length; i++) {
      focusNodes[i].addListener(() {
        if (!focusNodes[i].hasFocus && i < 5 && otpControllers[i].text.isNotEmpty) {
          FocusScope.of(context).requestFocus(focusNodes[i + 1]);
        }
      });
    }
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _expiryTimer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Get the complete OTP from all boxes
  String getCompleteOTP() {
    return otpControllers.map((controller) => controller.text).join();
  }

  // Clear all OTP boxes
  void clearOTP() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    FocusScope.of(context).requestFocus(focusNodes[0]);
  }

  // Handle text input for each OTP box
  void _handleOTPInput(String value, int index) {
    if (value.length == 1 && index < 5) {
      // Move to next box
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      // Move to previous box on backspace
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  Future<void> _loadOtpGenerationTime() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? timestamp = sh.getString('otp_generated_time');
      if (timestamp != null) {
        _otpGeneratedTime = DateTime.parse(timestamp);
        _updateOtpExpiryStatus();
      }
    } catch (e) {
      print("Error loading OTP time: $e");
    }
  }

  void _updateOtpExpiryStatus() {
    if (_otpGeneratedTime != null) {
      DateTime now = DateTime.now();
      Duration difference = now.difference(_otpGeneratedTime!);
      int remainingSeconds = 600 - difference.inSeconds;

      remainingSeconds = remainingSeconds.clamp(0, 600);

      setState(() {
        _otpExpirySeconds = remainingSeconds;
        _isOtpExpired = remainingSeconds <= 0;
      });
    }
  }

  void _startOtpExpiryTimer() {
    _expiryTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_otpExpirySeconds > 0) {
        setState(() {
          _otpExpirySeconds--;
          if (_otpExpirySeconds <= 0) {
            _isOtpExpired = true;
          }
        });
      } else {
        setState(() {
          _isOtpExpired = true;
        });
        timer.cancel();
      }
    });
  }

  void _startResendCooldown() {
    setState(() {
      _resendCooldown = 30;
    });

    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendCooldown > 0) {
        setState(() {
          _resendCooldown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int totalSeconds) {
    if (totalSeconds.isNaN || totalSeconds < 0) {
      return "00:00";
    }

    totalSeconds = totalSeconds.clamp(0, 600);

    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _verifyOTP() async {
    String otp = getCompleteOTP();

    if (otp.length != 6) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Incomplete OTP",
            style: poppinsSemiBold.copyWith(color: Colors.orange),
          ),
          content: Text(
            "Please enter all 6 digits.",
            style: poppinsRegular.copyWith(color: textColor),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                FocusScope.of(context).requestFocus(focusNodes[0]);
              },
              style: TextButton.styleFrom(foregroundColor: primary),
              child: Text("OK", style: poppinsSemiBold.copyWith(color: primary)),
            ),
          ],
        ),
      );
      return;
    }

    if (_isOtpExpired) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "OTP Expired",
            style: poppinsSemiBold.copyWith(color: Colors.red),
          ),
          content: Text(
            "Please request a new one.",
            style: poppinsRegular.copyWith(color: textColor),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _resendOTP();
              },
              style: TextButton.styleFrom(foregroundColor: primary),
              child: Text("GET NEW OTP", style: poppinsSemiBold.copyWith(color: primary)),
            ),
          ],
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
        Uri.parse("${sh.getString("ip")}/forgototp"),
        body: {'otp': otp},
      );

      String? otpp = sh.getString('otpp');
      if (otp == otpp) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OTP verified successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => forgotpass()));
      } else {
        // Clear OTP for wrong input
        clearOTP();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Invalid OTP",
              style: poppinsSemiBold.copyWith(color: Colors.red),
            ),
            content: Text(
              "The code you entered is incorrect.",
              style: poppinsRegular.copyWith(color: textColor),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  FocusScope.of(context).requestFocus(focusNodes[0]);
                },
                style: TextButton.styleFrom(foregroundColor: primary),
                child: Text("TRY AGAIN", style: poppinsSemiBold.copyWith(color: primary)),
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
            "Verification Failed",
            style: poppinsSemiBold.copyWith(color: Colors.red),
          ),
          content: Text(
            "Please check your connection.",
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

  Future<void> _resendOTP() async {
    setState(() {
      _isResending = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? email = sh.getString("email");

      if (email != null) {
        var res = await http.post(
          Uri.parse("${sh.getString("ip")}/forgotemail"),
          body: {'email': email},
        );

        var decode = json.decode(res.body);
        if (decode["status"] == "ok") {
          sh.setString("otpp", decode['otpp'].toString());
          sh.setString("otp_generated_time", DateTime.now().toIso8601String());

          setState(() {
            _otpGeneratedTime = DateTime.now();
            _isOtpExpired = false;
            _otpExpirySeconds = 600;
          });

          _resendTimer?.cancel();
          _expiryTimer?.cancel();
          _startResendCooldown();
          _startOtpExpiryTimer();

          // Clear OTP boxes when new OTP is sent
          clearOTP();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('New OTP sent to your email!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to resend OTP.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } finally {
      setState(() {
        _isResending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
                    style: poppinsBold.copyWith(color: textColor, fontSize: 20),
                  ),
                  TextSpan(
                    text: 'AI',
                    style: poppinsBold.copyWith(color: primaryLight, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: primaryDark, size: 20),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => forgotemail()));
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Enter OTP',
                  style: poppinsBold.copyWith(fontSize: 28, color: textColor),
                ),
                SizedBox(height: 8),
                Text(
                  "6-digit code sent to your email",
                  style: poppinsRegular.copyWith(fontSize: 16, color: primaryLight),
                ),

                SizedBox(height: 20),

                // Expiry Timer
                if (_otpExpirySeconds >= 0)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: _isOtpExpired ? Colors.red.shade50 : accent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isOtpExpired ? Icons.timer_off : Icons.timer,
                          color: _isOtpExpired ? Colors.red : primary,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          _isOtpExpired ? 'OTP Expired' : 'Expires in ${_formatTime(_otpExpirySeconds)}',
                          style: poppinsSemiBold.copyWith(
                            color: _isOtpExpired ? Colors.red : primary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 30),

                // OTP Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    bool hasText = otpControllers[index].text.isNotEmpty;
                    return Container(
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: focusNodes[index].hasFocus
                              ? primary
                              : hasText
                              ? primaryLight
                              : accent,
                          width: focusNodes[index].hasFocus ? 2 : 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: focusNodes[index].hasFocus
                            ? primary.withOpacity(0.05)
                            : Colors.white,
                      ),
                      child: TextFormField(
                        controller: otpControllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: poppinsBold.copyWith(fontSize: 24, color: textColor),
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          _handleOTPInput(value, index);
                          setState(() {});
                        },
                      ),
                    );
                  }),
                ),

                SizedBox(height: 16),

                // Clear OTP
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Enter the 6-digit code',
                      style: poppinsRegular.copyWith(fontSize: 12, color: primaryLight),
                    ),
                    TextButton(
                      onPressed: clearOTP,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50, 30),
                      ),
                      child: Text(
                        'Clear',
                        style: poppinsMedium.copyWith(color: primaryLight),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // Verify Button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: _isOtpExpired
                        ? LinearGradient(colors: [Colors.grey, Colors.grey.shade400])
                        : LinearGradient(
                      colors: [primary, primaryLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _isOtpExpired ? null : [
                      BoxShadow(
                        color: primary.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: (_isLoading || _isOtpExpired) ? null : _verifyOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : Text(
                      _isOtpExpired ? 'EXPIRED' : 'VERIFY OTP',
                      style: poppinsSemiBold.copyWith(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Resend Section - Minimal
                Center(
                  child: _resendCooldown > 0
                      ? Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.hourglass_bottom, color: primary, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Resend in $_resendCooldown s',
                          style: poppinsMedium.copyWith(color: primary),
                        ),
                      ],
                    ),
                  )
                      : TextButton(
                    onPressed: _isResending ? null : _resendOTP,
                    style: TextButton.styleFrom(
                      foregroundColor: primary,
                    ),
                    child: _isResending
                        ? SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(primary),
                      ),
                    )
                        : Text(
                      'Resend OTP',
                      style: poppinsSemiBold.copyWith(color: primary),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Help Text - Minimal
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: primary, size: 18),
                          SizedBox(width: 8),
                          Text(
                            "OTP valid for 10 minutes",
                            style: poppinsSemiBold.copyWith(fontSize: 13, color: textColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "• Enter the 6-digit code sent to your email\n• Request new OTP if expired",
                        style: poppinsRegular.copyWith(fontSize: 12, color: textColor),
                      ),
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