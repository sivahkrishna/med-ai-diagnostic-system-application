// // import 'dart:convert';
// //
// // import 'package:http/http.dart' as http;
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // void main(){
// //   return runApp(
// //       MaterialApp(home:view_feedback(),
// //         debugShowCheckedModeBanner: false,)
// //   );
// // }
// // class view_feedback extends StatefulWidget{
// //   @override
// //   view_feedback_state createState()=>view_feedback_state();
// //
// // }
// //
// //
// // class view_feedback_state extends State<view_feedback>{
// //
// //   // get data from python
// //   Future<List<Joke>> _getJokes() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     String? url=prefs.getString("url");
// //     String b = prefs.getString("lid").toString();
// //     String foodimage="";
// //     var data =
// //     await http.post(Uri.parse(url.toString()+"/hosp_view_feedback"),
// //         body: {"lid":b}
// //     );
// //
// //     var jsonData = json.decode(data.body);
// //    print(jsonData);
// //     List<Joke> jokes = [];
// //     for (var joke in jsonData["data"]) {
// //       print(joke);
// //       Joke newJoke = Joke(
// //           joke["date"].toString(),
// //           joke["feedback"],
// //           joke["hospname"].toString(),
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
// //                             _buildRow("Date:", snapshot.data[index].date.toString()),
// //                             _buildRow("Feedback:", snapshot.data[index].feedback.toString()),
// //                             _buildRow("Hospital Name:", snapshot.data[index].hospname.toString()),
// //                             // Row(
// //                             //   children: [
// //                             //     ElevatedButton(
// //                             //     style: ButtonStyle(
// //                             //       backgroundColor: MaterialStateProperty.all(Colors.black), // Background color
// //                             //       foregroundColor: MaterialStateProperty.all(Colors.white), // Text color
// //                             //     ),
// //                             //     child: Text('Request Assistance'),
// //                             //     onPressed: (){
// //                             //       var idx=snapshot.data[index].id.toString();
// //                             //       _sendRequest(idx);
// //                             //     },
// //                             //   ),
// //                             // ],)
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
// //             width: 100,
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
// //   final String feedback;
// //   final String hospname;
// //
// //
// //   Joke(this.date,this.feedback, this.hospname);
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
// void main() {
//   return runApp(
//       MaterialApp(
//         home: view_feedback(),
//         debugShowCheckedModeBanner: false,
//       )
//   );
// }
//
// class view_feedback extends StatefulWidget {
//   @override
//   view_feedback_state createState() => view_feedback_state();
// }
//
// class view_feedback_state extends State<view_feedback> {
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
//   // get data from python
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? url = prefs.getString("url");
//     String b = prefs.getString("lid").toString();
//     var data = await http.post(
//         Uri.parse(url.toString() + "/hosp_view_feedback"),
//         body: {"hid": prefs.getString("hid")}
//     );
//
//     var jsonData = json.decode(data.body);
//     print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["data"]) {
//       print(joke);
//       Joke newJoke = Joke(
//         joke["date"].toString(),
//         joke["feedback"],
//         joke["hospname"].toString(),
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
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               accent.withOpacity(0.3),
//               Colors.white,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: FutureBuilder(
//           future: _getJokes(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.data == null) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(
//                       color: primary,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Loading Feedback...",
//                       style: poppinsMedium.copyWith(
//                         color: textColor,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (snapshot.data.isEmpty) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.feedback_outlined,
//                       size: 80,
//                       color: primaryLight.withOpacity(0.5),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "No Feedback Yet",
//                       style: poppinsBold.copyWith(
//                         color: textColor,
//                         fontSize: 20,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "Hospital feedback will appear here",
//                       style: poppinsMedium.copyWith(
//                         color: primaryLight,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Header Section
//                       Container(
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [primaryLight, primary],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 10,
//                               offset: Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 60,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(30),
//                                 border: Border.all(color: Colors.white, width: 3),
//                               ),
//                               child: Center(
//                                 child: Icon(
//                                   Icons.feedback_outlined,
//                                   size: 30,
//                                   color: primary,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 20),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Recent Review",
//                                     style: poppinsBold.copyWith(
//                                       color: Colors.white,
//                                       fontSize: 22,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     "Total ${snapshot.data.length} feedback entries",
//                                     style: poppinsMedium.copyWith(
//                                       color: Colors.white.withOpacity(0.9),
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       SizedBox(height: 24),
//
//                       // Feedback List
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return _buildFeedbackCard(
//                             date: snapshot.data[index].date.toString(),
//                             feedback: snapshot.data[index].feedback.toString(),
//                             hospitalName: snapshot.data[index].hospname.toString(),
//                             index: index,
//                           );
//                         },
//                       ),
//
//                       SizedBox(height: 20),
//
//                       // Summary Card
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: accent.withOpacity(0.5)),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Row(
//                             children: [
//                               Icon(Icons.insights_outlined, color: primaryLight, size: 24),
//                               SizedBox(width: 12),
//                               Expanded(
//                                 child: Text(
//                                   "Viewing all hospital feedback for quality improvement",
//                                   style: poppinsRegular.copyWith(
//                                     color: primaryLight,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   // Feedback Card Widget
//   Widget _buildFeedbackCard({
//     required String date,
//     required String feedback,
//     required String hospitalName,
//     required int index,
//   }) {
//     Color cardColor = _getCardColor(index);
//     IconData feedbackIcon = _getFeedbackIcon(feedback);
//
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
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
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Row
//             Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: cardColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Icon(feedbackIcon, color: cardColor, size: 20),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         _formatDate(date),
//                         style: poppinsSemiBold.copyWith(
//                           color: textColor,
//                           fontSize: 14,
//                         ),
//                       ),
//                       SizedBox(height: 2),
//                       Text(
//                         hospitalName,
//                         style: poppinsMedium.copyWith(
//                           color: primaryLight,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: cardColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     "Feedback",
//                     style: poppinsMedium.copyWith(
//                       color: cardColor,
//                       fontSize: 10,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 16),
//
//             // Feedback Content
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: accent.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.format_quote_outlined, color: cardColor, size: 16),
//                       SizedBox(width: 8),
//                       Text(
//                         "Hospital Feedback",
//                         style: poppinsMedium.copyWith(
//                           color: cardColor,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     feedback,
//                     style: poppinsRegular.copyWith(
//                       color: textColor,
//                       fontSize: 14,
//                       height: 1.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 16),
//
//             // Footer
//             Row(
//               children: [
//                 Icon(Icons.calendar_today_outlined, size: 14, color: primaryLight),
//                 SizedBox(width: 6),
//                 Text(
//                   "Submitted: $date",
//                   style: poppinsRegular.copyWith(
//                     color: primaryLight,
//                     fontSize: 11,
//                   ),
//                 ),
//                 Spacer(),
//                 Icon(Icons.business_outlined, size: 14, color: primaryLight),
//                 SizedBox(width: 6),
//                 Text(
//                   "Hospital",
//                   style: poppinsRegular.copyWith(
//                     color: primaryLight,
//                     fontSize: 11,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Helper methods
//   Color _getCardColor(int index) {
//     List<Color> colors = [primary, primaryLight, primaryDark, Color(0xFF6A5ACD)];
//     return colors[index % colors.length];
//   }
//
//   IconData _getFeedbackIcon(String feedback) {
//     feedback = feedback.toLowerCase();
//     if (feedback.contains('good') || feedback.contains('excellent') || feedback.contains('great')) {
//       return Icons.thumb_up_outlined;
//     } else if (feedback.contains('bad') || feedback.contains('poor') || feedback.contains('terrible')) {
//       return Icons.thumb_down_outlined;
//     } else if (feedback.contains('suggestion') || feedback.contains('improve')) {
//       return Icons.lightbulb_outlined;
//     } else {
//       return Icons.chat_bubble_outlined;
//     }
//   }
//
//   String _formatDate(String date) {
//     try {
//       DateTime parsedDate = DateTime.parse(date);
//       return "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
//     } catch (e) {
//       return date;
//     }
//   }
//
//   String _formatFullDate(String date) {
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
//   final String feedback;
//   final String hospname;
//
//   Joke(this.date, this.feedback, this.hospname);
// }
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  return runApp(
      MaterialApp(
        home: view_feedback(),
        debugShowCheckedModeBanner: false,
      )
  );
}

class view_feedback extends StatefulWidget {
  @override
  view_feedback_state createState() => view_feedback_state();
}

class view_feedback_state extends State<view_feedback> {
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
    String b = prefs.getString("lid").toString();
    var data = await http.post(
        Uri.parse(url.toString() + "/hosp_view_feedback"),
        body: {"hid": prefs.getString("hid")}
    );

    var jsonData = json.decode(data.body);
    print(jsonData);
    List<Joke> jokes = [];
    for (var joke in jsonData["data"]) {
      print(joke);
      Joke newJoke = Joke(
        joke["date"].toString(),
        joke["feedback"],
        joke["hospname"].toString(),
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -------------------------
      // AppBar matching homepage theme
      // -------------------------
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/logoM.png',
                  fit: BoxFit.contain,
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
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: 'AI',
                    style: poppinsBold.copyWith(
                      color: primaryLight,
                      fontSize: 18,
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
        centerTitle: false,
      ),

      // -------------------------
      // Body with homepage theme
      // -------------------------
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accent.withOpacity(0.3),
              Colors.white,
            ],
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
                    SizedBox(height: 20),
                    Text(
                      "Loading Feedback...",
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
                      Icons.feedback_outlined,
                      size: 80,
                      color: primaryLight.withOpacity(0.5),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No Feedback Yet",
                      style: poppinsBold.copyWith(
                        color: textColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Hospital feedback will appear here",
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
                      // Header Section - Changed icon from feedback_outlined to star_rounded
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryLight, primary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 4),
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
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.white, width: 3),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.star_rounded, // Changed from feedback_outlined to star_rounded
                                  size: 30,
                                  color: primary,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Recent Review",
                                    style: poppinsBold.copyWith(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Total ${snapshot.data.length} feedback entries",
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

                      SizedBox(height: 24),

                      // Feedback List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildFeedbackCard(
                            date: snapshot.data[index].date.toString(),
                            feedback: snapshot.data[index].feedback.toString(),
                            hospitalName: snapshot.data[index].hospname.toString(),
                            index: index,
                          );
                        },
                      ),

                      SizedBox(height: 20),

                      // Summary Card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: accent.withOpacity(0.5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(Icons.insights_outlined, color: primaryLight, size: 24),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Viewing all hospital feedback for quality improvement",
                                  style: poppinsRegular.copyWith(
                                    color: primaryLight,
                                    fontSize: 12,
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
              );
            }
          },
        ),
      ),
    );
  }

  // Feedback Card Widget
  Widget _buildFeedbackCard({
    required String date,
    required String feedback,
    required String hospitalName,
    required int index,
  }) {
    Color cardColor = _getCardColor(index);
    IconData feedbackIcon = _getFeedbackIcon(feedback);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(feedbackIcon, color: cardColor, size: 20),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(date),
                        style: poppinsSemiBold.copyWith(
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        hospitalName,
                        style: poppinsMedium.copyWith(
                          color: primaryLight,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Feedback",
                    style: poppinsMedium.copyWith(
                      color: cardColor,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Feedback Content
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.format_quote_outlined, color: cardColor, size: 16),
                      SizedBox(width: 8),
                      Text(
                        "Hospital Feedback",
                        style: poppinsMedium.copyWith(
                          color: cardColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    feedback,
                    style: poppinsRegular.copyWith(
                      color: textColor,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Footer
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 14, color: primaryLight),
                SizedBox(width: 6),
                Text(
                  "Submitted: $date",
                  style: poppinsRegular.copyWith(
                    color: primaryLight,
                    fontSize: 11,
                  ),
                ),
                Spacer(),
                Icon(Icons.business_outlined, size: 14, color: primaryLight),
                SizedBox(width: 6),
                Text(
                  "Hospital",
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
    );
  }

  // Helper methods
  Color _getCardColor(int index) {
    List<Color> colors = [primary, primaryLight, primaryDark, Color(0xFF6A5ACD)];
    return colors[index % colors.length];
  }

  IconData _getFeedbackIcon(String feedback) {
    feedback = feedback.toLowerCase();
    if (feedback.contains('good') || feedback.contains('excellent') || feedback.contains('great')) {
      return Icons.thumb_up_outlined;
    } else if (feedback.contains('bad') || feedback.contains('poor') || feedback.contains('terrible')) {
      return Icons.thumb_down_outlined;
    } else if (feedback.contains('suggestion') || feedback.contains('improve')) {
      return Icons.lightbulb_outlined;
    } else {
      return Icons.chat_bubble_outlined;
    }
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
    } catch (e) {
      return date;
    }
  }

  String _formatFullDate(String date) {
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
  final String feedback;
  final String hospname;

  Joke(this.date, this.feedback, this.hospname);
}