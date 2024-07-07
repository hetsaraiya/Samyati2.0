import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samyati/Screens/Login_screen.dart';
import 'package:samyati/Screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Theme/theme_modal.dart';
import '../constants.dart';
import 'onboarding_Screeen.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      final jwtToken = prefs.getString('jwtToken');
      final refreshToken = prefs.getString('refreshToken');
      final code = prefs.getString('code');

      if (jwtToken != null && refreshToken != null && code != null) {
        // Navigate to HomePage if tokens are present
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        // Navigate to LoginScreen if tokens are not present
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Login_screen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Expanded(
                flex: 5,
                child: SizedBox(
                    width: 300,
                    height: 300,
                    child:
                    themeNotifier.isDark ? Image.asset("assets/images/logo-white.png")
                        :Image.asset("assets/images/logo-dark.png"),
              ),
              ),
              Expanded(
                  flex: -1,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text("Made with ♥️ from India",
                        style: GoogleFonts.poppins(
                          color: themeNotifier.isDark
                              ? const Color.fromRGBO(16, 16, 16, 0.8)
                              : const Color.fromRGBO(238, 238, 238, 0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 1.0,
                        )),
                  ))
            ],
          ),
        ),
      );
    });
  }
}
