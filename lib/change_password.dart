// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medi_ai/ip.dart';
// import 'package:medi_ai/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ChangePasswordPage extends StatefulWidget {
//   const ChangePasswordPage({super.key});
//
//   @override
//   State<ChangePasswordPage> createState() => _ChangePasswordPageState();
// }
//
// class _ChangePasswordPageState extends State<ChangePasswordPage> {
//   final TextEditingController _currentPasswordController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   bool _isLoading = false;
//   bool _obscureCurrent = true;
//   bool _obscureNew = true;
//   bool _obscureConfirm = true;
//
//   // Validation flags
//   bool _hasLowercase = false;
//   bool _hasUppercase = false;
//   bool _hasNumber = false;
//   bool _hasMinLength = false;
//
//   String? _hid;
//   String? _storedPassword;
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
//     _loadUserData();
//   }
//
//   Future<void> _loadUserData() async {
//     final sh = await SharedPreferences.getInstance();
//     setState(() {
//       _hid = sh.getString('hid');
//       _storedPassword = sh.getString('password');
//     });
//   }
//
//   void _validatePassword(String password) {
//     setState(() {
//       _hasLowercase = password.contains(RegExp(r'[a-z]'));
//       _hasUppercase = password.contains(RegExp(r'[A-Z]'));
//       _hasNumber = password.contains(RegExp(r'[0-9]'));
//       _hasMinLength = password.length >= 6;
//     });
//   }
//
//   Future<void> _changePassword() async {
//     if (_hid == null || _storedPassword == null) {
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
//     if (_currentPasswordController.text.isEmpty ||
//         _newPasswordController.text.isEmpty ||
//         _confirmPasswordController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'All fields are required',
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
//     if (_currentPasswordController.text != _storedPassword) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Current password is incorrect',
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
//     if (_newPasswordController.text != _confirmPasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'New passwords do not match',
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
//     if (_newPasswordController.text.length < 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Password must be at least 6 characters',
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
//     if (_newPasswordController.text == _currentPasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'New password should not match current password',
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
//         Uri.parse("$url/change_password_hospital"),
//         body: {
//           'hid': _hid!,
//           'password': _storedPassword!,
//           'current': _currentPasswordController.text,
//           'neww': _newPasswordController.text,
//           'confirm': _confirmPasswordController.text,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         if (response.body.contains('"status":"ok"') || response.body.contains('success')) {
//           final sh = await SharedPreferences.getInstance();
//           await sh.setString('password', _newPasswordController.text);
//
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                   'Password changed successfully',
//                   style: poppinsMedium.copyWith(color: Colors.white),
//                 ),
//                 backgroundColor: Colors.green,
//                 behavior: SnackBarBehavior.floating,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             );
//             Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
//           }
//         } else {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                   'Password changed successfully',
//                   style: poppinsMedium.copyWith(color: Colors.white),
//                 ),
//                 backgroundColor: Colors.green,
//                 behavior: SnackBarBehavior.floating,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             );
//             Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
//                           "Change Password",
//                           style: poppinsBold.copyWith(
//                             color: textColor,
//                             fontSize: 28,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           "Update your account password",
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
//                                   Icons.lock_outlined,
//                                   color: primary,
//                                   size: 18,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 "Current Password",
//                                 style: poppinsSemiBold.copyWith(
//                                   color: textColor,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           _buildPasswordField(
//                             controller: _currentPasswordController,
//                             hint: "Enter your current password",
//                             obscure: _obscureCurrent,
//                             onToggle: () => setState(() => _obscureCurrent = !_obscureCurrent),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   // New Password Card - Matching HomePage card style
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
//                                   color: primaryLight.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Icon(
//                                   Icons.lock_reset_outlined,
//                                   color: primaryLight,
//                                   size: 18,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 "New Password",
//                                 style: poppinsSemiBold.copyWith(
//                                   color: textColor,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           _buildPasswordField(
//                             controller: _newPasswordController,
//                             hint: "Enter new password",
//                             obscure: _obscureNew,
//                             onToggle: () => setState(() => _obscureNew = !_obscureNew),
//                             onChanged: _validatePassword,
//                           ),
//
//                           // Password strength indicator
//                           const SizedBox(height: 16),
//                           Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: accent.withOpacity(0.5),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               children: [
//                                 _buildRequirementTile(
//                                   "At least 6 characters",
//                                   _hasMinLength,
//                                 ),
//                                 const SizedBox(height: 8),
//                                 _buildRequirementTile(
//                                   "Contains lowercase letter",
//                                   _hasLowercase,
//                                 ),
//                                 const SizedBox(height: 8),
//                                 _buildRequirementTile(
//                                   "Contains uppercase letter",
//                                   _hasUppercase,
//                                 ),
//                                 const SizedBox(height: 8),
//                                 _buildRequirementTile(
//                                   "Contains number",
//                                   _hasNumber,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   // Confirm Password Card - Matching HomePage card style
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 30),
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
//                                   color: primaryDark.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Icon(
//                                   Icons.lock_outline,
//                                   color: primaryDark,
//                                   size: 18,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 "Confirm New Password",
//                                 style: poppinsSemiBold.copyWith(
//                                   color: textColor,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           _buildPasswordField(
//                             controller: _confirmPasswordController,
//                             hint: "Re-enter new password",
//                             obscure: _obscureConfirm,
//                             onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
//                           ),
//
//                           // Match indicator
//                           if (_confirmPasswordController.text.isNotEmpty)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 12),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     _newPasswordController.text == _confirmPasswordController.text
//                                         ? Icons.check_circle_outline
//                                         : Icons.error_outline,
//                                     color: _newPasswordController.text == _confirmPasswordController.text
//                                         ? Colors.green
//                                         : Colors.red,
//                                     size: 16,
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     _newPasswordController.text == _confirmPasswordController.text
//                                         ? "Passwords match"
//                                         : "Passwords do not match",
//                                     style: poppinsRegular.copyWith(
//                                       color: _newPasswordController.text == _confirmPasswordController.text
//                                           ? Colors.green
//                                           : Colors.red,
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
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
//                                 "UPDATE PASSWORD",
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
//     required bool obscure,
//     required VoidCallback onToggle,
//     Function(String)? onChanged,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: accent.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: accent.withOpacity(0.5)),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscure,
//         style: poppinsMedium.copyWith(
//           color: textColor,
//           fontSize: 14,
//         ),
//         onChanged: onChanged,
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
//           suffixIcon: IconButton(
//             icon: Icon(
//               obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
//               color: primary,
//               size: 20,
//             ),
//             onPressed: onToggle,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _currentPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medi_ai/ip.dart';
import 'package:medi_ai/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  // Validation flags
  bool _hasLowercase = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasMinLength = false;

  String? _hid;
  String? _storedPassword;

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
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final sh = await SharedPreferences.getInstance();
    setState(() {
      _hid = sh.getString('hid');
      _storedPassword = sh.getString('password');
    });
  }

  void _validatePassword(String password) {
    setState(() {
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasMinLength = password.length >= 6;
    });
  }

  Future<void> _changePassword() async {
    if (_hid == null || _storedPassword == null) {
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
    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'All fields are required',
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

    if (_currentPasswordController.text != _storedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Current password is incorrect',
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

    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'New passwords do not match',
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

    if (_newPasswordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password must be at least 6 characters',
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

    if (_newPasswordController.text == _currentPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'New password should not match current password',
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
        Uri.parse("$url/change_password_hospital"),
        body: {
          'hid': _hid!,
          'password': _storedPassword!,
          'current': _currentPasswordController.text,
          'neww': _newPasswordController.text,
          'confirm': _confirmPasswordController.text,
        },
      );

      if (response.statusCode == 200) {
        if (response.body.contains('"status":"ok"') || response.body.contains('success')) {
          final sh = await SharedPreferences.getInstance();
          await sh.setString('password', _newPasswordController.text);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Password changed successfully',
                  style: poppinsMedium.copyWith(color: Colors.white),
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Password changed successfully',
                  style: poppinsMedium.copyWith(color: Colors.white),
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Change Password",
                          style: poppinsBold.copyWith(
                            color: textColor,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Update your account password securely",
                          style: poppinsMedium.copyWith(
                            color: primaryLight,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Compact Password Change Form
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: accent.withOpacity(0.8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Current Password
                          _buildLabel("Current Password", Icons.lock_outline, primary),
                          const SizedBox(height: 8),
                          _buildPasswordField(
                            controller: _currentPasswordController,
                            hint: "Enter current password",
                            obscure: _obscureCurrent,
                            onToggle: () => setState(() => _obscureCurrent = !_obscureCurrent),
                          ),

                          const SizedBox(height: 16),

                          // New Password
                          _buildLabel("New Password", Icons.lock_reset_outlined, primaryLight),
                          const SizedBox(height: 8),
                          _buildPasswordField(
                            controller: _newPasswordController,
                            hint: "Enter new password",
                            obscure: _obscureNew,
                            onToggle: () => setState(() => _obscureNew = !_obscureNew),
                            onChanged: _validatePassword,
                          ),

                          // Compact Password Requirements - Shows as chips when typing
                          if (_newPasswordController.text.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: accent.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: accent.withOpacity(0.8)),
                              ),
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _buildRequirementChip("6+ chars", _hasMinLength),
                                  _buildRequirementChip("a-z", _hasLowercase),
                                  _buildRequirementChip("A-Z", _hasUppercase),
                                  _buildRequirementChip("0-9", _hasNumber),
                                ],
                              ),
                            ),
                          ],

                          const SizedBox(height: 16),

                          // Confirm Password
                          _buildLabel("Confirm Password", Icons.lock_outline, primaryDark),
                          const SizedBox(height: 8),
                          _buildPasswordField(
                            controller: _confirmPasswordController,
                            hint: "Re-enter new password",
                            obscure: _obscureConfirm,
                            onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
                          ),

                          // Simple Match Indicator
                          if (_confirmPasswordController.text.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    _newPasswordController.text == _confirmPasswordController.text
                                        ? Icons.check_circle
                                        : Icons.error,
                                    color: _newPasswordController.text == _confirmPasswordController.text
                                        ? Colors.green
                                        : Colors.red,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    _newPasswordController.text == _confirmPasswordController.text
                                        ? "Passwords match"
                                        : "Passwords don't match",
                                    style: poppinsRegular.copyWith(
                                      color: _newPasswordController.text == _confirmPasswordController.text
                                          ? Colors.green
                                          : Colors.red,
                                      fontSize: 12,
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

                  // Update Button - Matching HomePage button style
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
                        onTap: _isLoading ? null : _changePassword,
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
                            "UPDATE PASSWORD",
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

                  // Simple Security Note - Compact version
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: accent.withOpacity(0.8)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shield_outlined, color: primary, size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Your password is encrypted and securely transmitted",
                            style: poppinsRegular.copyWith(
                              color: primaryLight,
                              fontSize: 12,
                            ),
                          ),
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

  // Simple label widget
  Widget _buildLabel(String text, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Text(
          text,
          style: poppinsSemiBold.copyWith(
            color: textColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // Compact requirement chip
  Widget _buildRequirementChip(String text, bool isMet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isMet ? Colors.green.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isMet ? Colors.green.withOpacity(0.3) : primaryLight.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            color: isMet ? Colors.green : primaryLight.withOpacity(0.5),
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: poppinsRegular.copyWith(
              color: isMet ? Colors.green : primaryLight.withOpacity(0.7),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
    Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: accent.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.8)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: poppinsMedium.copyWith(
          color: textColor,
          fontSize: 14,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: poppinsRegular.copyWith(
            color: primaryLight.withOpacity(0.5),
            fontSize: 13,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: primary,
              size: 18,
            ),
            onPressed: onToggle,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}