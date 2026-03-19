// // import 'dart:convert';
// // import 'dart:typed_data';
// // import 'package:flutter/foundation.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'dart:io';
// //
// //
// //
// // class check_bone_fracture extends StatefulWidget {
// //   @override
// //   check_bone_fracture_state createState() => check_bone_fracture_state();
// // }
// //
// // class check_bone_fracture_state extends State<check_bone_fracture> {
// //   final txtname = new TextEditingController();
// //   final txtphone = new TextEditingController();
// //
// //   bool _valname=false;
// //   bool _valphone=false;
// //
// //   String image = "";
// //   String _displayText = "";
// //   void _changeText(String txt) {
// //     setState(() {
// //       _displayText = txt; // Update the text
// //     });
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //   }
// //
// //   final _formKey = GlobalKey<FormState>();
// //
// //   Uint8List? _selectedFileBytes;
// //   String? _selectedFileName;
// //
// //   void pickFile() {
// //     kIsWeb ? startWebFilePicker() : startMobileFilePicker();
// //   }
// //
// //   // Web file picker method
// //   Future<void> startWebFilePicker() async {
// //     FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
// //     if (result != null) {
// //       setState(() {
// //         _selectedFileBytes = result.files.first.bytes;
// //         _selectedFileName = result.files.first.name;
// //       });
// //     }
// //   }
// //
// //   // Mobile file picker method
// //   Future<void> startMobileFilePicker() async {
// //     // Use the 'dart:io' package for mobile platforms
// //     try {
// //       FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
// //       if (result != null && result.files.first.path != null) {
// //         File localFile = File(result.files.first.path!); // This works only on mobile
// //         Uint8List fileData = await localFile.readAsBytes();
// //         setState(() {
// //           _selectedFileBytes = fileData;
// //           _selectedFileName = result.files.first.name;
// //         });
// //       }
// //     } catch (e) {
// //       print('Error picking file: $e');
// //     }
// //   }
// //
// //   Future<void> _saveDetails(String name, String phone) async {
// //     if (!_formKey.currentState!.validate()) return;
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     String? url = prefs.getString("url");
// //     String? uid = prefs.getString("hid").toString();
// //     if (_selectedFileBytes == null || _selectedFileName == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select a file.")));
// //       return;
// //     }
// //     var request = http.MultipartRequest("POST", Uri.parse(url.toString() + "/bone_fracture_predict"));
// //     request.files.add(http.MultipartFile.fromBytes!('file', _selectedFileBytes!, filename: _selectedFileName));
// //     request.fields['uid']=uid;
// //     request.fields['name']=name;
// //     request.fields['phone']=phone;
// //     var response = await request.send();
// //     if (response.statusCode == 200) {
// //       var responseString = await response.stream.bytesToString();
// //       print('Response as String: $responseString');
// //       var jsonResponse = json.decode(responseString);
// //       print('Parsed JSON: $jsonResponse');
// //       String pred=jsonResponse['result'];
// //       print("Pred  "+pred);
// //       _changeText('Result : $pred');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //
// //       appBar: AppBar(
// //         title: Text('Bone Fracture Detection'),
// //         backgroundColor: Color(0xFF3C5718), // Set the AppBar background color to #D81324
// //       ),
// //       backgroundColor: Color(0xFFA2CA6C), // Background color of the screen
// //       body: Center(
// //
// //         child: SingleChildScrollView(
// //           padding: EdgeInsets.all(20),
// //           child: Form(
// //             key: _formKey,
// //             child: Container(
// //               padding: EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 color: Color(0xFFC7DFA7), // White card background color
// //                 borderRadius: BorderRadius.circular(15),
// //                 boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))], // Shadow effect for card
// //               ),
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Text("Bone Fracture Detection", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
// //                   SizedBox(height: 50),
// //                   TextField(
// //                     decoration: new InputDecoration(
// //                       hintText: "Patient Name",
// //                       errorText: _valname ? 'Required':null,
// //
// //                     ),
// //                     controller: txtname,
// //                   ),
// //                   SizedBox(height: 12,),
// //                   TextField(
// //                     decoration: new InputDecoration(
// //                       hintText: "Phone",
// //                       errorText: _valphone ? 'Required':null,
// //
// //                     ),
// //                     controller: txtphone,
// //                   ),
// //                   SizedBox(height: 12,),
// //                   ElevatedButton(
// //                     onPressed: pickFile,
// //                     child: Text("Select File"),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.black, // Button color
// //                       foregroundColor: Colors.white, // Text color inside the button
// //                       minimumSize: Size(double.infinity, 50), // Increased width
// //                       padding: EdgeInsets.symmetric(vertical: 15), // Increase the padding for height
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(30), // Rounded corners for the button
// //                       ),
// //                       elevation: 5, // Add a shadow effect to the button
// //                       side: BorderSide(color: Colors.white, width: 2),
// //                     ),
// //                   ),
// //                   SizedBox(height: 8),
// //                   // Display the selected image if available
// //                   _selectedFileBytes != null
// //                       ? Image.memory(_selectedFileBytes!)
// //                       : Text("No image selected", style: TextStyle(fontSize: 16, color: Colors.black)),
// //
// //                   SizedBox(height: 15),
// //                   ElevatedButton(
// //                     onPressed: (){
// //                       _saveDetails(txtname.text.toString(), txtphone.text.toString());
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       foregroundColor: Colors.white,
// //                       backgroundColor: Colors.black, // Button color (black)
// //                       minimumSize: Size(double.infinity, 50), // Increased width (stretches to full width)
// //                       padding: EdgeInsets.symmetric(vertical: 15), // Increase the padding for height
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(30), // Rounded corners for the button
// //                       ),
// //                       elevation: 5, // Add a shadow effect to the button
// //                       side: BorderSide(color: Colors.white, width: 2),
// //
// //                     ),
// //                     child: Text("Upload File", style: TextStyle(fontSize: 18, color: Colors.white)), // Text color (white)
// //                   ),
// //                   SizedBox(height: 20),
// //                   Text(_displayText,
// //                     style: TextStyle(fontSize: 24, color: Colors.black),),
// //                   SizedBox(height: 20),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io';
//
// class check_bone_fracture extends StatefulWidget {
//   @override
//   check_bone_fracture_state createState() => check_bone_fracture_state();
// }
//
// class check_bone_fracture_state extends State<check_bone_fracture> {
//   final txtname = TextEditingController();
//   final txtphone = TextEditingController();
//
//   bool _valname = false;
//   bool _valphone = false;
//   bool _isLoading = false;
//
//   String _displayText = "";
//   Uint8List? _selectedFileBytes;
//   String? _selectedFileName;
//
//   // Homepage color palette
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
//   void _changeText(String txt) {
//     setState(() {
//       _displayText = txt;
//     });
//   }
//
//   void pickFile() {
//     kIsWeb ? startWebFilePicker() : startMobileFilePicker();
//   }
//
//   Future<void> startWebFilePicker() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'jpeg', 'png', 'dcm', 'dicom', 'tiff'],
//     );
//     if (result != null) {
//       setState(() {
//         _selectedFileBytes = result.files.first.bytes;
//         _selectedFileName = result.files.first.name;
//         _displayText = ""; // Clear previous result
//       });
//     }
//   }
//
//   Future<void> startMobileFilePicker() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['jpg', 'jpeg', 'png', 'dcm', 'dicom', 'tiff'],
//       );
//       if (result != null && result.files.first.path != null) {
//         File localFile = File(result.files.first.path!);
//         Uint8List fileData = await localFile.readAsBytes();
//         setState(() {
//           _selectedFileBytes = fileData;
//           _selectedFileName = result.files.first.name;
//           _displayText = ""; // Clear previous result
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error picking file: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   Future<void> _saveDetails(String name, String phone) async {
//     if (name.isEmpty || phone.isEmpty) {
//       setState(() {
//         _valname = name.isEmpty;
//         _valphone = phone.isEmpty;
//       });
//       return;
//     }
//
//     if (_selectedFileBytes == null || _selectedFileName == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Please select an X-ray image"),
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
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? url = prefs.getString("url");
//       String? uid = prefs.getString("hid").toString();
//
//       var request = http.MultipartRequest("POST", Uri.parse(url.toString() + "/bone_fracture_predict"));
//       request.files.add(http.MultipartFile.fromBytes('file', _selectedFileBytes!, filename: _selectedFileName));
//       request.fields['uid'] = uid;
//       request.fields['name'] = name;
//       request.fields['phone'] = phone;
//
//       var response = await request.send();
//
//       if (response.statusCode == 200) {
//         var responseString = await response.stream.bytesToString();
//         var jsonResponse = json.decode(responseString);
//         String pred = jsonResponse['result'];
//         _changeText('Result: $pred');
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Analysis completed successfully'),
//             backgroundColor: primary,
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Server error: ${response.statusCode}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Connection error: $e'),
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
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [accent, Colors.white],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // -------------------------
//               // AppBar Section - Matching Homepage
//               // -------------------------
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
//                     // Logo without container - matching homepage
//                     Image.asset(
//                       'assets/logoM.png',
//                       width: 40,
//                       height: 40,
//                       fit: BoxFit.contain,
//                     ),
//                     const SizedBox(width: 8),
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: 'MEDI ',
//                             style: poppinsBold.copyWith(
//                               color: textColor,
//                               fontSize: 20,
//                             ),
//                           ),
//                           TextSpan(
//                             text: 'AI',
//                             style: poppinsBold.copyWith(
//                               color: primaryLight,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Spacer(),
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
//                           Icon(Icons.broken_image_outlined, color: Colors.white, size: 14),
//                           const SizedBox(width: 6),
//                           Text(
//                             "Bone Fracture",
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
//               // Main Content Area
//               Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Header Section
//                     Container(
//                       margin: const EdgeInsets.only(bottom: 24),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Bone Fracture Detection",
//                             style: poppinsBold.copyWith(
//                               color: textColor,
//                               fontSize: 22,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Upload X-ray for AI-powered fracture analysis",
//                             style: poppinsMedium.copyWith(
//                               color: primaryLight,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // Patient Information Card
//                     Container(
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: accent.withOpacity(0.8)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           // Service Icon and Title
//                           Row(
//                             children: [
//                               Container(
//                                 width: 48,
//                                 height: 48,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [primaryLight.withOpacity(0.1), primaryLight.withOpacity(0.2)],
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                   ),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Center(
//                                   child: Icon(Icons.broken_image_outlined, color: primaryLight, size: 24),
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "X-ray Analysis",
//                                       style: poppinsSemiBold.copyWith(
//                                         color: textColor,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       "AI-powered bone fracture detection",
//                                       style: poppinsRegular.copyWith(
//                                         color: primaryLight,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 24),
//
//                           // Patient Information - Two Column Layout
//                           Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: _buildInputField(
//                                       controller: txtname,
//                                       label: "Patient Name",
//                                       hintText: "Enter patient name",
//                                       icon: Icons.person_outline,
//                                       isError: _valname,
//                                       errorText: "Name is required",
//                                     ),
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Expanded(
//                                     child: _buildInputField(
//                                       controller: txtphone,
//                                       label: "Phone Number",
//                                       hintText: "Enter phone number",
//                                       icon: Icons.phone_outlined,
//                                       isError: _valphone,
//                                       errorText: "Phone is required",
//                                       keyboardType: TextInputType.phone,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 24),
//                             ],
//                           ),
//
//                           // File Upload Section
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "X-ray Image",
//                                 style: poppinsMedium.copyWith(
//                                   color: textColor,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               GestureDetector(
//                                 onTap: pickFile,
//                                 child: Container(
//                                   width: double.infinity,
//                                   padding: const EdgeInsets.all(24),
//                                   decoration: BoxDecoration(
//                                     color: accent,
//                                     borderRadius: BorderRadius.circular(16),
//                                     border: Border.all(
//                                       color: primary.withOpacity(0.3),
//                                       width: 2,
//                                     ),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Icon(
//                                         Icons.upload_file_outlined,
//                                         color: primaryLight,
//                                         size: 48,
//                                       ),
//                                       const SizedBox(height: 12),
//                                       Text(
//                                         _selectedFileName != null
//                                             ? _selectedFileName!
//                                             : "Tap to select X-ray image",
//                                         style: _selectedFileName != null
//                                             ? poppinsSemiBold.copyWith(color: primary, fontSize: 14)
//                                             : poppinsMedium.copyWith(color: primaryLight, fontSize: 14),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       if (_selectedFileName != null)
//                                         Column(
//                                           children: [
//                                             const SizedBox(height: 8),
//                                             Text(
//                                               "Tap to change file",
//                                               style: poppinsRegular.copyWith(
//                                                 color: primaryLight,
//                                                 fontSize: 11,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//
//                               // Image Preview
//                               if (_selectedFileBytes != null)
//                                 Container(
//                                   width: double.infinity,
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(color: accent.withOpacity(0.8)),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "X-ray Preview",
//                                         style: poppinsSemiBold.copyWith(
//                                           color: textColor,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 12),
//                                       Container(
//                                         width: double.infinity,
//                                         height: 200,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(8),
//                                           border: Border.all(color: accent.withOpacity(0.8)),
//                                         ),
//                                         child: ClipRRect(
//                                           borderRadius: BorderRadius.circular(8),
//                                           child: Image.memory(
//                                             _selectedFileBytes!,
//                                             fit: BoxFit.contain,
//                                             color: Colors.grey[100],
//                                             colorBlendMode: BlendMode.darken,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                             ],
//                           ),
//                           const SizedBox(height: 30),
//
//                           // Analyze Button
//                           Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [primary, primaryLight],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: primary.withOpacity(0.3),
//                                   blurRadius: 15,
//                                   offset: const Offset(0, 8),
//                                 ),
//                               ],
//                             ),
//                             child: Material(
//                               color: Colors.transparent,
//                               child: InkWell(
//                                 onTap: _isLoading
//                                     ? null
//                                     : () {
//                                   final name = txtname.text.trim();
//                                   final phone = txtphone.text.trim();
//                                   if (name.isEmpty || phone.isEmpty) {
//                                     setState(() {
//                                       _valname = name.isEmpty;
//                                       _valphone = phone.isEmpty;
//                                     });
//                                     return;
//                                   }
//                                   if (_selectedFileBytes == null) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: Text("Please select an X-ray image"),
//                                         backgroundColor: Colors.red,
//                                       ),
//                                     );
//                                     return;
//                                   }
//                                   _saveDetails(name, phone);
//                                 },
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(vertical: 16),
//                                   child: Center(
//                                     child: _isLoading
//                                         ? SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         color: Colors.white,
//                                       ),
//                                     )
//                                         : Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.search_outlined, color: Colors.white, size: 18),
//                                         const SizedBox(width: 8),
//                                         Text(
//                                           'ANALYZE X-RAY',
//                                           style: poppinsSemiBold.copyWith(
//                                             color: Colors.white,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//
//                           // Results Section
//                           if (_displayText.isNotEmpty)
//                             Container(
//                               width: double.infinity,
//                               padding: const EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                 color: _displayText.toLowerCase().contains('fracture') ||
//                                     _displayText.toLowerCase().contains('positive')
//                                     ? Colors.orange.withOpacity(0.1)
//                                     : _displayText.toLowerCase().contains('normal') ||
//                                     _displayText.toLowerCase().contains('negative')
//                                     ? Colors.green.withOpacity(0.1)
//                                     : accent,
//                                 borderRadius: BorderRadius.circular(16),
//                                 border: Border.all(
//                                   color: _displayText.toLowerCase().contains('fracture') ||
//                                       _displayText.toLowerCase().contains('positive')
//                                       ? Colors.orange.withOpacity(0.3)
//                                       : _displayText.toLowerCase().contains('normal') ||
//                                       _displayText.toLowerCase().contains('negative')
//                                       ? Colors.green.withOpacity(0.3)
//                                       : primary.withOpacity(0.2),
//                                 ),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Container(
//                                         width: 40,
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           color: _displayText.toLowerCase().contains('fracture') ||
//                                               _displayText.toLowerCase().contains('positive')
//                                               ? Colors.orange.withOpacity(0.2)
//                                               : _displayText.toLowerCase().contains('normal') ||
//                                               _displayText.toLowerCase().contains('negative')
//                                               ? Colors.green.withOpacity(0.2)
//                                               : primary.withOpacity(0.1),
//                                           borderRadius: BorderRadius.circular(8),
//                                         ),
//                                         child: Center(
//                                           child: Icon(
//                                             _displayText.toLowerCase().contains('fracture') ||
//                                                 _displayText.toLowerCase().contains('positive')
//                                                 ? Icons.warning_amber_outlined
//                                                 : Icons.check_circle_outlined,
//                                             color: _displayText.toLowerCase().contains('fracture') ||
//                                                 _displayText.toLowerCase().contains('positive')
//                                                 ? Colors.orange
//                                                 : _displayText.toLowerCase().contains('normal') ||
//                                                 _displayText.toLowerCase().contains('negative')
//                                                 ? Colors.green
//                                                 : primary,
//                                             size: 20,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Analysis Result",
//                                               style: poppinsSemiBold.copyWith(
//                                                 color: textColor,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             Text(
//                                               _displayText,
//                                               style: poppinsBold.copyWith(
//                                                 color: _displayText.toLowerCase().contains('fracture') ||
//                                                     _displayText.toLowerCase().contains('positive')
//                                                     ? Colors.orange
//                                                     : _displayText.toLowerCase().contains('normal') ||
//                                                     _displayText.toLowerCase().contains('negative')
//                                                     ? Colors.green
//                                                     : primary,
//                                                 fontSize: 18,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   if (!_displayText.toLowerCase().contains('not fractured') ||
//                                       _displayText.toLowerCase().contains('positive'))
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 12),
//                                       child: Text(
//                                         "Please consult an orthopedic specialist immediately",
//                                         style: poppinsMedium.copyWith(
//                                           color: Colors.orange,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//
//                     // Info Section
//                     const SizedBox(height: 20),
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: accent.withOpacity(0.8)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.03),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: primary.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Center(
//                               child: Icon(Icons.info_outline, color: primary, size: 20),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "X-ray Requirements",
//                                   style: poppinsSemiBold.copyWith(
//                                     color: textColor,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   "Supported formats: JPG, PNG, DICOM. Ensure clear visibility of bone structure for accurate fracture detection.",
//                                   style: poppinsRegular.copyWith(
//                                     color: primaryLight,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//
//               // -------------------------
//               // Bottom Info Bar - Matching Homepage
//               // -------------------------
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
//                             Icon(Icons.medical_services, color: primary, size: 14),
//                             const SizedBox(width: 6),
//                             Text(
//                               "Medical AI Tool",
//                               style: poppinsSemiBold.copyWith(
//                                 color: textColor,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           "For diagnostic purposes only",
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
//   // Helper method for input fields
//   Widget _buildInputField({
//     required TextEditingController controller,
//     required String label,
//     required String hintText,
//     required IconData icon,
//     required bool isError,
//     required String errorText,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: poppinsMedium.copyWith(
//             color: textColor,
//             fontSize: 14,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: isError ? Colors.red : accent.withOpacity(0.8),
//               width: 1.5,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.03),
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: TextField(
//             controller: controller,
//             style: poppinsMedium.copyWith(
//               color: textColor,
//               fontSize: 14,
//             ),
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: poppinsRegular.copyWith(
//                 color: primaryLight.withOpacity(0.6),
//               ),
//               border: InputBorder.none,
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 16,
//               ),
//               prefixIcon: Icon(
//                 icon,
//                 color: primary,
//                 size: 20,
//               ),
//               errorText: isError ? errorText : null,
//             ),
//             keyboardType: keyboardType,
//             onChanged: (value) {
//               if (isError && value.isNotEmpty) {
//                 setState(() {
//                   if (label == "Patient Name") _valname = false;
//                   if (label == "Phone Number") _valphone = false;
//                 });
//               }
//             },
//           ),
//         ),
//         if (isError)
//           Padding(
//             padding: const EdgeInsets.only(top: 4, left: 4),
//             child: Text(
//               errorText,
//               style: poppinsRegular.copyWith(
//                 color: Colors.red,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }



import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:medi_ai/homepage.dart';

class check_bone_fracture extends StatefulWidget {
  @override
  check_bone_fracture_state createState() => check_bone_fracture_state();
}

class check_bone_fracture_state extends State<check_bone_fracture> with SingleTickerProviderStateMixin {
  final txtname = TextEditingController();
  final txtphone = TextEditingController();

  bool _valname = false;
  bool _valphone = false;
  bool _isLoading = false;
  bool _isAnalyzing = false;

  // Animation controller for scanning effect
  late AnimationController _scanAnimationController;
  late Animation<double> _scanAnimation;

  String _displayText = "";
  String _finalResult = "";
  Uint8List? _selectedFileBytes;
  String? _selectedFileName;

  // Name and phone validation errors
  String? _nameError;
  String? _phoneError;

  // Homepage color palette
  final Color primaryDark = const Color(0xFF1B3C53);
  final Color primary = const Color(0xFF2A5170);
  final Color primaryLight = const Color(0xFF4A7696);
  final Color accent = const Color(0xFFF0F4F8);
  final Color textColor = const Color(0xFF1E3A5F);

  // MEDI AI blue colors for scanning animation
  final Color scanColor = const Color(0xFF2A5170); // Primary MEDI AI blue
  final Color scanGlowColor = const Color(0xFF4A7696); // Primary light MEDI AI blue

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

    // Initialize scan animation
    _scanAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scanAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scanAnimationController.dispose();
    txtname.dispose();
    txtphone.dispose();
    super.dispose();
  }

  void _changeText(String txt) {
    setState(() {
      _displayText = txt;
      _finalResult = txt;
    });
  }

  void _validateName(String value) {
    setState(() {
      if (value.isEmpty) {
        _nameError = 'Name is required';
        _valname = true;
      } else if (value.length < 3) {
        _nameError = 'Name must be at least 3 characters';
        _valname = true;
      } else if (value.length > 50) {
        _nameError = 'Name cannot exceed 50 characters';
        _valname = true;
      } else {
        _nameError = null;
        _valname = false;
      }
    });
  }

  void _validatePhone(String value) {
    setState(() {
      // Remove any non-digit characters for validation
      String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');

      if (value.isEmpty) {
        _phoneError = 'Phone number is required';
        _valphone = true;
      } else if (digitsOnly.length != 10) {
        _phoneError = 'Phone number must be exactly 10 digits';
        _valphone = true;
      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        _phoneError = 'Only numbers allowed';
        _valphone = true;
      } else {
        _phoneError = null;
        _valphone = false;
      }
    });
  }

  void pickFile() {
    kIsWeb ? startWebFilePicker() : startMobileFilePicker();
  }

  Future<void> startWebFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'dcm', 'dicom', 'tiff'],
    );
    if (result != null) {
      setState(() {
        _selectedFileBytes = result.files.first.bytes;
        _selectedFileName = result.files.first.name;
        _displayText = ""; // Clear previous result
        _finalResult = ""; // Clear previous result
      });
    }
  }

  Future<void> startMobileFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'dcm', 'dicom', 'tiff'],
      );
      if (result != null && result.files.first.path != null) {
        File localFile = File(result.files.first.path!);
        Uint8List fileData = await localFile.readAsBytes();
        setState(() {
          _selectedFileBytes = fileData;
          _selectedFileName = result.files.first.name;
          _displayText = ""; // Clear previous result
          _finalResult = ""; // Clear previous result
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveDetails(String name, String phone) async {
    // Validate name with character limit
    if (name.isEmpty) {
      setState(() {
        _nameError = 'Name is required';
        _valname = true;
      });
      return;
    } else if (name.length < 3) {
      setState(() {
        _nameError = 'Name must be at least 3 characters';
        _valname = true;
      });
      return;
    } else if (name.length > 50) {
      setState(() {
        _nameError = 'Name cannot exceed 50 characters';
        _valname = true;
      });
      return;
    }

    // Validate phone with exactly 10 digits
    String digitsOnly = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (phone.isEmpty) {
      setState(() {
        _phoneError = 'Phone number is required';
        _valphone = true;
      });
      return;
    } else if (digitsOnly.length != 10) {
      setState(() {
        _phoneError = 'Phone number must be exactly 10 digits';
        _valphone = true;
      });
      return;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      setState(() {
        _phoneError = 'Only numbers allowed';
        _valphone = true;
      });
      return;
    }

    if (_selectedFileBytes == null || _selectedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select an X-ray image"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _isAnalyzing = true;
    });

    // Start scanning animation
    _scanAnimationController.repeat(reverse: true);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      String? uid = prefs.getString("hid").toString();

      var request = http.MultipartRequest("POST", Uri.parse(url.toString() + "/bone_fracture_predict"));
      request.files.add(http.MultipartFile.fromBytes('file', _selectedFileBytes!, filename: _selectedFileName));
      request.fields['uid'] = uid;
      request.fields['name'] = name;
      request.fields['phone'] = phone;

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseString);
        String pred = jsonResponse['result'];
        _changeText('$pred'); // Store without "Result: " prefix for better display

        // Stop scanning animation
        _scanAnimationController.stop();

        // Show result in popup
        _showResultPopup(pred);
      } else {
        setState(() {
          _isAnalyzing = false;
        });
        _scanAnimationController.stop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Server error: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isAnalyzing = false;
      });
      _scanAnimationController.stop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showResultPopup(String result) {
    bool isPositive = result.toLowerCase().contains('fracture') ||
        result.toLowerCase().contains('positive') ||
        result.toLowerCase().contains('abnormal');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Result Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: isPositive ? Colors.orange.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isPositive ? Icons.warning_amber_rounded : Icons.check_circle_rounded,
                      size: 48,
                      color: isPositive ? Colors.orange : Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Result Title
                Text(
                  'Analysis Complete',
                  style: poppinsBold.copyWith(
                    color: textColor,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 12),

                // Small Image Preview in popup
                if (_selectedFileBytes != null)
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: accent.withOpacity(0.5)),
                      image: DecorationImage(
                        image: MemoryImage(_selectedFileBytes!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                // Result Message
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isPositive ? Colors.orange.withOpacity(0.05) : Colors.green.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isPositive ? Colors.orange.withOpacity(0.3) : Colors.green.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        result,
                        textAlign: TextAlign.center,
                        style: poppinsSemiBold.copyWith(
                          color: isPositive ? Colors.orange : Colors.green,
                          fontSize: 18,
                        ),
                      ),
                      if (isPositive) ...[
                        const SizedBox(height: 12),
                        Text(
                          "Please consult an orthopedic specialist immediately",
                          textAlign: TextAlign.center,
                          style: poppinsMedium.copyWith(
                            color: Colors.orange,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Close Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isAnalyzing = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primary, primaryLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'CLOSE',
                        style: poppinsSemiBold.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      setState(() {
        _isAnalyzing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar matching HomePage exactly with back button
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
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Header Section with Badge
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bone Fracture Detection",
                              style: poppinsBold.copyWith(
                                color: textColor,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Upload X-ray for AI analysis",
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
                            Icon(Icons.broken_image_outlined, color: Colors.white, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              "X-Ray",
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

                // Main Card
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
                        // Icon Header
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [primary.withOpacity(0.1), primary.withOpacity(0.2)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(Icons.broken_image_outlined, color: primary, size: 24),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Patient Information",
                                    style: poppinsSemiBold.copyWith(
                                      color: textColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Enter patient details below",
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
                        const SizedBox(height: 24),

                        // Name and Phone in same row with validation
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name Field
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person_outlined, color: primary, size: 14),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Patient Name",
                                        style: poppinsSemiBold.copyWith(
                                          color: textColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: accent.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: _valname ? Colors.red : accent.withOpacity(0.8),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: txtname,
                                      style: poppinsMedium.copyWith(color: textColor, fontSize: 13),
                                      onChanged: _validateName,
                                      maxLength: 50,
                                      buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                                      decoration: InputDecoration(
                                        hintText: "Full name",
                                        hintStyle: poppinsRegular.copyWith(
                                          color: primaryLight.withOpacity(0.5),
                                          fontSize: 12,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_nameError != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, top: 4),
                                      child: Text(
                                        _nameError!,
                                        style: poppinsRegular.copyWith(color: Colors.red, fontSize: 10),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Phone Field
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.phone_outlined, color: primaryLight, size: 14),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Phone Number",
                                        style: poppinsSemiBold.copyWith(
                                          color: textColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: accent.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: _valphone ? Colors.red : accent.withOpacity(0.8),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: txtphone,
                                      keyboardType: TextInputType.phone,
                                      style: poppinsMedium.copyWith(color: textColor, fontSize: 13),
                                      onChanged: _validatePhone,
                                      maxLength: 10,
                                      buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                                      decoration: InputDecoration(
                                        hintText: "Phone number",
                                        hintStyle: poppinsRegular.copyWith(
                                          color: primaryLight.withOpacity(0.5),
                                          fontSize: 12,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_phoneError != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, top: 4),
                                      child: Text(
                                        _phoneError!,
                                        style: poppinsRegular.copyWith(color: Colors.red, fontSize: 10),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // File Upload Section - WITH MEDICAL SCANNING ANIMATION
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.broken_image_outlined, color: primary, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  "X-Ray Image",
                                  style: poppinsSemiBold.copyWith(
                                    color: textColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Image container with scanning animation - CENTERED TEXT
                            GestureDetector(
                              onTap: _isAnalyzing ? null : pickFile,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: double.infinity,
                                height: _selectedFileBytes != null ? 250 : 200,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: accent,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: _isAnalyzing
                                        ? primary
                                        : primary.withOpacity(0.3),
                                    width: _isAnalyzing ? 3 : 2,
                                  ),
                                  boxShadow: _isAnalyzing
                                      ? [
                                    BoxShadow(
                                      color: primary.withOpacity(0.5),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                    BoxShadow(
                                      color: primaryLight.withOpacity(0.3),
                                      blurRadius: 30,
                                      spreadRadius: 10,
                                    )
                                  ]
                                      : null,
                                ),
                                child: Stack(
                                  children: [
                                    // Main content - CENTERED VERTICALLY AND HORIZONTALLY
                                    _selectedFileBytes == null
                                        ? Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.upload_file_outlined,
                                            color: primaryLight,
                                            size: 48,
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            "Tap to select X-ray image",
                                            style: poppinsMedium.copyWith(
                                              color: primaryLight,
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Supported: JPG, PNG, DICOM",
                                            style: poppinsRegular.copyWith(
                                              color: primaryLight.withOpacity(0.7),
                                              fontSize: 11,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                        : Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.memory(
                                          _selectedFileBytes!,
                                          fit: BoxFit.contain,
                                          height: 200,
                                        ),
                                      ),
                                    ),

                                    // Medical scanning animation overlay - MEDI AI BLUE
                                    if (_isAnalyzing && _selectedFileBytes != null)
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Stack(
                                            children: [
                                              // Semi-transparent overlay
                                              Container(
                                                color: Colors.black.withOpacity(0.2),
                                              ),

                                              // Animated scanning line (top to bottom)
                                              AnimatedBuilder(
                                                animation: _scanAnimation,
                                                builder: (context, child) {
                                                  return Positioned(
                                                    top: _scanAnimation.value * (250 - 6),
                                                    left: 0,
                                                    right: 0,
                                                    child: Container(
                                                      height: 6,
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                          colors: [
                                                            Colors.transparent,
                                                            primary,
                                                            primaryLight,
                                                            primary,
                                                            Colors.transparent,
                                                          ],
                                                          stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: primary.withOpacity(0.8),
                                                            blurRadius: 20,
                                                            spreadRadius: 5,
                                                          ),
                                                          BoxShadow(
                                                            color: primaryLight.withOpacity(0.6),
                                                            blurRadius: 30,
                                                            spreadRadius: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),

                                              // Scanning text - WITHOUT loading circle
                                              Center(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 12,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(0.6),
                                                    borderRadius: BorderRadius.circular(30),
                                                    border: Border.all(
                                                      color: primary,
                                                      width: 2,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: primary.withOpacity(0.5),
                                                        blurRadius: 15,
                                                        spreadRadius: 2,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Text(
                                                    "SCANNING X-RAY...",
                                                    style: poppinsSemiBold.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      letterSpacing: 2,
                                                      shadows: [
                                                        Shadow(
                                                          color: primary,
                                                          blurRadius: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Analyze Button
                        _isAnalyzing
                            ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: primary.withOpacity(0.3)),
                          ),
                          child: Center(
                            child: Text(
                              "AI ANALYSIS IN PROGRESS",
                              style: poppinsSemiBold.copyWith(
                                color: primary,
                                fontSize: 14,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        )
                            : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [primary, primaryLight],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: primary.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _isLoading
                                  ? null
                                  : () {
                                final name = txtname.text.trim();
                                final phone = txtphone.text.trim();

                                // Validate before proceeding
                                _validateName(name);
                                _validatePhone(phone);

                                if (_nameError == null && _phoneError == null) {
                                  if (_selectedFileBytes == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Please select an X-ray image"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }
                                  _saveDetails(name, phone);
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.broken_image_outlined, color: Colors.white, size: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        'ANALYZE X-RAY',
                                        style: poppinsSemiBold.copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Results Section - PERSISTS AFTER POPUP CLOSES
                        if (_finalResult.isNotEmpty && !_isAnalyzing) ...[
                          const SizedBox(height: 24),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: _finalResult.toLowerCase().contains('fracture') ||
                                  _finalResult.toLowerCase().contains('positive')
                                  ? Colors.orange.withOpacity(0.1)
                                  : _finalResult.toLowerCase().contains('normal') ||
                                  _finalResult.toLowerCase().contains('negative')
                                  ? Colors.green.withOpacity(0.1)
                                  : accent,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _finalResult.toLowerCase().contains('fracture') ||
                                    _finalResult.toLowerCase().contains('positive')
                                    ? Colors.orange.withOpacity(0.3)
                                    : _finalResult.toLowerCase().contains('normal') ||
                                    _finalResult.toLowerCase().contains('negative')
                                    ? Colors.green.withOpacity(0.3)
                                    : primary.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: _finalResult.toLowerCase().contains('fracture') ||
                                        _finalResult.toLowerCase().contains('positive')
                                        ? Colors.orange.withOpacity(0.2)
                                        : _finalResult.toLowerCase().contains('normal') ||
                                        _finalResult.toLowerCase().contains('negative')
                                        ? Colors.green.withOpacity(0.2)
                                        : primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      _finalResult.toLowerCase().contains('fracture') ||
                                          _finalResult.toLowerCase().contains('positive')
                                          ? Icons.warning_amber_rounded
                                          : Icons.check_circle_rounded,
                                      color: _finalResult.toLowerCase().contains('fracture') ||
                                          _finalResult.toLowerCase().contains('positive')
                                          ? Colors.orange
                                          : _finalResult.toLowerCase().contains('normal') ||
                                          _finalResult.toLowerCase().contains('negative')
                                          ? Colors.green
                                          : primary,
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
                                        "Analysis Result",
                                        style: poppinsSemiBold.copyWith(
                                          color: textColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _finalResult,
                                        style: poppinsBold.copyWith(
                                          color: _finalResult.toLowerCase().contains('fracture') ||
                                              _finalResult.toLowerCase().contains('positive')
                                              ? Colors.orange
                                              : _finalResult.toLowerCase().contains('normal') ||
                                              _finalResult.toLowerCase().contains('negative')
                                              ? Colors.green
                                              : primary,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Info Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: accent.withOpacity(0.8)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
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
                          color: primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(Icons.info_outline, color: primary, size: 20),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "X-ray Requirements",
                              style: poppinsSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Supported formats: JPG, PNG, DICOM. Ensure clear bone structure visibility for accurate analysis.",
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

                const SizedBox(height: 40),

                // Bottom Info Bar - Matching Homepage
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.medical_services, color: primary, size: 14),
                              const SizedBox(width: 6),
                              Text(
                                "Medical AI Tool",
                                style: poppinsSemiBold.copyWith(
                                  color: textColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "For diagnostic purposes only",
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
      ),
    );
  }
}