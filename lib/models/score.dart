import 'dart:ui';

class Score {
  final String userText;
  final String userImage;
  final List<Color> userColor;
  final String userName;
  final String userId;
  final String userStep;
  final String userCoin;

  Score({
    required this.userText,
    required this.userImage,
    required this.userColor,
    required this.userName,
    required this.userId,
    required this.userStep,
    required this.userCoin,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      userText: json['name'] ?? '',
      userImage: 'assets/images/c1.png',
      userColor: [
        Color.fromRGBO(143, 0, 255, 1),
        Color.fromRGBO(0, 124, 255, 1),
      ],
      userName: json['username'] ?? '',
      userId: json['id']?.toString() ?? "1",
      userStep: json['steps']?.toString() ?? '0',
      userCoin: (json['coins']?.toDouble() ?? 0.0).toString(),
    );
  }
}
