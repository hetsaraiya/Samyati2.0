// ignore_for_file: unused_local_variable, duplicate_ignore, unnecessary_import, duplicate_import, file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:samyati/Screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samyati/Screens/onboarding_Screeen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:samyati/constants/api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Theme/colos.dart';
import '../Theme/theme_modal.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  Future<void> signInWithGoogle() async {
    try {
      print("Logging In");
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        GoogleSignInAuthentication auth = await account.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: auth.idToken,
          accessToken: auth.accessToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        var userName = userCredential.user?.displayName.toString();
        var email = userCredential.user?.email.toString();
        var uId = userCredential.user?.uid.toString();
        final String? accessToken = auth.accessToken;
        if (accessToken != null) {
          final response = await http.get(
            Uri.parse('$api/api/google/?code=${accessToken}'),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          );

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            final String refresh = data['refresh'];
            final String jwtToken = data['access'];
            prefs.setString("jwtToken", jwtToken);
            prefs.setString("refreshToken", refresh);
            prefs.setString("code", accessToken);
            print("jwtToken is $jwtToken");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          } else {
            print(response.body);
            throw Exception('Failed to authenticate with Google');
          }
        } else {
          // Handle case where authentication tokens are null
          print('Google authentication tokens are null');
          // Inform the user that sign-in failed and provide options for them to retry or troubleshoot
          // You can show an error message to the user or take corrective action here
        }
      } else {
        // Handle case where GoogleSignInAccount is null
        print('Google sign-in account is null');
        // Inform the user that sign-in failed and provide options for them to retry or troubleshoot
        // You can show an error message to the user or take corrective action here
      }
    } catch (error) {
      print("Error signing in with Google: $error");
      // Inform the user that sign-in failed and provide options for them to retry or troubleshoot
      // You can show an error message to the user or take corrective action here
    }
  }

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // InkWell(
            //   child: const Text("go to google fit",
            //       style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //           fontSize: 25,
            //           color: Colors.redAccent)),
            //   onTap: () => {
            //
            //   },
            // ),
            // InkWell(
            //   customBorder: const RoundedRectangleBorder(
            //     side: BorderSide(color: Colors.red),
            //     borderRadius: BorderRadius.all(Radius.circular(30)),
            //   ),
            //   child: themeNotifier.isDark ?
            //   SvgPicture.asset("assets/images/leftarrow.svg") :
            //   SvgPicture.asset("assets/images/lightleftarrow.svg"),
            //   onTap: () =>
            //   {
            //     Navigator.of(context).pop(MaterialPageRoute(
            //         builder: (context) => const onboarding_Screen()))
            //   },
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Start Your Run Journey",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Theme.of(context).primaryColor)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Log in or create your account using the below mentioned options.",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 400,
              width: 400,
              child: Center( child:Image.asset("assets/images/healthkit.png")),
            ),
            SizedBox(
              child: Center(
                child: Text(
                    "Continue With",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Theme.of(context).primaryColor)),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Google
                InkWell(
                  onTap: () async {
                    await signInWithGoogle();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  // google button
                  child: SizedBox(
                      width: double.infinity,
                      height: currentHeight < 670 ? 20 : 60,
                      child: Container(
                          // margin: const EdgeInsets.only(left: 150),
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          decoration: BoxDecoration(
                            color: themeNotifier.isDark
                                ? const Color.fromRGBO(243, 243, 243, 1)
                                : const Color.fromRGBO(255, 255, 255, 0.10),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              width: 0.75,
                              color: themeNotifier.isDark
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(111, 111, 111, 1),
                            ),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/google.png",
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  "Google",
                                  style: GoogleFonts.poppins(
                                      color: themeNotifier.isDark
                                          ? const Color.fromRGBO(
                                              16, 16, 16, 0.8)
                                          : const Color.fromRGBO(
                                              238, 238, 238, 0.8),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ]))),
                ),
              ],
            ),
          ],
        ),
      ));
    });
  }
}
