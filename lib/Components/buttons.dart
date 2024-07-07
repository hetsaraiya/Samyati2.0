import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Theme/colos.dart';
import '../Theme/theme_modal.dart';

// side small button for going in next sccreen
class navbutton extends StatelessWidget {
  final VoidCallback ontap;
  final double left;
  final String buttontext;

  navbutton(
      {super.key, required this.ontap, required this.left, required this.buttontext,});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return GestureDetector(
        onTap: ontap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
          margin: EdgeInsets.only(left: left),
          height: 45,
          width: double.infinity,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                buttontext,
                style: GoogleFonts.poppins(
                    color:themeNotifier.isDark
                        ?const Color.fromRGBO(16, 16, 16, 0.8)
                        : const Color.fromRGBO(
                        238, 238, 238, 0.8),
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              themeNotifier.isDark?
              SvgPicture.asset("assets/images/rightarrow.svg"):
              SvgPicture.asset("assets/images/rightarrowwhite.svg"),

            ],
          ),
        ),
      );
    }
    );
  }
}