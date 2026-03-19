// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:typed_data';
// import 'login.dart';
// import 'main.dart';
//
// void main(){
//   return runApp(MaterialApp(
//     home: IPPage(),
//   ));
// }
//
// class IPPage extends StatefulWidget {
//   @override
//   _AdduserState createState() => _AdduserState();
// }
//
// class _AdduserState extends State<IPPage> {
//   final txtFullName = new TextEditingController(text: "10.99.229.195");
//
//   bool _valName=false;
//   bool error=false;
//   var data;
//
//   var holder_1 = [];
//
//   String a1="";
//
//
//
//
//   Future _saveDetails(String ip) async {
//     SharedPreferences prefs =  await SharedPreferences.getInstance();
//     prefs.setString("ip", ip);
//     prefs.setString("url", "http://$ip:6549");
//
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => LoginPage()));
//
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     txtFullName.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("MEDI AI"),
//       ),
//       body:
//       Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: <Widget>[
//
//             TextField(
//               decoration: new InputDecoration(
//                 hintText: "IP Address",
//                 errorText: _valName ? 'Required':null,
//
//               ),
//               controller: txtFullName,
//             ),
//
//
//
//
//             ButtonBar(
//               children:<Widget> [
//                 ElevatedButton(
//                   onPressed:() {
//                     setState(()  {
//                       //for validation
//                       txtFullName.text.isEmpty?_valName=true:_valName=false;
//                       _saveDetails(txtFullName.text);
//                     });
//                   },
//                   // color: Colors.green,
//                   child: Text("Save"),
//
//                 ),
//
//               ],
//             )
//           ],
//
//         ),
//
//       ),
//     );
//   }
// }import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:typed_data';
// import 'login.dart';
// import 'main.dart';
//
// void main(){
//   return runApp(MaterialApp(
//     home: IPPage(),
//   ));
// }
//
// class IPPage extends StatefulWidget {
//   @override
//   _AdduserState createState() => _AdduserState();
// }
//
// class _AdduserState extends State<IPPage> {
//   final txtFullName = new TextEditingController(text: "10.99.229.195");
//
//   bool _valName=false;
//   bool error=false;
//   var data;
//
//   var holder_1 = [];
//
//   String a1="";
//
//
//
//
//   Future _saveDetails(String ip) async {
//     SharedPreferences prefs =  await SharedPreferences.getInstance();
//     prefs.setString("ip", ip);
//     prefs.setString("url", "http://$ip:6549");
//
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => LoginPage()));
//
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     txtFullName.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("MEDI AI"),
//       ),
//       body:
//       Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: <Widget>[
//
//             TextField(
//               decoration: new InputDecoration(
//                 hintText: "IP Address",
//                 errorText: _valName ? 'Required':null,
//
//               ),
//               controller: txtFullName,
//             ),
//
//
//
//
//             ButtonBar(
//               children:<Widget> [
//                 ElevatedButton(
//                   onPressed:() {
//                     setState(()  {
//                       //for validation
//                       txtFullName.text.isEmpty?_valName=true:_valName=false;
//                       _saveDetails(txtFullName.text);
//                     });
//                   },
//                   // color: Colors.green,
//                   child: Text("Save"),
//
//                 ),
//
//               ],
//             )
//           ],
//
//         ),
//
//       ),
//     );
//   }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class ApiService {
  // Define baseUrl as a class property
  static const String baseUrl = 'http://your-api-url.com'; // TODO: Replace with your actual API URL

  // Or make it an instance variable if you need to change it
  // final String baseUrl = 'http://your-api-url.com';

  // Your existing methods...

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/change-password'), // Now baseUrl is defined
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'current_password': currentPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Failed to change password. Status: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e'
      };
    }
  }
}

// If you have a separate ip.dart file for configuration,
// you might have something like this:
class AppConfig {
  static const String ipAddress = '192.168.1.100'; // Your server IP
  static const String port = '3000'; // Your port
  static const String baseUrl = 'http://$ipAddress:$port';

// Or for production
// static const String baseUrl = 'https://your-production-api.com';
}




void main() {
  runApp(MaterialApp(
    home: IPPage(),
  ));
}

class IPPage extends StatefulWidget {
  const IPPage({Key? key}) : super(key: key);

  @override
  State<IPPage> createState() => _IPPageState();
}

class _IPPageState extends State<IPPage> {
  final TextEditingController _ipController = TextEditingController();
  bool _showError = false;
  bool _isLoading = false;
  List<String> _previousIPs = [];

  // Homepage color palette
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
    _loadPreviousIPs();
  }

  Future<void> _loadPreviousIPs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIPs = prefs.getStringList('previous_ips') ?? [];
    final lastUsedIP = prefs.getString('ip');

    setState(() {
      _previousIPs = savedIPs;
      if (lastUsedIP != null && lastUsedIP.isNotEmpty) {
        _ipController.text = lastUsedIP;
      }
    });
  }

  Future<void> _saveDetails(String ip) async {
    if (ip.isEmpty) {
      setState(() {
        _showError = true;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("ip", ip);
      await prefs.setString("url", "http://$ip:6549");

      List<String> previousIPs = prefs.getStringList('previous_ips') ?? [];
      if (!previousIPs.contains(ip)) {
        previousIPs.insert(0, ip);
        if (previousIPs.length > 5) {
          previousIPs = previousIPs.sublist(0, 5);
        }
        await prefs.setStringList('previous_ips', previousIPs);
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      print("Error saving IP: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _usePreviousIP(String ip) {
    setState(() {
      _ipController.text = ip;
      _showError = false;
    });
  }

  void _clearPreviousIPs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('previous_ips');
    setState(() {
      _previousIPs.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('History cleared'),
        backgroundColor: primary,
      ),
    );
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // -------------------------
              // AppBar Section - Matching Homepage
              // -------------------------
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
                    // Logo without container - matching homepage
                    Image.asset(
                      'assets/logoM.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
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
                    const Spacer(),
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
                          Icon(Icons.settings_outlined, color: Colors.white, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            "Server Setup",
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

              // Main Content Area - Clean and minimal like homepage
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section - Simplified like homepage
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Server Configuration",
                            style: poppinsBold.copyWith(
                              color: textColor,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Connect to your MEDI AI server",
                            style: poppinsMedium.copyWith(
                              color: primaryLight,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Quick Stats Section - Matching homepage
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              title: "Saved",
                              value: _previousIPs.length.toString(),
                              subtitle: "Servers",
                              color: primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              title: "Status",
                              value: _previousIPs.isNotEmpty ? "Ready" : "Setup",
                              subtitle: "Connection",
                              color: primaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Configuration Card - Matching homepage service cards
                    Container(
                      width: double.infinity,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                    child: Icon(Icons.computer_outlined, color: primary, size: 24),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Server Connection",
                                        style: poppinsSemiBold.copyWith(
                                          color: textColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Enter your server IP address",
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

                            // IP Input Field - Matching homepage inputs
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Server IP Address",
                                  style: poppinsMedium.copyWith(
                                    color: textColor,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _showError ? Colors.red : accent.withOpacity(0.8),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.03),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: _ipController,
                                    style: poppinsMedium.copyWith(
                                      color: textColor,
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'e.g., 10.99.229.195',
                                      hintStyle: poppinsRegular.copyWith(
                                        color: primaryLight.withOpacity(0.6),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.dns_outlined,
                                        color: primary,
                                        size: 20,
                                      ),
                                      errorText: _showError ? 'IP address is required' : null,
                                    ),
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    onChanged: (value) {
                                      if (_showError && value.isNotEmpty) {
                                        setState(() => _showError = false);
                                      }
                                    },
                                  ),
                                ),
                                if (_showError)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4, left: 4),
                                    child: Text(
                                      'Please enter a valid IP address',
                                      style: poppinsRegular.copyWith(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Previous IPs - Matching homepage tags
                            if (_previousIPs.isNotEmpty) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Recent Servers",
                                        style: poppinsSemiBold.copyWith(
                                          color: textColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: _clearPreviousIPs,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: accent,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            'Clear',
                                            style: poppinsMedium.copyWith(
                                              color: primaryLight,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: _previousIPs.map((ip) {
                                      return InkWell(
                                        onTap: () => _usePreviousIP(ip),
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: accent,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: primary.withOpacity(0.1),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.02),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.history_outlined,
                                                size: 14,
                                                color: primary,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                ip,
                                                style: poppinsMedium.copyWith(
                                                  color: primary,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ],

                            // Connect Button - Matching homepage buttons
                            Container(
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
                                    final ip = _ipController.text.trim();
                                    if (ip.isEmpty) {
                                      setState(() => _showError = true);
                                      return;
                                    }
                                    _saveDetails(ip);
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    child: Center(
                                      child: _isLoading
                                          ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                          : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.link_outlined, color: Colors.white, size: 18),
                                          const SizedBox(width: 8),
                                          Text(
                                            'CONNECT TO SERVER',
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
                          ],
                        ),
                      ),
                    ),

                    // Info Section - Matching homepage info cards
                    const SizedBox(height: 20),
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
                                  "Server Information",
                                  style: poppinsSemiBold.copyWith(
                                    color: textColor,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Enter the IP address where your MEDI AI server is running. Make sure the server is active and accessible.",
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

                    // Additional spacing at bottom
                    const SizedBox(height: 40),
                  ],
                ),
              ),

              // -------------------------
              // Bottom Info Bar - Matching Homepage
              // -------------------------
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
                              "Secure Connection",
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

  // Helper method for stat cards - Matching Homepage
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
              fontSize: 20,
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