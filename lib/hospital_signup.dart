// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:typed_data';
// import 'login.dart';
// import 'main.dart';
//
// void main(){
//   return runApp(MaterialApp(
//     home: hpspital_signup(),
//   ));
// }
//
// class hpspital_signup extends StatefulWidget {
//   @override
//   _AdduserState createState() => _AdduserState();
// }
//
// class _AdduserState extends State<hpspital_signup> {
//   final txtFullName = new TextEditingController();
//   final txtEmail = new TextEditingController();
//   final txtPhone = new TextEditingController();
//   final txtPlace = new TextEditingController();
//   final txtDistrict = new TextEditingController();
//   final txtPassword = new TextEditingController();
//
//   bool _valName=false;
//   bool _valEmail=false;
//   bool _valPhone=false;
//   bool _valPlace=false;
//   bool _valDistrict=false;
//   bool _valPassword=false;
//
//
//   String countryname="", message="";
//   bool error=false;
//   String onlineImage = '';
//   String? localmage="";
//
//
//
//
//   Future<String> pickImage() async {
//     // XFile is now recommended to use with ImagePicker
//     XFile? xfile;
//
//     // This Line of Code will pick the image from your gallery
//     xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     //Our XFile variable is nullable so we've to check if we've picked the image or not
//     if (xfile != null) {
//       // Now we're converting our image into Uint8List
//       Uint8List bytes = await xfile.readAsBytes();
//
//       // Here we're converting our image to Base64
//       String encode = base64Encode(bytes);
//
//       // Returning Base64 Encoded Image
//       return encode;
//     } else {
//       print('Pick Image First');
//       return 'Error';
//     }
//   }
//
//   Future _saveDetails(String name, String email, String phone, String place, String district, String password) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? url = prefs.getString("url");
//     var data = await http.post(Uri.parse(url.toString() + "/hosp_register"),
//         body: {"name":name,"email":email,"phone":phone,"place":place,"district":district, "lati":"11.7654", "longi":"75.98765",
//           "password":password.toString(),'image':localmage});
//     var res=data.body;
//     var jsondata=jsonDecode(res);
//     print("Response");
//     print(jsondata);
//     if(jsondata['status']== "ok")
//       {
//         Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
//
//       }
//     else{
//       print("Error"+res);
//     }
//   }
//
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     txtEmail.dispose();
//     txtFullName.dispose();
//     txtPlace.dispose();
//     txtPhone.dispose();
//     txtDistrict.dispose();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Registration"),
//       ),
//       body:
//       Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: <Widget>[
//
//             TextField(
//               decoration: new InputDecoration(
//                 hintText: "Name",
//                 errorText: _valName ? 'Required':null,
//
//               ),
//               controller: txtFullName,
//             ),
//
//         TextField(
//                 controller: txtEmail,
//           decoration: new InputDecoration(
//           hintText: "Email",
//             errorText: _valEmail?'Required':null,
//
//           ),
//         ),
//
//
//       TextField(
//         controller: txtPhone,
//         decoration: new InputDecoration(
//           hintText: "Phone",
//           errorText: _valPhone?'Required':null,
//
//         ),
//       ),
//       TextField(
//         controller: txtPlace,
//         decoration: new InputDecoration(
//           hintText: "Place",
//           errorText: _valPlace?'Required':null,
//
//         ),
//       ),
//       TextField(
//         controller: txtDistrict,
//         decoration: new InputDecoration(
//           hintText: "District",
//           errorText: _valDistrict?'Required':null,
//
//         ),
//       ),
//
//             TextField(
//               controller: txtPassword,
//               decoration: new InputDecoration(
//                 hintText: "Password",
//                 errorText: _valPassword?'Required':null,
//
//               ),
//             ),
//
//             Column(
// children: [
//   GestureDetector(
//     onTap: () async {
//       localmage = await pickImage();
//       setState(() {
//         localmage=localmage;
//       });
//     },
//     child:  localmage!.isNotEmpty
//         ? CircleAvatar(
//       radius: 60,
//       backgroundImage: MemoryImage(base64Decode(localmage!)),
//     )
//         : CircleAvatar(
//       radius: 60,
//     ),
//
//   ),
//
// ],
//             ),
//
//
//             ButtonBar(
//               children:<Widget> [
//                 ElevatedButton(
//                   onPressed:() {
//                     setState(()  {
//                       //for validation
//                       txtFullName.text.isEmpty?_valName=true:_valName=false;
//                       txtEmail.text.isEmpty?_valEmail=true:_valEmail=false;
//                       txtPhone.text.isEmpty?_valPhone=true:_valPhone=false;
//                       txtPhone.text.isEmpty?_valPlace=true:_valPlace=false;
//                       txtPhone.text.isEmpty?_valDistrict=true:_valDistrict=false;
//                       txtPassword.text.isEmpty?_valPassword=true:_valPassword=false;
//
//
//                       print("kkkk");
//                       if( _valEmail == false && _valName == false && _valPhone == false && _valPlace == false && _valDistrict == false && _valPassword == false)
//                         {
//                           chooseImage();
//                         }
//
//                     });
//                   },
//                   // color: Colors.green,
//                   child: Text("Save"),
//
//                 ),
//                               ],
//             )
//           ],
//
//         ),
//
//       ),
//     );
//   }
//
//
//   void chooseImage() async {
//
//
//
//     if( localmage != '' &&  _valEmail == false && _valName == false) {
//   // print("llllllllllllllllllllllllllllllllllllllllllll"+localmage!);
//   setState(() {});
//   _saveDetails(txtFullName.text, txtEmail.text, txtPhone.text, txtPlace.text, txtDistrict.text, txtPassword.text);
// }
//   }
//
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'login.dart';

void main() {
  return runApp(MaterialApp(
    home: hpspital_signup(),
  ));
}

class hpspital_signup extends StatefulWidget {
  @override
  _AdduserState createState() => _AdduserState();
}

class _AdduserState extends State<hpspital_signup> {
  final txtFullName = TextEditingController();
  final txtEmail = TextEditingController();
  final txtPhone = TextEditingController();
  final txtPlace = TextEditingController();
  final txtDistrict = TextEditingController();
  final txtPassword = TextEditingController();

  bool _valName = false;
  bool _valEmail = false;
  bool _valPhone = false;
  bool _valPlace = false;
  bool _valDistrict = false;
  bool _valPassword = false;
  bool _isLoading = false;
  bool _obscurePassword = true;

  String? localmage = "";

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

  Future<String> pickImage() async {
    XFile? xfile;
    xfile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (xfile != null) {
      Uint8List bytes = await xfile.readAsBytes();
      String encode = base64Encode(bytes);
      return encode;
    } else {
      return 'Error';
    }
  }

  Future _saveDetails(String name, String email, String phone, String place, String district, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");

      var data = await http.post(
          Uri.parse(url.toString() + "/hosp_register"),
          body: {
            "name": name,
            "email": email,
            "phone": phone,
            "place": place,
            "district": district,
            "lati": "11.7654",
            "longi": "75.98765",
            "password": password.toString(),
            'image': localmage ?? ""
          }
      );

      var res = data.body;
      var jsondata = jsonDecode(res);

      if (jsondata['status'] == "ok") {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration failed: ${jsondata['message'] ?? "Unknown error"}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Connection error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    txtFullName.dispose();
    txtEmail.dispose();
    txtPhone.dispose();
    txtPlace.dispose();
    txtDistrict.dispose();
    txtPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent, Colors.white],
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primary.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.login_outlined, color: primary, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              "Sign In",
                              style: poppinsSemiBold.copyWith(
                                color: primary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content Area
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Account",
                            style: poppinsBold.copyWith(
                              color: textColor,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Register your hospital with MEDI AI",
                            style: poppinsMedium.copyWith(
                              color: primaryLight,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Registration Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: accent.withOpacity(0.8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Profile Picture Section
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  localmage = await pickImage();
                                  setState(() {
                                    localmage = localmage;
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: primary.withOpacity(0.3), width: 2),
                                    color: accent,
                                  ),
                                  child: localmage != null && localmage!.isNotEmpty && localmage != "Error"
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.memory(
                                      base64Decode(localmage!),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        color: primaryLight,
                                        size: 30,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Add Photo",
                                        style: poppinsMedium.copyWith(
                                          color: primaryLight,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Tap to add profile picture",
                                style: poppinsRegular.copyWith(
                                  color: primaryLight,
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),

                          // Two Column Layout for Input Fields
                          Column(
                            children: [
                              // First Row: Name and Email
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInputField(
                                      controller: txtFullName,
                                      label: "Full Name",
                                      hintText: "Enter full name",
                                      icon: Icons.person_outline,
                                      isError: _valName,
                                      errorText: "Name is required",
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildInputField(
                                      controller: txtEmail,
                                      label: "Email Address",
                                      hintText: "Enter email",
                                      icon: Icons.email_outlined,
                                      isError: _valEmail,
                                      errorText: "Email is required",
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Second Row: Phone and Place
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInputField(
                                      controller: txtPhone,
                                      label: "Phone Number",
                                      hintText: "Enter phone number",
                                      icon: Icons.phone_outlined,
                                      isError: _valPhone,
                                      errorText: "Phone is required",
                                      keyboardType: TextInputType.phone,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildInputField(
                                      controller: txtPlace,
                                      label: "Place",
                                      hintText: "Enter place",
                                      icon: Icons.location_on_outlined,
                                      isError: _valPlace,
                                      errorText: "Place is required",
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Third Row: District and Password
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInputField(
                                      controller: txtDistrict,
                                      label: "District",
                                      hintText: "Enter district",
                                      icon: Icons.map_outlined,
                                      isError: _valDistrict,
                                      errorText: "District is required",
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Password",
                                              style: poppinsMedium.copyWith(
                                                color: textColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() => _obscurePassword = !_obscurePassword);
                                              },
                                              child: Text(
                                                _obscurePassword ? "Show" : "Hide",
                                                style: poppinsMedium.copyWith(
                                                  color: primaryLight,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: _valPassword ? Colors.red : accent.withOpacity(0.8),
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
                                            controller: txtPassword,
                                            obscureText: _obscurePassword,
                                            style: poppinsMedium.copyWith(
                                              color: textColor,
                                              fontSize: 14,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Enter password",
                                              hintStyle: poppinsRegular.copyWith(
                                                color: primaryLight.withOpacity(0.6),
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 16,
                                              ),
                                              prefixIcon: Icon(
                                                Icons.lock_outlined,
                                                color: primary,
                                                size: 20,
                                              ),
                                              errorText: _valPassword ? "Password is required" : null,
                                            ),
                                            onChanged: (value) {
                                              if (_valPassword && value.isNotEmpty) {
                                                setState(() => _valPassword = false);
                                              }
                                            },
                                          ),
                                        ),
                                        if (_valPassword)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4, left: 4),
                                            child: Text(
                                              'Password is required',
                                              style: poppinsRegular.copyWith(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // Register Button
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
                                  setState(() {
                                    txtFullName.text.isEmpty ? _valName = true : _valName = false;
                                    txtEmail.text.isEmpty ? _valEmail = true : _valEmail = false;
                                    txtPhone.text.isEmpty ? _valPhone = true : _valPhone = false;
                                    txtPlace.text.isEmpty ? _valPlace = true : _valPlace = false;
                                    txtDistrict.text.isEmpty ? _valDistrict = true : _valDistrict = false;
                                    txtPassword.text.isEmpty ? _valPassword = true : _valPassword = false;

                                    if (!_valName && !_valEmail && !_valPhone && !_valPlace && !_valDistrict && !_valPassword) {
                                      _saveDetails(
                                        txtFullName.text,
                                        txtEmail.text,
                                        txtPhone.text,
                                        txtPlace.text,
                                        txtDistrict.text,
                                        txtPassword.text,
                                      );
                                    }
                                  });
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
                                        Icon(Icons.person_add_outlined, color: Colors.white, size: 18),
                                        const SizedBox(width: 8),
                                        Text(
                                          'CREATE ACCOUNT',
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
                          const SizedBox(height: 16),

                          // Login Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: poppinsRegular.copyWith(
                                  color: primaryLight,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
                                  );
                                },
                                child: Text(
                                  "Sign In",
                                  style: poppinsSemiBold.copyWith(
                                    color: primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Info Section
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
                                  "Hospital Registration",
                                  style: poppinsSemiBold.copyWith(
                                    color: textColor,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Register your hospital to access MEDI AI's diagnostic tools and patient management system",
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
                            Icon(Icons.medical_services, color: primary, size: 14),
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
                          "Secure hospital registration",
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

  // Helper method for input fields
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    required bool isError,
    required String errorText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
              color: isError ? Colors.red : accent.withOpacity(0.8),
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
            controller: controller,
            style: poppinsMedium.copyWith(
              color: textColor,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: poppinsRegular.copyWith(
                color: primaryLight.withOpacity(0.6),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              prefixIcon: Icon(
                icon,
                color: primary,
                size: 20,
              ),
              errorText: isError ? errorText : null,
            ),
            keyboardType: keyboardType,
            onChanged: (value) {
              if (isError && value.isNotEmpty) {
                setState(() {
                  if (label == "Full Name") _valName = false;
                  if (label == "Email Address") _valEmail = false;
                  if (label == "Phone Number") _valPhone = false;
                  if (label == "Place") _valPlace = false;
                  if (label == "District") _valDistrict = false;
                });
              }
            },
          ),
        ),
        if (isError)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              errorText,
              style: poppinsRegular.copyWith(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}