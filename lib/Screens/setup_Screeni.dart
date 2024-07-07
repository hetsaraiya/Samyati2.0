// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:samyati/Components/buttons.dart';
// import '../Theme/theme_modal.dart';
// import '../Widgets/permission_struct.dart';
// import 'home.dart';
// class setup_Screeni extends StatelessWidget {
//   const setup_Screeni({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final currentHeight = MediaQuery.of(context).size.height;
//     return PermissionPage(
//       img: "assets/images/googlefit.png",
//       title:
//       "Now let me see your Googlefit data so i can verify steps are real!!!!",
//       ifButton: const SizedBox(),
//       mainButton: SizedBox(
//         width: currentHeight < 670 ? 170 : 200,
//         child:navbutton(
//           buttontext: "Continue",
//           left: 10,
//           ontap: () async {
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));
//         },)
//       ),
//       indication: Consumer(builder: (context, ThemeModal themeNotifier, child) {
//         return const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // SizedBox(
//             //   width: 25,
//             //   height: 4,
//             //   child: Container(
//             //     decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(20),
//             //         color: const Color.fromRGBO(207, 207, 207, 1)),
//             //   ),
//             // ),
//             // SizedBox(
//             //   width: 25,
//             //   height: 8,
//             //   child: Container(
//             //     decoration: BoxDecoration(
//             //       borderRadius: BorderRadius.circular(20),
//             //       color: themeNotifier.isDark
//             //           ? const Color.fromRGBO(16, 16, 16, 1)
//             //           : const Color.fromRGBO(207, 207, 207, 1),
//             //     ),
//             //   ),
//             // ),
//             // SizedBox(
//             //   width: 25,
//             //   height: 4,
//             //   child: Container(
//             //     decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(20),
//             //         color: const Color.fromRGBO(207, 207, 207, 1)),
//             //   ),
//             // ),
//             // SizedBox(
//             //   width: 25,
//             //   height: 4,
//             //   child: Container(
//             //     decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(20),
//             //         color: const Color.fromRGBO(207, 207, 207, 1)),
//             //   ),
//             // ),
//           ],
//         );
//       }),
//     );

//   }
// }
