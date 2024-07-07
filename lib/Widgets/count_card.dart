import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samyati/Theme/theme_modal.dart';


class CountCard extends StatelessWidget {
  const CountCard({
    Key? key,
    required this.cardHeight,
    required this.dataBox,
  }) : super(key: key);

  final double cardHeight;
  final Widget dataBox;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Container(
        width: 359.54,
        height: cardHeight,
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: themeNotifier.isDark
              ? const Color.fromRGBO(243, 243, 243, 1)
              : const Color.fromRGBO(255, 255, 255, 0.10),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.75,
            color: themeNotifier.isDark
                ? const Color.fromRGBO(255, 255, 255, 1)
                : const Color.fromRGBO(111, 111, 111, 1),
          ),
        ),
        child: Center(child: dataBox),
      );
    });
  }
}
