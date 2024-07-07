import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:samyati/Theme/theme_modal.dart';


class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.amount,
    required this.img,
    required this.percentage,
    required this.gradient1,
    required this.description,
  }) : super(key: key);

  final Widget amount;
  final String description;
  final String img;
  final Color gradient1;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 100,
            backgroundColor: themeNotifier.isDark
                ? const Color.fromRGBO(255, 255, 255, 0.8)
                : const Color.fromRGBO(255, 255, 255, 0.10),
          ),
          CircularPercentIndicator(
              radius: 85,
              lineWidth: 10,
              percent: percentage,
              animation: true,
              animationDuration: 1000,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: const Color.fromRGBO(226, 226, 226, 1),
              linearGradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    const Color.fromRGBO(143, 0, 255, 1),
                    gradient1,
                  ])),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                img,
                width: 28,
                height: 40,
              ),
              amount,
              Text(
                description,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: themeNotifier.isDark
                      ? const Color.fromRGBO(16, 16, 16, 0.5)
                      : const Color.fromRGBO(238, 238, 236, 1),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
