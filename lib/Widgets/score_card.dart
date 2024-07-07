// score_card.dart
import 'package:flutter/material.dart';
import 'package:samyati/Widgets/score_table.dart';
import 'package:samyati/models/score.dart';

class ScoreCard extends StatelessWidget {
  final Score score;
  final bool isDarkTheme;

  const ScoreCard({
    Key? key,
    required this.score,
    required this.isDarkTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.75,
            color: isDarkTheme
                ? const Color.fromRGBO(255, 255, 255, 1)
                : const Color.fromRGBO(111, 111, 111, 1),
          ),
        ),
      ),
      child: Center(
        child: ScoreTableConstruction(
          userText: score.userText,
          userImage: score.userImage,
          userColor: score.userColor,
          userName: score.userName,
          userId: score.userId,
          userStep: score.userStep,
          userCoin: score.userCoin,
        ),
      ),
    );
  }
}
