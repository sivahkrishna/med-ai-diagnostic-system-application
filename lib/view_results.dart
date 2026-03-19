// // import 'dart:convert';
// //
// // import 'package:http/http.dart' as http;
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// //
// // class view_results extends StatefulWidget{
// //   @override
// //   view_results_state createState()=>view_results_state();
// //
// // }
// //
// //
// // class view_results_state extends State<view_results>{
// //
// //   // get data from python
// //   Future<List<Joke>> _getJokes() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     String? url=prefs.getString("url");
// //     String b = prefs.getString("hid").toString();
// //     String foodimage="";
// //     var data =
// //     await http.post(Uri.parse(url.toString()+"/hosp_view_results"),
// //         body: {"hid":b}
// //     );
// //
// //     var jsonData = json.decode(data.body);
// //    print(jsonData);
// //     List<Joke> jokes = [];
// //     for (var joke in jsonData["data"]) {
// //       print(joke);
// //       String fileurl=url.toString()+joke["image"].toString();
// //       Joke newJoke = Joke(
// //           joke["date"].toString(),
// //           joke["patient"],
// //           joke["phone"].toString(),
// //           joke["prediction"].toString(),
// //           joke["algorithm"].toString(),
// //           fileurl,
// //           joke["result"].toString(),
// //       );
// //       jokes.add(newJoke);
// //     }
// //     return jokes;
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Medi AI'),
// //         backgroundColor: Colors.black,
// //         foregroundColor: Colors.white,
// //       ),
// //
// //
// //       backgroundColor: Colors.black54,
// //       body:
// //
// //
// //       Container(
// //
// //         child:
// //         FutureBuilder(
// //           future: _getJokes(),
// //           builder: (BuildContext context, AsyncSnapshot snapshot) {
// // //              print("snapshot"+snapshot.toString());
// //             if (snapshot.data == null) {
// //               return Container(
// //                 child: Center(
// //                   child: Text("Loading..."),
// //                 ),
// //               );
// //             } else {
// //               return ListView.builder(
// //                 itemCount: snapshot.data.length,
// //                 itemBuilder: (BuildContext context, int index) {
// //                   return Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: Card(
// //                       elevation: 3,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                         side: BorderSide(color: Colors.grey.shade300),
// //                       ),
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(16.0),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //
// //                             SizedBox(height: 10),
// //                             Image.network(snapshot.data[index].image.toString(), height: 150, width: 150,),
// //                             SizedBox(height: 10,),
// //                             _buildRow("Date:", snapshot.data[index].date.toString()),
// //                             _buildRow("Patient:", snapshot.data[index].patient.toString()),
// //                             _buildRow("Phone:", snapshot.data[index].phone.toString()),
// //                             SizedBox(height: 3,),
// //                             Divider(),
// //                             SizedBox(height: 3,),
// //                             _buildRow("Prediction Type:", snapshot.data[index].prediction.toString()),
// //                             _buildRow("Algorithm Used:", snapshot.data[index].algorithm.toString()),
// //                             _buildRow("Result:", snapshot.data[index].result.toString()),
// //
// //
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               );
// //
// //
// //             }
// //           },
// //
// //
// //         ),
// //
// //
// //
// //
// //
// //       ),
// //     );
// //   }
// //
// //   Widget _buildRow(String label, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4),
// //       child: Row(
// //         children: [
// //           SizedBox(
// //             width: 200,
// //             child: Text(
// //               label,
// //               style: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //           SizedBox(width: 5),
// //           Flexible(
// //             child: Text(
// //               value,
// //               style: TextStyle(
// //                 color: Colors.grey.shade800,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
// // class Joke {
// //   final String date;
// //   final String patient;
// //   final String phone;
// //   final String prediction;
// //   final String algorithm;
// //   final String image;
// //   final String result;
// //
// //
// //   Joke(this.date,this.patient, this.phone, this.prediction, this.algorithm, this.image, this.result);
// // //  print("hiiiii");
// // }
//
//
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class view_results extends StatefulWidget {
//   @override
//   view_results_state createState() => view_results_state();
// }
//
// class view_results_state extends State<view_results> {
//   // Color palette from homepage
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
//     fontFamily: 'Pppins',
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
//   // get data from python
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? url = prefs.getString("url");
//     String b = prefs.getString("hid").toString();
//     var data = await http.post(
//         Uri.parse(url.toString() + "/hosp_view_results"),
//         body: {"hid": b}
//     );
//
//     var jsonData = json.decode(data.body);
//     print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["data"]) {
//       print(joke);
//       String fileurl = url.toString() + joke["image"].toString();
//       Joke newJoke = Joke(
//         joke["date"].toString(),
//         joke["patient"],
//         joke["phone"].toString(),
//         joke["prediction"].toString(),
//         joke["algorithm"].toString(),
//         fileurl,
//         joke["result"].toString(),
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // -------------------------
//       // AppBar matching homepage theme
//       // -------------------------
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Container(
//               width: 35,
//               height: 35,
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
//                       fontSize: 18,
//                     ),
//                   ),
//                   TextSpan(
//                     text: 'AI',
//                     style: poppinsBold.copyWith(
//                       color: primaryLight,
//                       fontSize: 18,
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
//         centerTitle: false,
//       ),
//
//       // -------------------------
//       // Body with homepage theme
//       // -------------------------
//       body: FutureBuilder(
//         future: _getJokes(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(
//                     color: primary,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     "Loading Results...",
//                     style: poppinsMedium.copyWith(
//                       color: textColor,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else if (snapshot.data.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.assignment_outlined,
//                     size: 80,
//                     color: primaryLight.withOpacity(0.5),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     "No Results Found",
//                     style: poppinsBold.copyWith(
//                       color: textColor,
//                       fontSize: 20,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "AI diagnostic results will appear here",
//                     style: poppinsMedium.copyWith(
//                       color: primaryLight,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Header Section
//                     Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [primaryLight, primary],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 60,
//                             height: 60,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(30),
//                               border: Border.all(color: Colors.white, width: 3),
//                             ),
//                             child: Center(
//                               child: Icon(
//                                 Icons.analytics_outlined,
//                                 size: 30,
//                                 color: primary,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 20),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Diagnostic Results",
//                                   style: poppinsBold.copyWith(
//                                     color: Colors.white,
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   "${snapshot.data.length} result${snapshot.data.length == 1 ? '' : 's'} available",
//                                   style: poppinsMedium.copyWith(
//                                     color: Colors.white.withOpacity(0.9),
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 24),
//
//                     // Results List (changed from GridView to ListView.builder)
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: snapshot.data.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 16),
//                           child: _buildResultCard(
//                             date: snapshot.data[index].date.toString(),
//                             patient: snapshot.data[index].patient.toString(),
//                             phone: snapshot.data[index].phone.toString(),
//                             prediction: snapshot.data[index].prediction.toString(),
//                             algorithm: snapshot.data[index].algorithm.toString(),
//                             image: snapshot.data[index].image.toString(),
//                             result: snapshot.data[index].result.toString(),
//                             index: index,
//                           ),
//                         );
//                       },
//                     ),
//
//                     SizedBox(height: 20),
//
//                     // Info Card
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: accent.withOpacity(0.5)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Row(
//                           children: [
//                             Icon(Icons.medical_services_outlined, color: primaryLight, size: 24),
//                             SizedBox(width: 12),
//                             Expanded(
//                               child: Text(
//                                 "All AI diagnostic results are stored for medical records and analysis",
//                                 style: poppinsRegular.copyWith(
//                                   color: primaryLight,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   // Result Card Widget
//   Widget _buildResultCard({
//     required String date,
//     required String patient,
//     required String phone,
//     required String prediction,
//     required String algorithm,
//     required String image,
//     required String result,
//     required int index,
//   }) {
//     Color resultColor = _getResultColor(result);
//     // FIXED: Using broken_image_outlined for bone fracture (original icon)
//     IconData resultIcon = _getResultIcon(prediction);
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 15,
//             offset: Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header with gradient
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [primaryLight.withOpacity(0.8), primary.withOpacity(0.8)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Icon(resultIcon, color: Colors.white, size: 20),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         _formatDate(date),
//                         style: poppinsMedium.copyWith(
//                           color: Colors.white.withOpacity(0.9),
//                           fontSize: 12,
//                         ),
//                       ),
//                       Text(
//                         prediction,
//                         style: poppinsSemiBold.copyWith(
//                           color: Colors.white,
//                           fontSize: 16,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Content
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Patient Info
//                 Row(
//                   children: [
//                     Icon(Icons.person_outline, size: 16, color: primaryLight),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         patient,
//                         style: poppinsSemiBold.copyWith(
//                           color: textColor,
//                           fontSize: 14,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Icons.phone_outlined, size: 14, color: primaryLight),
//                     SizedBox(width: 8),
//                     Text(
//                       phone,
//                       style: poppinsRegular.copyWith(
//                         color: primaryLight,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 12),
//
//                 // Image Preview
//                 Container(
//                   height: 120,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: accent,
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       image,
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return Center(
//                           child: CircularProgressIndicator(
//                             color: primary,
//                           ),
//                         );
//                       },
//                       errorBuilder: (context, error, stackTrace) {
//                         return Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.image_not_supported_outlined, color: primaryLight),
//                               SizedBox(height: 4),
//                               Text(
//                                 "Image",
//                                 style: poppinsRegular.copyWith(
//                                   color: primaryLight,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 12),
//
//                 // Algorithm and Result
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: accent.withOpacity(0.5),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Algorithm",
//                               style: poppinsMedium.copyWith(
//                                 color: primaryLight,
//                                 fontSize: 10,
//                               ),
//                             ),
//                             SizedBox(height: 2),
//                             Text(
//                               algorithm,
//                               style: poppinsRegular.copyWith(
//                                 color: textColor,
//                                 fontSize: 11,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: resultColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Result",
//                             style: poppinsMedium.copyWith(
//                               color: resultColor,
//                               fontSize: 10,
//                             ),
//                           ),
//                           SizedBox(height: 2),
//                           Text(
//                             result,
//                             style: poppinsSemiBold.copyWith(
//                               color: resultColor,
//                               fontSize: 12,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Helper methods
//   Color _getResultColor(String result) {
//     result = result.toLowerCase();
//     if (result.contains('positive') || result.contains('detected') || result.contains('abnormal')) {
//       return Color(0xFFE74C3C); // Red for positive/detected
//     } else if (result.contains('negative') || result.contains('normal') || result.contains('clear')) {
//       return Color(0xFF27AE60); // Green for negative/normal
//     } else if (result.contains('inconclusive') || result.contains('pending')) {
//       return Color(0xFFF39C12); // Orange for inconclusive
//     } else {
//       return primary; // Default blue
//     }
//   }
//
//   // FIXED: Reverted to original bone fracture icon
//   IconData _getResultIcon(String prediction) {
//     prediction = prediction.toLowerCase();
//     if (prediction.contains('alzheimer') || prediction.contains('brain')) {
//       return Icons.psychology_outlined;
//     } else if (prediction.contains('fracture') || prediction.contains('bone')) {
//       return Icons.broken_image_outlined; // ORIGINAL ICON FOR BONE FRACTURE
//     } else if (prediction.contains('lung') || prediction.contains('cancer')) {
//       return Icons.air_outlined;
//     } else {
//       return Icons.analytics_outlined;
//     }
//   }
//
//   String _formatDate(String date) {
//     try {
//       DateTime parsedDate = DateTime.parse(date);
//       List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
//       return "${parsedDate.day} ${months[parsedDate.month - 1]} ${parsedDate.year}";
//     } catch (e) {
//       return date;
//     }
//   }
// }
//
// class Joke {
//   final String date;
//   final String patient;
//   final String phone;
//   final String prediction;
//   final String algorithm;
//   final String image;
//   final String result;
//
//   Joke(this.date, this.patient, this.phone, this.prediction, this.algorithm, this.image, this.result);
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class view_results extends StatefulWidget {
  @override
  view_results_state createState() => view_results_state();
}

class view_results_state extends State<view_results> {
  // Color palette from homepage
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

  // get data from python
  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString("url");
    String b = prefs.getString("hid").toString();
    var data = await http.post(
        Uri.parse(url.toString() + "/hosp_view_results"),
        body: {"hid": b}
    );

    var jsonData = json.decode(data.body);
    print(jsonData);
    List<Joke> jokes = [];
    for (var joke in jsonData["data"]) {
      print(joke);
      String fileurl = url.toString() + joke["image"].toString();
      Joke newJoke = Joke(
        joke["date"].toString(),
        joke["patient"],
        joke["phone"].toString(),
        joke["prediction"].toString(),
        joke["algorithm"].toString(),
        fileurl,
        joke["result"].toString(),
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  // Method to show full image dialog
  void _showFullImageDialog(String imageUrl, String patientName, String date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
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
                // Header
                Row(
                  children: [
                    Icon(Icons.image_outlined, color: primary, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patientName,
                            style: poppinsSemiBold.copyWith(
                              color: textColor,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            _formatDate(date),
                            style: poppinsRegular.copyWith(
                              color: primaryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: primaryLight, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Full Image
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: accent,
                    border: Border.all(color: accent.withOpacity(0.8)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: primary,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Loading image...",
                                style: poppinsRegular.copyWith(
                                  color: primaryLight,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image_outlined,
                                size: 48,
                                color: primaryLight,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Failed to load image",
                                style: poppinsRegular.copyWith(
                                  color: primaryLight,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Close Button
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
                          fontSize: 14,
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
    );
  }

  // Method to show result details popup
  void _showResultDialog(Joke result) {
    bool isPositive = result.result.toLowerCase().contains('positive') ||
        result.result.toLowerCase().contains('detected') ||
        result.result.toLowerCase().contains('abnormal');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
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
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: isPositive ? Colors.orange.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isPositive ? Icons.warning_amber_rounded : Icons.check_circle_rounded,
                      size: 40,
                      color: isPositive ? Colors.orange : Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Result Title
                Text(
                  'Diagnosis Result',
                  style: poppinsBold.copyWith(
                    color: textColor,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),

                // Patient Info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person_outline, size: 14, color: primaryLight),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              result.patient,
                              style: poppinsMedium.copyWith(
                                color: textColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 12, color: primaryLight),
                          const SizedBox(width: 6),
                          Text(
                            _formatDate(result.date),
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
                const SizedBox(height: 16),

                // Result Details
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isPositive ? Colors.orange.withOpacity(0.05) : Colors.green.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isPositive ? Colors.orange.withOpacity(0.3) : Colors.green.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Prediction Type:",
                            style: poppinsMedium.copyWith(
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            result.prediction,
                            style: poppinsSemiBold.copyWith(
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Algorithm:",
                            style: poppinsMedium.copyWith(
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              result.algorithm,
                              style: poppinsRegular.copyWith(
                                color: primaryLight,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.right,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Result:",
                            style: poppinsBold.copyWith(
                              color: textColor,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: isPositive ? Colors.orange : Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              result.result,
                              style: poppinsSemiBold.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Close Button
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
                          fontSize: 14,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with back button
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
          onPressed: () => Navigator.pop(context),
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
        child: FutureBuilder(
          future: _getJokes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: primary,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Loading Results...",
                      style: poppinsMedium.copyWith(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 80,
                      color: primaryLight.withOpacity(0.5),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "No Results Found",
                      style: poppinsBold.copyWith(
                        color: textColor,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "AI diagnostic results will appear here",
                      style: poppinsMedium.copyWith(
                        color: primaryLight,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section with Stats
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.all(20),
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
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.analytics_outlined,
                                  size: 30,
                                  color: primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Diagnostic Results",
                                    style: poppinsBold.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${snapshot.data.length} result${snapshot.data.length == 1 ? '' : 's'} available",
                                    style: poppinsMedium.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Results List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Joke result = snapshot.data[index];
                          return _buildResultCard(result, index);
                        },
                      ),

                      const SizedBox(height: 20),

                      // Info Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: accent.withOpacity(0.8)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, color: primaryLight, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Click on any result card to view detailed analysis. Images can be expanded for better viewing.",
                                style: poppinsRegular.copyWith(
                                  color: primaryLight,
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
              );
            }
          },
        ),
      ),
    );
  }

  // Result Card Widget - Cleaner design
  Widget _buildResultCard(Joke result, int index) {
    Color resultColor = _getResultColor(result.result);
    IconData resultIcon = _getResultIcon(result.prediction);
    bool isPositive = result.result.toLowerCase().contains('positive') ||
        result.result.toLowerCase().contains('detected') ||
        result.result.toLowerCase().contains('abnormal');

    return GestureDetector(
      onTap: () => _showResultDialog(result),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header with gradient
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryLight.withOpacity(0.1), primary.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
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
                      child: Icon(resultIcon, color: primary, size: 24),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result.patient,
                          style: poppinsSemiBold.copyWith(
                            color: textColor,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today_outlined, size: 12, color: primaryLight),
                            const SizedBox(width: 4),
                            Text(
                              _formatDate(result.date),
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isPositive ? Colors.orange.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isPositive ? Colors.orange.withOpacity(0.3) : Colors.green.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      result.prediction,
                      style: poppinsMedium.copyWith(
                        color: isPositive ? Colors.orange : Colors.green,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image thumbnail - Clickable to view full image
                  GestureDetector(
                    onTap: () => _showFullImageDialog(result.image, result.patient, result.date),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: accent.withOpacity(0.8)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          result.image,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: accent,
                              child: Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: primary,
                                  ),
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: accent,
                              child: Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  color: primaryLight,
                                  size: 30,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Phone
                        Row(
                          children: [
                            Icon(Icons.phone_outlined, size: 12, color: primaryLight),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                result.phone,
                                style: poppinsRegular.copyWith(
                                  color: primaryLight,
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Algorithm
                        Row(
                          children: [
                            Icon(Icons.settings_outlined, size: 12, color: primaryLight),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                result.algorithm,
                                style: poppinsRegular.copyWith(
                                  color: primaryLight,
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Result badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: resultColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isPositive ? Icons.warning_amber_rounded : Icons.check_circle_rounded,
                                color: resultColor,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                result.result,
                                style: poppinsSemiBold.copyWith(
                                  color: resultColor,
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // View details arrow
                  Icon(
                    Icons.arrow_forward_ios,
                    color: primaryLight,
                    size: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  Color _getResultColor(String result) {
    result = result.toLowerCase();
    if (result.contains('positive') || result.contains('detected') || result.contains('abnormal')) {
      return Colors.orange;
    } else if (result.contains('negative') || result.contains('normal') || result.contains('clear')) {
      return Colors.green;
    } else {
      return primary;
    }
  }

  IconData _getResultIcon(String prediction) {
    prediction = prediction.toLowerCase();
    if (prediction.contains('alzheimer')) {
      return Icons.psychology_outlined;
    } else if (prediction.contains('fracture')) {
      return Icons.broken_image_outlined;
    } else if (prediction.contains('lung')) {
      return Icons.air_outlined;
    } else {
      return Icons.analytics_outlined;
    }
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return "${parsedDate.day} ${months[parsedDate.month - 1]} ${parsedDate.year}";
    } catch (e) {
      return date;
    }
  }
}

class Joke {
  final String date;
  final String patient;
  final String phone;
  final String prediction;
  final String algorithm;
  final String image;
  final String result;

  Joke(this.date, this.patient, this.phone, this.prediction, this.algorithm, this.image, this.result);
}