// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main(){
//   return runApp(
//       MaterialApp(home:hosp_view_profile(),
//         debugShowCheckedModeBanner: false,)
//   );
// }
// class hosp_view_profile extends StatefulWidget{
//   @override
//   hosp_view_profile_state createState()=>hosp_view_profile_state();
//
// }
//
//
// class hosp_view_profile_state extends State<hosp_view_profile>{
//
//   // get data from python
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? url=prefs.getString("url");
//     String foodimage="";
//     var data =
//     await http.post(Uri.parse(url.toString()+"/hosp_view_profile"),
//         body: {"hid":prefs.getString("hid")}
//     );
//
//     var jsonData = json.decode(data.body);
//    print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["data"]) {
//       print(joke);
//       Joke newJoke = Joke(
//           joke["name"].toString(),
//           joke["phone"],
//           joke["email"],
//           joke["place"],
//           joke["district"],
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Medi AI'),
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//       ),
//
//
//       backgroundColor: Colors.black54,
//       body:
//
//
//       Container(
//
//         child:
//         FutureBuilder(
//           future: _getJokes(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
// //              print("snapshot"+snapshot.toString());
//             if (snapshot.data == null) {
//               return Container(
//                 child: Center(
//                   child: Text("Loading..."),
//                 ),
//               );
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         side: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//
//                             SizedBox(height: 10),
//                             _buildRow("name:", snapshot.data[index].name.toString()),
//                             _buildRow("email:", snapshot.data[index].email.toString()),
//                             _buildRow("place:", snapshot.data[index].place.toString()),
//                             _buildRow("district:", snapshot.data[index].district.toString()),
//                             _buildRow("phone:", snapshot.data[index].phone.toString()),
//                             // Row(
//                             //   children: [
//                             //     ElevatedButton(
//                             //     style: ButtonStyle(
//                             //       backgroundColor: MaterialStateProperty.all(Colors.black), // Background color
//                             //       foregroundColor: MaterialStateProperty.all(Colors.white), // Text color
//                             //     ),
//                             //     child: Text('Request Assistance'),
//                             //     onPressed: (){
//                             //       var idx=snapshot.data[index].id.toString();
//                             //       _sendRequest(idx);
//                             //     },
//                             //   ),
//                             // ],)
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//
//
//             }
//           },
//
//
//         ),
//
//
//
//
//
//       ),
//     );
//   }
//
//   Widget _buildRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(width: 5),
//           Flexible(
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: Colors.grey.shade800,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class Joke {
//   final String name;
//   final String email;
//   final String place;
//   final String district;
//   final String phone;
//
//
//   Joke(this.name,this.district,this.email,this.place,this.phone);
// //  print("hiiiii");
// }

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  return runApp(
      MaterialApp(
        home: hosp_view_profile(),
        debugShowCheckedModeBanner: false,
      )
  );
}

class hosp_view_profile extends StatefulWidget {
  @override
  hosp_view_profile_state createState() => hosp_view_profile_state();
}

class hosp_view_profile_state extends State<hosp_view_profile> {
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
    var data = await http.post(
        Uri.parse(url.toString() + "/hosp_view_profile"),
        body: {"hid": prefs.getString("hid")}
    );

    var jsonData = json.decode(data.body);
    print(jsonData);
    List<Joke> jokes = [];
    for (var joke in jsonData["data"]) {
      print(joke);
      Joke newJoke = Joke(
        joke["name"].toString(),
        joke["phone"],
        joke["email"],
        joke["place"],
        joke["district"],
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
                      "Loading Profile...",
                      style: poppinsMedium.copyWith(
                        color: textColor,
                        fontSize: 16,
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
                      // Profile Header
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
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: Colors.white, width: 3),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: 40,
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
                                    snapshot.data[0].name.toString(),
                                    style: poppinsBold.copyWith(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Hospital Profile",
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

                      // Profile Details Card
                      Container(
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
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hospital Details",
                                style: poppinsBold.copyWith(
                                  color: textColor,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 20),

                              _buildProfileRow(
                                icon: Icons.email_outlined,
                                label: "Email Address",
                                value: snapshot.data[0].email.toString(),
                                color: primary,
                              ),
                              SizedBox(height: 16),

                              _buildProfileRow(
                                icon: Icons.phone_outlined,
                                label: "Phone Number",
                                value: snapshot.data[0].phone.toString(),
                                color: primaryLight,
                              ),
                              SizedBox(height: 16),

                              _buildProfileRow(
                                icon: Icons.location_on_outlined,
                                label: "Location",
                                value: "${snapshot.data[0].place.toString()}, ${snapshot.data[0].district.toString()}",
                                color: primaryDark,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Info Cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              icon: Icons.badge_outlined,
                              title: "Hospital ID",
                              value: "HSP-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
                              color: primary,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildInfoCard(
                              icon: Icons.verified_outlined,
                              title: "Status",
                              value: "Active",
                              color: Color(0xFF32CD32),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Additional Info
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
                                  "Profile information is fetched from the hospital database",
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

  // Profile Row Widget
  Widget _buildProfileRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(icon, color: color, size: 20),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: poppinsMedium.copyWith(
                      color: textColor.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: poppinsSemiBold.copyWith(
                      color: textColor,
                      fontSize: 16,
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

  // Info Card Widget
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(icon, color: color, size: 20),
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: poppinsMedium.copyWith(
                color: color,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: poppinsBold.copyWith(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Joke {
  final String name;
  final String email;
  final String place;
  final String district;
  final String phone;

  Joke(this.name, this.district, this.email, this.place, this.phone);
}