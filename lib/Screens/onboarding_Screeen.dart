import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samyati/constants.dart';

import '../Theme/theme_modal.dart';
import '../components/buttons.dart';
import 'Login_screen.dart';

class onboarding_Screen extends StatelessWidget {
  const onboarding_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery
        .of(context)
        .size
        .width;
    //411.42857142857144
    double height = MediaQuery
        .of(context)
        .size
        .height;
    //867.4285714285714
    print(Width * 0.052);
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: height < 670 ? 100 : 80),
                      child: Text(
                        "Hello From The",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: themeNotifier.isDark
                                ?const Color.fromRGBO(16, 16, 16, 0.8)
                                : const Color.fromRGBO(
                                238, 238, 238, 0.8),
                            fontSize: height < 670 ? 20 : 26),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 70),
                      child: Text("Samyati",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: themeNotifier.isDark
                                    ?const Color.fromRGBO(16, 16, 16, 0.8)
                                    : const Color.fromRGBO(
                                    238, 238, 238, 0.8),
                                fontSize: height < 670 ? 40 : 49,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/images/onboarding.png",
                  width: 284.74,
                  height: height < 670 ? 280 : 340.3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Convert Your Steps Into a Currency To Spend on Products, offers and supporting Charitable Causes",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: themeNotifier.isDark
                            ?const Color.fromRGBO(16, 16, 16, 0.8)
                            : const Color.fromRGBO(
                            238, 238, 238, 0.8),
                        fontSize: height < 670 ? 12 : 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                navbutton(
                  buttontext: "Continue",
                  left: 150,
                  ontap: () =>
                  {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) =>
                        const Login_screen()))
                  },)
              ]
          ),
        ),
      );
    }
    );
  }
}
