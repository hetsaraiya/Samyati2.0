import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScoreTableConstruction extends StatelessWidget {
  const ScoreTableConstruction({
    Key? key,
    required this.userText,
    required this.userImage,
    required this.userColor,
    required this.userName,
    required this.userId,
    required this.userStep,
    required this.userCoin,
  }) : super(key: key);

  final String userText;
  final String userImage;
  final String userName;
  final String userId;
  final String userStep;
  final String userCoin;
  final List<Color> userColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "$userId.",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color.fromRGBO(16, 16, 16, 1),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 2,
          child: CircleAvatar(
            radius: 30,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: userColor),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(userImage),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userText,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color.fromRGBO(16, 16, 16, 1),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "@$userName",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 9,
                  color: Color.fromRGBO(100, 100, 100, 1),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/steps.svg",
                      width: 15,
                      height: 15,
                    ),
                    Flexible(
                      child: Text(
                        userStep,
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 124, 255, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Text(
                      "Steps",
                      style: TextStyle(
                        color: Color.fromRGBO(10, 10, 10, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/coin.png",
                      width: 15,
                      height: 15,
                    ),
                    Flexible(
                      child: Text(
                        userCoin,
                        style: const TextStyle(
                          color: Color.fromRGBO(253, 138, 5, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Text(
                      "Coins",
                      style: TextStyle(
                        color: Color.fromRGBO(10, 10, 10, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



































// return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           "$userId.",
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//             color: Color.fromRGBO(16, 16, 16, 1),
//           ),
//         ),
//         CircleAvatar(
//           radius: 30,
//           child: Container(
//             padding: const EdgeInsets.all(3),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(colors: userColor),
//             ),
//             child: CircleAvatar(
//               radius: 30,
//               backgroundImage: AssetImage(userImage),
//             ),
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               userName,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14,
//                 color: Color.fromRGBO(16, 16, 16, 1),
//               ),
//             ),
//             Text(
//               userId,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 9,
//                 color: Color.fromRGBO(100, 100, 100, 1),
//               ),
//             ),
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 85,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset(
//                     "assets/images/steps.svg",
//                   ),
//                   Text(
//                     userStep,
//                     style: const TextStyle(
//                         color: Color.fromRGBO(0, 124, 255, 1),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   const Text(
//                     "Steps",
//                     style: TextStyle(
//                       color: Color.fromRGBO(10, 10, 10, 1),
//                       fontSize: 10,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: 85,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "assets/images/coin.png",
//                     width: 19,
//                   ),
//                   Text(
//                     userCoin,
//                     style: const TextStyle(
//                       color: Color.fromRGBO(253, 138, 5, 1),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const Text(
//                     "Coins",
//                     style: TextStyle(
//                       color: Color.fromRGBO(10, 10, 10, 1),
//                       fontSize: 10,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );