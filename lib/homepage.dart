//
//
// import 'package:flutter/material.dart';
// import 'package:medi_ai/send_feedback.dart';
// import 'package:medi_ai/view_feedback.dart';
// import 'package:medi_ai/view_notify.dart';
// import 'package:medi_ai/view_profile.dart';
// import 'package:medi_ai/view_results.dart';
// import 'package:medi_ai/check_alzheimers.dart';
// import 'package:medi_ai/check_bone_fracture.dart';
// import 'package:medi_ai/check_lung_cancer.dart';
// import 'package:medi_ai/change_password.dart';
//
// import 'login.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   // Color palette adjusted for better contrast
//   final Color primaryDark = const Color(0xFF1B3C53);
//   final Color primary = const Color(0xFF2A5170); // Adjusted for better visibility
//   final Color primaryLight = const Color(0xFF4A7696); // Adjusted for better contrast
//   final Color accent = const Color(0xFFF0F4F8); // Lighter accent color
//   final Color textColor = const Color(0xFF1E3A5F); // Darker text color
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // -------------------------
//       // AppBar with medical theme AND CUSTOM LOGO
//       // -------------------------
//       appBar: AppBar(
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
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: 'MEDI ',
//                     style: poppinsBold.copyWith(
//                       color: textColor,
//                       fontSize: 20,
//                     ),
//                   ),
//                   TextSpan(
//                     text: 'AI',
//                     style: poppinsBold.copyWith(
//                       color: primaryLight,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.white,
//         elevation: 2,
//         iconTheme: IconThemeData(color: primaryDark),
//       ),
//
//       // -------------------------
//       // Navigation Drawer with medical theme AND CUSTOM LOGO
//       // -------------------------
//       drawer: Drawer(
//         child: Container(
//           color: Colors.white,
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               // Drawer Header - Clean and professional WITH LOGO
//               Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [primaryLight, primary],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // CUSTOM LOGO IN DRAWER HEADER
//                     Container(
//                       width: 80,
//                       height: 80,
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(40),
//                         border: Border.all(color: Colors.white, width: 3),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(28),
//                         child: Image.asset(
//                           'assets/logo.png',
//                           fit: BoxFit.contain,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Center(
//                               child: Icon(
//                                 Icons.person,
//                                 size: 40,
//                                 color: primary,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       "User Dashboard",
//                       style: poppinsBold.copyWith(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "user@example.com",
//                       style: poppinsRegular.copyWith(
//                         color: Colors.white.withOpacity(0.9),
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Drawer Menu Items
//               _buildDrawerItem(
//                 context: context,
//                 icon: Icons.person_outline,
//                 title: "View Profile",
//                 color: primary,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => hosp_view_profile()),
//                   );
//                 },
//               ),
//
//               _buildDrawerItem(
//                 context: context,
//                 icon: Icons.feedback_outlined,
//                 title: "Send Feedback",
//                 color: primary,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SendFeedbackPage()),
//                   );
//                 },
//               ),
//
//               _buildDrawerItem(
//                 context: context,
//                 icon: Icons.feedback_outlined,
//                 title: "View Feedback",
//                 color: primary,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => view_feedback()),
//                   );
//                 },
//               ),
//
//               _buildDrawerItem(
//                 context: context,
//                 icon: Icons.notifications_outlined,
//                 title: "View Notification",
//                 color: primary,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => hosp_view_notify()),
//                   );
//                 },
//               ),
//
//               const Divider(height: 20, color: Color(0xFFE3E3E3)),
//
//               // Medical AI Detection Section
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Text(
//                   "AI DETECTION SERVICES",
//                   style: poppinsSemiBold.copyWith(
//                     color: primaryDark.withOpacity(0.7),
//                     fontSize: 12,
//                     letterSpacing: 1,
//                   ),
//                 ),
//               ),
//
//               _buildDrawerItem(
//                 context: context,
//                 icon: Icons.health_and_safety_outlined,
//                 title: "Alzheimer's Detection",
//                 color: primary,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => check_alzheimers()),
//                   );
//                 },
//               ),
//
//               _buildDrawerItem(
//                 context: context,
//                 icon: Icons.broken_image_outlined,
//                 title: "Bone Fracture Detection",
//                 color: primary,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => check_bone_fracture()),
//                   );
//                 },
//               ),
//
//               _buildDrawerItem(
//                 context: context,
//                 icon: Icons.air_outlined,
//                 title: "Lung Cancer Detection",
//                 color: primary,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => check_lung_cancer()),
//                   );
//                 },
//               ),
//
//               _buildDrawerItem(
//                 context: context,
//                 icon: Icons.history_outlined,
//                 title: "Previous Results",
//                 color: primary,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => view_results()),
//                   );
//                 },
//               ),
//
//               const Divider(height: 20, color: Color(0xFFE3E3E3)),
//
//               _buildDrawerItem(
//                 context: context,
//                 icon: Icons.lock_outline,
//                 title: "Change Password",
//                 color: primary,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
//                   );
//                   // Navigate to change password page
//                 },
//               ),
//
//               // Logout
//               Container(
//                 margin: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.red.withOpacity(0.2)),
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.red.withOpacity(0.1),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: ListTile(
//                   leading: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.red.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Center(
//                       child: Icon(Icons.logout, color: Colors.red, size: 20),
//                     ),
//                   ),
//                   title: Text(
//                     "Logout",
//                     style: poppinsSemiBold.copyWith(
//                       color: Colors.red,
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                     );
//                   },
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//
//       // -------------------------
//       // Main Body Content - Clean and minimal with single scroll
//       // -------------------------
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 accent,
//                 Colors.white,
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Column(
//             children: [
//               // Header Section - Simplified
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.white, accent.withOpacity(0.5)],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                   border: Border(
//                     bottom: BorderSide(color: accent.withOpacity(0.8)),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "AI-Powered Medical Diagnostics",
//                             style: poppinsBold.copyWith(
//                               color: textColor,
//                               fontSize: 22,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Advanced diagnostic tools for medical professionals",
//                             style: poppinsMedium.copyWith(
//                               color: primaryLight,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [primary, primaryLight],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: primary.withOpacity(0.3),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.medical_services, color: Colors.white, size: 16),
//                           const SizedBox(width: 6),
//                           Text(
//                             "Professional",
//                             style: poppinsSemiBold.copyWith(
//                               color: Colors.white,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Main Content Area - Everything in single column
//               Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Quick Stats Section
//                     Container(
//                       margin: const EdgeInsets.only(bottom: 24),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: _buildStatCard(
//                               title: "Today",
//                               value: "12",
//                               subtitle: "Diagnoses",
//                               color: primary,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: _buildStatCard(
//                               title: "Accuracy",
//                               value: "98.5%",
//                               subtitle: "Average",
//                               color: primaryLight,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // Services Section Title
//                     Text(
//                       "Medical AI Tools",
//                       style: poppinsBold.copyWith(
//                         color: textColor,
//                         fontSize: 20,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "Select a diagnostic tool to begin",
//                       style: poppinsMedium.copyWith(
//                         color: primaryLight,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Services Grid - Now part of the main scroll
//                     GridView.count(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                       childAspectRatio: 1.2,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       children: [
//                         _buildServiceCard(
//                           icon: Icons.health_and_safety_outlined,
//                           title: "Alzheimer's",
//                           subtitle: "Brain analysis",
//                           color: primary,
//                           gradient: LinearGradient(
//                             colors: [primary.withOpacity(0.1), primary.withOpacity(0.2)],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => check_alzheimers()),
//                             );
//                           },
//                         ),
//                         _buildServiceCard(
//                           icon: Icons.broken_image_outlined,
//                           title: "Bone Fracture",
//                           subtitle: "X-ray analysis",
//                           color: primaryLight,
//                           gradient: LinearGradient(
//                             colors: [primaryLight.withOpacity(0.1), primaryLight.withOpacity(0.2)],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => check_bone_fracture()),
//                             );
//                           },
//                         ),
//                         _buildServiceCard(
//                           icon: Icons.air_outlined,
//                           title: "Lung Cancer",
//                           subtitle: "CT scan analysis",
//                           color: primaryDark,
//                           gradient: LinearGradient(
//                             colors: [primaryDark.withOpacity(0.1), primaryDark.withOpacity(0.2)],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => check_lung_cancer()),
//                             );
//                           },
//                         ),
//                         _buildServiceCard(
//                           icon: Icons.history_outlined,
//                           title: "Results",
//                           subtitle: "View history",
//                           color: primary,
//                           gradient: LinearGradient(
//                             colors: [primary.withOpacity(0.1), primary.withOpacity(0.2)],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => view_results()),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//
//                     // Additional spacing at bottom
//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//
//               // Bottom Info Bar
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border(
//                     top: BorderSide(color: accent.withOpacity(0.8)),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, -2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.security, color: primary, size: 14),
//                             const SizedBox(width: 6),
//                             Text(
//                               "HIPAA Compliant",
//                               style: poppinsSemiBold.copyWith(
//                                 color: textColor,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           "Data encrypted and secure",
//                           style: poppinsRegular.copyWith(
//                             color: primaryLight,
//                             fontSize: 11,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [accent, Colors.white],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: primary.withOpacity(0.2)),
//                       ),
//                       child: Text(
//                         "v2.1.0",
//                         style: poppinsSemiBold.copyWith(
//                           color: primaryLight,
//                           fontSize: 11,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Helper method for drawer items
//   Widget _buildDrawerItem({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: ListTile(
//         leading: Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.08),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Center(
//             child: Icon(icon, color: color, size: 20),
//           ),
//         ),
//         title: Text(
//           title,
//           style: poppinsMedium.copyWith(
//             color: textColor,
//           ),
//         ),
//         trailing: Icon(
//           Icons.chevron_right,
//           color: primaryLight,
//           size: 20,
//         ),
//         onTap: onTap,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }
//
//   // Helper method for service cards
//   Widget _buildServiceCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required Gradient gradient,
//     required VoidCallback onTap,
//   }) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: color.withOpacity(0.1)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 15,
//                 offset: const Offset(0, 6),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     gradient: gradient,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Center(
//                     child: Icon(icon, color: color, size: 24),
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: poppinsSemiBold.copyWith(
//                         color: textColor,
//                         fontSize: 16,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       subtitle,
//                       style: poppinsRegular.copyWith(
//                         color: primaryLight,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Container(
//                     width: 24,
//                     height: 24,
//                     decoration: BoxDecoration(
//                       color: color.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Icon(
//                       Icons.arrow_forward_ios,
//                       color: color,
//                       size: 12,
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
//   // Helper method for stat cards
//   Widget _buildStatCard({
//     required String title,
//     required String value,
//     required String subtitle,
//     required Color color,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: color.withOpacity(0.1)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: poppinsSemiBold.copyWith(
//               color: color,
//               fontSize: 12,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: poppinsBold.copyWith(
//               color: textColor,
//               fontSize: 24,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             subtitle,
//             style: poppinsRegular.copyWith(
//               color: primaryLight,
//               fontSize: 11,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:medi_ai/send_feedback.dart';
import 'package:medi_ai/view_feedback.dart';
import 'package:medi_ai/view_notify.dart';
import 'package:medi_ai/view_profile.dart';
import 'package:medi_ai/view_results.dart';
import 'package:medi_ai/check_alzheimers.dart';
import 'package:medi_ai/check_bone_fracture.dart';
import 'package:medi_ai/check_lung_cancer.dart';
import 'package:medi_ai/change_password.dart';

import 'login.dart';

// Create a StatefulWidget to manage notification count
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Notification count - this would typically come from a provider or API
  int _unreadNotificationCount = 3;

  // Color palette adjusted for better contrast
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

  // Method to handle notification tap
  Future<void> _handleNotificationTap() async {
    // Navigate to notifications page
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => hosp_view_notify()),
    );

    // After returning from notifications page, clear the badge
    // You can also pass back a value indicating if notifications were viewed
    setState(() {
      _unreadNotificationCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -------------------------
      // AppBar with medical theme, CUSTOM LOGO, and Notification Icon
      // -------------------------
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
        // Notification Icon on the right side of AppBar
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: primaryDark, size: 28),
                onPressed: _handleNotificationTap,
              ),
              // Notification badge - only shows if there are unread notifications
              if (_unreadNotificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      _unreadNotificationCount > 9 ? '9+' : _unreadNotificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),

      // -------------------------
      // Navigation Drawer - Clean version without user avatar
      // -------------------------
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Simplified Drawer Header - Removed avatar and user info
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryLight, primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'MEDI ',
                              style: poppinsBold.copyWith(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            TextSpan(
                              text: 'AI',
                              style: poppinsBold.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Medical Diagnostics Platform",
                        style: poppinsRegular.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Main Menu Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "MAIN MENU",
                  style: poppinsSemiBold.copyWith(
                    color: primaryDark.withOpacity(0.7),
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ),

              _buildDrawerItem(
                context: context,
                icon: Icons.person_outline,
                title: "View Profile",
                color: primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => hosp_view_profile()),
                  );
                },
              ),

              _buildDrawerItem(
                context: context,
                icon: Icons.lock_outline,
                title: "Change Password",
                color: primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                  );
                },
              ),

              const Divider(height: 20, color: Color(0xFFE3E3E3)),

              // AI Detection Services Section - With updated icons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "AI DETECTION SERVICES",
                  style: poppinsSemiBold.copyWith(
                    color: primaryDark.withOpacity(0.7),
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ),

              _buildDrawerItem(
                context: context,
                icon: Icons.psychology_outlined, // Psychology icon for Alzheimer's
                title: "Alzheimer's Detection",
                color: primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => check_alzheimers()),
                  );
                },
              ),

              _buildDrawerItem(
                context: context,
                icon: Icons.broken_image_outlined, // REVERTED: Back to broken_image for Bone Fracture
                title: "Bone Fracture Detection",
                color: primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => check_bone_fracture()),
                  );
                },
              ),

              _buildDrawerItem(
                context: context,
                icon: Icons.air_outlined, // Air icon for Lung Cancer
                title: "Lung Cancer Detection",
                color: primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => check_lung_cancer()),
                  );
                },
              ),

              _buildDrawerItem(
                context: context,
                icon: Icons.history_outlined,
                title: "Previous Results",
                color: primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => view_results()),
                  );
                },
              ),

              const Divider(height: 20, color: Color(0xFFE3E3E3)),

              // Feedback Section - Updated with Recent Review
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "FEEDBACK",
                  style: poppinsSemiBold.copyWith(
                    color: primaryDark.withOpacity(0.7),
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ),

              _buildDrawerItem(
                context: context,
                icon: Icons.feedback_outlined,
                title: "Send Feedback",
                color: primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SendFeedbackPage()),
                  );
                },
              ),

              _buildDrawerItem(
                context: context,
                icon: Icons.star_outline, // Star icon for Recent Review
                title: "Recent Review",
                color: primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => view_feedback()),
                  );
                },
              ),

              const Divider(height: 20, color: Color(0xFFE3E3E3)),

              // Logout at the bottom
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(Icons.logout, color: Colors.red, size: 20),
                      ),
                    ),
                    title: Text(
                      "Logout",
                      style: poppinsSemiBold.copyWith(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // -------------------------
      // Main Body Content - Clean and minimal with single scroll
      // -------------------------
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            children: [
              // Header Section - Simplified
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, accent.withOpacity(0.5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border(
                    bottom: BorderSide(color: accent.withOpacity(0.8)),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AI-Powered Medical Diagnostics",
                            style: poppinsBold.copyWith(
                              color: textColor,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Advanced diagnostic tools for medical professionals",
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
                            "Professional",
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

              // Main Content Area - Everything in single column
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick Stats Section
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              title: "Today",
                              value: "12",
                              subtitle: "Diagnoses",
                              color: primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              title: "Accuracy",
                              value: "98.5%",
                              subtitle: "Average",
                              color: primaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Services Section Title
                    Text(
                      "Medical AI Tools",
                      style: poppinsBold.copyWith(
                        color: textColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Select a diagnostic tool to begin",
                      style: poppinsMedium.copyWith(
                        color: primaryLight,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Services Grid - With updated icons
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildServiceCard(
                          icon: Icons.psychology_outlined, // Psychology icon for Alzheimer's
                          title: "Alzheimer's",
                          subtitle: "Brain analysis",
                          color: primary,
                          gradient: LinearGradient(
                            colors: [primary.withOpacity(0.1), primary.withOpacity(0.2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => check_alzheimers()),
                            );
                          },
                        ),
                        _buildServiceCard(
                          icon: Icons.broken_image_outlined, // REVERTED: Back to broken_image for Bone Fracture
                          title: "Bone Fracture",
                          subtitle: "X-ray analysis",
                          color: primaryLight,
                          gradient: LinearGradient(
                            colors: [primaryLight.withOpacity(0.1), primaryLight.withOpacity(0.2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => check_bone_fracture()),
                            );
                          },
                        ),
                        _buildServiceCard(
                          icon: Icons.air_outlined, // Air icon for Lung Cancer
                          title: "Lung Cancer",
                          subtitle: "CT scan analysis",
                          color: primaryDark,
                          gradient: LinearGradient(
                            colors: [primaryDark.withOpacity(0.1), primaryDark.withOpacity(0.2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => check_lung_cancer()),
                            );
                          },
                        ),
                        _buildServiceCard(
                          icon: Icons.history_outlined,
                          title: "Results",
                          subtitle: "View history",
                          color: primary,
                          gradient: LinearGradient(
                            colors: [primary.withOpacity(0.1), primary.withOpacity(0.2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => view_results()),
                            );
                          },
                        ),
                      ],
                    ),

                    // Additional spacing at bottom
                    const SizedBox(height: 40),
                  ],
                ),
              ),

              // Bottom Info Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: accent.withOpacity(0.8)),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.security, color: primary, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              "HIPAA Compliant",
                              style: poppinsSemiBold.copyWith(
                                color: textColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Data encrypted and secure",
                          style: poppinsRegular.copyWith(
                            color: primaryLight,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [accent, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: primary.withOpacity(0.2)),
                      ),
                      child: Text(
                        "v2.1.0",
                        style: poppinsSemiBold.copyWith(
                          color: primaryLight,
                          fontSize: 11,
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
    );
  }

  // Helper method for drawer items
  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(icon, color: color, size: 20),
          ),
        ),
        title: Text(
          title,
          style: poppinsMedium.copyWith(
            color: textColor,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: primaryLight,
          size: 20,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // Helper method for service cards
  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(icon, color: color, size: 24),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: poppinsSemiBold.copyWith(
                        color: textColor,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: poppinsRegular.copyWith(
                        color: primaryLight,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: color,
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for stat cards
  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: poppinsSemiBold.copyWith(
              color: color,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: poppinsBold.copyWith(
              color: textColor,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: poppinsRegular.copyWith(
              color: primaryLight,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}