// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   return runApp(
//       MaterialApp(
//         home: hosp_view_notify(),
//         debugShowCheckedModeBanner: false,
//       )
//   );
// }
//
// class hosp_view_notify extends StatefulWidget {
//   @override
//   hosp_view_notify_state createState() => hosp_view_notify_state();
// }
//
// class hosp_view_notify_state extends State<hosp_view_notify> {
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
//         Uri.parse(url.toString() + "/hosp_view_notify"),
//         body: {"lid": b}
//     );
//
//     var jsonData = json.decode(data.body);
//     print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["data"]) {
//       print(joke);
//       Joke newJoke = Joke(
//         joke["date"].toString(),
//         joke["notification"],
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
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: primary.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: FutureBuilder(
//                 future: _getJokes(),
//                 builder: (context, snapshot) {
//                   int count = snapshot.hasData ? snapshot.data!.length : 0;
//                   return Text(
//                     "$count",
//                     style: poppinsSemiBold.copyWith(
//                       color: primary,
//                       fontSize: 12,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
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
//                       "Loading Notifications...",
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
//                       Icons.notifications_none_outlined,
//                       size: 80,
//                       color: primaryLight.withOpacity(0.5),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "No Notifications",
//                       style: poppinsBold.copyWith(
//                         color: textColor,
//                         fontSize: 20,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "You're all caught up!",
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
//                                   Icons.notifications_active_outlined,
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
//                                     "Notifications",
//                                     style: poppinsBold.copyWith(
//                                       color: Colors.white,
//                                       fontSize: 22,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     "${snapshot.data.length} unread notification${snapshot.data.length == 1 ? '' : 's'}",
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
//                       // Notifications List
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return _buildNotificationCard(
//                             date: snapshot.data[index].date.toString(),
//                             notification: snapshot.data[index].notification.toString(),
//                             index: index,
//                           );
//                         },
//                       ),
//
//                       SizedBox(height: 20),
//
//                       // Info Card
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
//                               Icon(Icons.info_outline, color: primaryLight, size: 24),
//                               SizedBox(width: 12),
//                               Expanded(
//                                 child: Text(
//                                   "Notifications include system updates, alerts, and important announcements",
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
//   // Notification Card Widget
//   Widget _buildNotificationCard({
//     required String date,
//     required String notification,
//     required int index,
//   }) {
//     bool isRecent = _isRecentNotification(date);
//     Color notificationColor = isRecent ? Color(0xFFE74C3C) : primary;
//     IconData notificationIcon = _getNotificationIcon(notification);
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
//       child: Stack(
//         children: [
//           // Main Content
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header Row
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: notificationColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: Icon(notificationIcon, color: notificationColor, size: 20),
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             _formatDate(date),
//                             style: poppinsMedium.copyWith(
//                               color: primaryLight,
//                               fontSize: 12,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             notification,
//                             style: poppinsSemiBold.copyWith(
//                               color: textColor,
//                               fontSize: 15,
//                               height: 1.4,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 16),
//
//                 // Time and Status
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: notificationColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.access_time_outlined, size: 12, color: notificationColor),
//                           SizedBox(width: 4),
//                           Text(
//                             _formatTime(date),
//                             style: poppinsMedium.copyWith(
//                               color: notificationColor,
//                               fontSize: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Spacer(),
//                     if (isRecent)
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Color(0xFFE74C3C).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           "NEW",
//                           style: poppinsSemiBold.copyWith(
//                             color: Color(0xFFE74C3C),
//                             fontSize: 10,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           // Timeline connector (for first item)
//           if (index == 0)
//             Positioned(
//               left: 30,
//               top: 0,
//               bottom: 0,
//               child: Container(
//                 width: 2,
//                 color: primary.withOpacity(0.2),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // Helper methods
//   bool _isRecentNotification(String date) {
//     try {
//       DateTime notificationDate = DateTime.parse(date);
//       DateTime now = DateTime.now();
//       Duration difference = now.difference(notificationDate);
//       return difference.inHours < 24; // Notifications from last 24 hours are "recent"
//     } catch (e) {
//       return false;
//     }
//   }
//
//   IconData _getNotificationIcon(String notification) {
//     notification = notification.toLowerCase();
//     if (notification.contains('alert') || notification.contains('urgent') || notification.contains('important')) {
//       return Icons.warning_outlined;
//     } else if (notification.contains('update') || notification.contains('system') || notification.contains('maintenance')) {
//       return Icons.system_update_outlined;
//     } else if (notification.contains('success') || notification.contains('completed')) {
//       return Icons.check_circle_outlined;
//     } else if (notification.contains('error') || notification.contains('failed')) {
//       return Icons.error_outline_outlined;
//     } else {
//       return Icons.notifications_outlined;
//     }
//   }
//
//   String _formatDate(String date) {
//     try {
//       DateTime parsedDate = DateTime.parse(date);
//
//       // Check if it's today
//       DateTime now = DateTime.now();
//       if (parsedDate.year == now.year &&
//           parsedDate.month == now.month &&
//           parsedDate.day == now.day) {
//         return "Today";
//       }
//
//       // Check if it's yesterday
//       DateTime yesterday = now.subtract(Duration(days: 1));
//       if (parsedDate.year == yesterday.year &&
//           parsedDate.month == yesterday.month &&
//           parsedDate.day == yesterday.day) {
//         return "Yesterday";
//       }
//
//       // Otherwise show date
//       return "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
//     } catch (e) {
//       return date;
//     }
//   }
//
//   String _formatTime(String date) {
//     try {
//       DateTime parsedDate = DateTime.parse(date);
//       String hour = parsedDate.hour.toString().padLeft(2, '0');
//       String minute = parsedDate.minute.toString().padLeft(2, '0');
//       return "$hour:$minute";
//     } catch (e) {
//       return "";
//     }
//   }
// }
//
// class Joke {
//   final String date;
//   final String notification;
//
//   Joke(this.date, this.notification);
// }

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  return runApp(
      MaterialApp(
        home: hosp_view_notify(),
        debugShowCheckedModeBanner: false,
      )
  );
}

class hosp_view_notify extends StatefulWidget {
  @override
  hosp_view_notify_state createState() => hosp_view_notify_state();
}

class hosp_view_notify_state extends State<hosp_view_notify> {
  // Color palette from homepage
  final Color primaryDark = const Color(0xFF1B3C53);
  final Color primary = const Color(0xFF2A5170);
  final Color primaryLight = const Color(0xFF4A7696);
  final Color accent = const Color(0xFFF0F4F8);
  final Color textColor = const Color(0xFF1E3A5F);

  // Change red to a softer red/orange color
  final Color notificationNewColor = const Color(0xFFE67E22); // Orange color instead of red

  // Store last viewed time
  DateTime? _lastViewedTime;
  List<Joke> _notifications = [];
  bool _isLoading = true;
  Map<String, bool> _newStatusMap = {};

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
  Future<void> _loadNotifications() async {
    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      String b = prefs.getString("lid").toString();

      // Load last viewed time
      String? lastViewedStr = prefs.getString('last_viewed_time');
      _lastViewedTime = lastViewedStr != null ? DateTime.parse(lastViewedStr) : null;

      var data = await http.post(
          Uri.parse(url.toString() + "/hosp_view_notify"),
          body: {"lid": b}
      );

      var jsonData = json.decode(data.body);
      print("Raw JSON data: $jsonData");

      List<Joke> jokes = [];
      if (jsonData["data"] != null) {
        for (var joke in jsonData["data"]) {
          print("Processing joke: $joke");
          Joke newJoke = Joke(
            joke["date"].toString(),
            joke["notification"].toString(),
          );
          jokes.add(newJoke);
        }
      }

      // Sort notifications by date (newest first) - ENSURING NEWEST FIRST
      jokes.sort((a, b) {
        try {
          // Parse dates - handle different formats if needed
          DateTime dateA = _parseDate(a.date);
          DateTime dateB = _parseDate(b.date);

          print("Comparing: ${dateA.toIso8601String()} vs ${dateB.toIso8601String()}");

          // Return negative if a should come before b (newer dates first)
          // This puts newest first (descending order)
          return dateB.compareTo(dateA);
        } catch (e) {
          print("Error parsing date: $e");
          return 0;
        }
      });

      // Print sorted dates to verify order
      print("SORTED NOTIFICATIONS (Newest First):");
      for (int i = 0; i < jokes.length; i++) {
        print("${i+1}. Date: ${jokes[i].date} - ${jokes[i].notification}");
      }

      // Determine which notifications are new
      Map<String, bool> newStatus = {};
      for (var joke in jokes) {
        try {
          DateTime notifDate = _parseDate(joke.date);
          bool isNew = _lastViewedTime != null && notifDate.isAfter(_lastViewedTime!);
          newStatus[joke.date] = isNew;
          print("Notification ${joke.date} is new: $isNew");
        } catch (e) {
          newStatus[joke.date] = false;
        }
      }

      setState(() {
        _notifications = jokes;
        _newStatusMap = newStatus;
        _isLoading = false;
      });

      // Mark as viewed after loading
      await _markNotificationsAsViewed();

    } catch (e) {
      print("Error loading notifications: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Helper method to parse dates in different formats
  DateTime _parseDate(String dateStr) {
    try {
      // Try standard ISO format first
      return DateTime.parse(dateStr);
    } catch (e) {
      try {
        // Try format like "2024-02-24 14:30:00"
        List<String> parts = dateStr.split(' ');
        if (parts.length >= 2) {
          List<String> dateParts = parts[0].split('-');
          List<String> timeParts = parts[1].split(':');

          if (dateParts.length == 3 && timeParts.length >= 2) {
            int year = int.parse(dateParts[0]);
            int month = int.parse(dateParts[1]);
            int day = int.parse(dateParts[2]);
            int hour = int.parse(timeParts[0]);
            int minute = int.parse(timeParts[1]);
            int second = timeParts.length > 2 ? int.parse(timeParts[2]) : 0;

            return DateTime(year, month, day, hour, minute, second);
          }
        }
      } catch (e2) {
        print("Error parsing custom date format: $e2");
      }

      // If all else fails, return a default date (old date)
      return DateTime(2000, 1, 1);
    }
  }

  // Mark notifications as viewed when page is opened
  Future<void> _markNotificationsAsViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentTime = DateTime.now().toIso8601String();
    await prefs.setString('last_viewed_time', currentTime);
    setState(() {
      _lastViewedTime = DateTime.parse(currentTime);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNotifications();
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "${_notifications.length}",
                style: poppinsSemiBold.copyWith(
                  color: primary,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
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
        child: _isLoading
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: primary,
              ),
              SizedBox(height: 20),
              Text(
                "Loading Notifications...",
                style: poppinsMedium.copyWith(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        )
            : _notifications.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_none_outlined,
                size: 80,
                color: primaryLight.withOpacity(0.5),
              ),
              SizedBox(height: 20),
              Text(
                "No Notifications",
                style: poppinsBold.copyWith(
                  color: textColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "You're all caught up!",
                style: poppinsMedium.copyWith(
                  color: primaryLight,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        )
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
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
                            Icons.notifications_active_outlined,
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
                              "Notifications",
                              style: poppinsBold.copyWith(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${_notifications.length} notification${_notifications.length == 1 ? '' : 's'}",
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

                // Notifications List
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    Joke notification = _notifications[index];
                    bool isNew = _newStatusMap[notification.date] ?? false;

                    return _buildNotificationCard(
                      date: notification.date,
                      notification: notification.notification,
                      isNew: isNew,
                      index: index,
                    );
                  },
                ),

                SizedBox(height: 20),

                // Info Card
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
                        Icon(Icons.info_outline, color: primaryLight, size: 24),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Notifications include system updates, alerts, and important announcements",
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
        ),
      ),
    );
  }

  // Notification Card Widget
  Widget _buildNotificationCard({
    required String date,
    required String notification,
    required bool isNew,
    required int index,
  }) {
    Color notificationColor = isNew ? notificationNewColor : primaryLight;
    IconData notificationIcon = _getNotificationIcon(notification);

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
        // Add a subtle border for new notifications
        border: isNew ? Border.all(color: notificationNewColor.withOpacity(0.3), width: 1) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: notificationColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(notificationIcon, color: notificationColor, size: 20),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Show date
                      Text(
                        _formatDate(date),
                        style: poppinsMedium.copyWith(
                          color: isNew ? notificationColor : primaryLight,
                          fontSize: 12,
                          fontWeight: isNew ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        notification,
                        style: poppinsSemiBold.copyWith(
                          color: textColor,
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Status Row
            Row(
              children: [
                Spacer(),
                if (isNew)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: notificationNewColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "NEW",
                      style: poppinsSemiBold.copyWith(
                        color: notificationNewColor,
                        fontSize: 10,
                      ),
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
  IconData _getNotificationIcon(String notification) {
    notification = notification.toLowerCase();
    if (notification.contains('alert') || notification.contains('urgent') || notification.contains('important')) {
      return Icons.warning_outlined;
    } else if (notification.contains('update') || notification.contains('system') || notification.contains('maintenance')) {
      return Icons.system_update_outlined;
    } else if (notification.contains('success') || notification.contains('completed')) {
      return Icons.check_circle_outlined;
    } else if (notification.contains('error') || notification.contains('failed')) {
      return Icons.error_outline_outlined;
    } else {
      return Icons.notifications_outlined;
    }
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = _parseDate(date);

      // Check if it's today
      DateTime now = DateTime.now();
      if (parsedDate.year == now.year &&
          parsedDate.month == now.month &&
          parsedDate.day == now.day) {
        return "Today";
      }

      // Check if it's yesterday
      DateTime yesterday = now.subtract(Duration(days: 1));
      if (parsedDate.year == yesterday.year &&
          parsedDate.month == yesterday.month &&
          parsedDate.day == yesterday.day) {
        return "Yesterday";
      }

      // Otherwise show date
      return "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
    } catch (e) {
      return date;
    }
  }
}

class Joke {
  final String date;
  final String notification;

  Joke(this.date, this.notification);
}