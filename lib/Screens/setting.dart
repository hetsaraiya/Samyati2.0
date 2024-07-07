import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;
import 'package:samyati/Screens/contact.dart';
import 'package:samyati/Screens/privacypolicy.dart';
import 'package:samyati/Screens/tnc.dart';
import 'package:samyati/Theme/theme_modal.dart';
import 'package:samyati/Widgets/count_card.dart';
import 'package:samyati/constants/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isVisible = true;
  String? userName;

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  void showToast() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString("jwtToken");

    if (jwtToken == null) {
      print("JWT Token not found");
      return;
    }

    try {
      var response = await http.get(
        Uri.parse('$api/api/getUserDetails'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userName = data['username'];
        });
        print("User Details: ${data['username']}");
      } else {
        print("Failed to fetch user details: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Center(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 130, right: 20, left: 20, bottom: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CountCard(
                  cardHeight: 71.52,
                  dataBox: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/user.png",
                            height: 55,
                            width: 55,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "$userName",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: themeNotifier.isDark
                                  ? const Color.fromRGBO(16, 16, 16, 1)
                                  : const Color.fromRGBO(243, 243, 243, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              CountCard(
                cardHeight: 70,
                dataBox: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Center(
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10, horizontal: 10),
                    //     decoration: BoxDecoration(
                    //       border: Border(
                    //         bottom: BorderSide(
                    //           width: 0.75,
                    //           color: themeNotifier.isDark
                    //               ? const Color.fromRGBO(255, 255, 255, 1)
                    //               : const Color.fromRGBO(111, 111, 111, 1),
                    //         ),
                    //       ),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           "Find And Invite Friend",
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w600,
                    //             color: themeNotifier.isDark
                    //                 ? const Color.fromRGBO(16, 16, 16, 1)
                    //                 : const Color.fromRGBO(243, 243, 243, 1),
                    //           ),
                    //         ),
                    //         SvgPicture.asset(
                    //           themeNotifier.isDark
                    //               ? "assets/images/shortRightIcon.svg"
                    //               : "assets/images/shortRightIcondark.svg",
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Center(
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10, horizontal: 10),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "Notifications",
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w600,
                    //             color: themeNotifier.isDark
                    //                 ? const Color.fromRGBO(16, 16, 16, 1)
                    //                 : const Color.fromRGBO(243, 243, 243, 1),
                    //           ),
                    //         ),
                    //         SvgPicture.asset(
                    //           themeNotifier.isDark
                    //               ? "assets/images/shortRightIcon.svg"
                    //               : "assets/images/shortRightIcondark.svg",
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Center(
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10, horizontal: 10),
                    //     decoration: BoxDecoration(
                    //       border: Border(
                    //         bottom: BorderSide(
                    //           width: 0.75,
                    //           color: themeNotifier.isDark
                    //               ? const Color.fromRGBO(255, 255, 255, 1)
                    //               : const Color.fromRGBO(111, 111, 111, 1),
                    //         ),
                    //       ),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "Devices",
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w600,
                    //             color: themeNotifier.isDark
                    //                 ? const Color.fromRGBO(16, 16, 16, 1)
                    //                 : const Color.fromRGBO(243, 243, 243, 1),
                    //           ),
                    //         ),
                    //         SvgPicture.asset(
                    //           themeNotifier.isDark
                    //               ? "assets/images/shortRightIcon.svg"
                    //               : "assets/images/shortRightIcondark.svg",
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Center(
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10, horizontal: 10),
                    //     decoration: BoxDecoration(
                    //       border: Border(
                    //         bottom: BorderSide(
                    //           width: 0.75,
                    //           color: themeNotifier.isDark
                    //               ? const Color.fromRGBO(255, 255, 255, 1)
                    //               : const Color.fromRGBO(111, 111, 111, 1),
                    //         ),
                    //       ),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "Account Privacy",
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w600,
                    //             color: themeNotifier.isDark
                    //                 ? const Color.fromRGBO(16, 16, 16, 1)
                    //                 : const Color.fromRGBO(243, 243, 243, 1),
                    //           ),
                    //         ),
                    //         SvgPicture.asset(
                    //           themeNotifier.isDark
                    //               ? "assets/images/shortRightIcon.svg"
                    //               : "assets/images/shortRightIcondark.svg",
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Appearance",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: themeNotifier.isDark
                                    ? const Color.fromRGBO(16, 16, 16, 1)
                                    : const Color.fromRGBO(243, 243, 243, 1),
                              ),
                            ),
                            Consumer(
                              builder:
                                  (context, ThemeModal themeNotifier, child) {
                                return FlutterSwitch(
                                    width: 70.0,
                                    height: 35.0,
                                    value: themeNotifier.isDark ? false : true,
                                    borderRadius: 30.0,
                                    padding: 3,
                                    showOnOff: false,
                                    activeColor: const Color.fromRGBO(
                                        255, 255, 255, 0.10),
                                    inactiveColor:
                                        const Color.fromRGBO(211, 211, 211, 1),
                                    activeToggleColor:
                                        const Color.fromRGBO(240, 82, 37, 1),
                                    inactiveToggleColor:
                                        const Color.fromRGBO(240, 82, 37, 1),
                                    toggleSize: 30.0,
                                    activeIcon: SvgPicture.asset(
                                      "assets/images/moon.svg",
                                      height: 40,
                                      width: 40,
                                    ),
                                    inactiveIcon: SvgPicture.asset(
                                      "assets/images/sun.svg",
                                      height: 40,
                                      width: 40,
                                    ),
                                    onToggle: (value) {
                                      themeNotifier.isDark
                                          ? themeNotifier.isDark = false
                                          : themeNotifier.isDark = true;
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Center(
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10, horizontal: 10),
                    //     decoration: BoxDecoration(
                    //       border: Border(
                    //         bottom: BorderSide(
                    //           width: 0.75,
                    //           color: themeNotifier.isDark
                    //               ? const Color.fromRGBO(255, 255, 255, 1)
                    //               : const Color.fromRGBO(111, 111, 111, 1),
                    //         ),
                    //       ),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "Refer and Earn",
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w600,
                    //             color: themeNotifier.isDark
                    //                 ? const Color.fromRGBO(16, 16, 16, 1)
                    //                 : const Color.fromRGBO(243, 243, 243, 1),
                    //           ),
                    //         ),
                    //         SvgPicture.asset(
                    //           themeNotifier.isDark
                    //               ? "assets/images/shortRightIcon.svg"
                    //               : "assets/images/shortRightIcondark.svg",
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Center(
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10, horizontal: 10),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "Link  Satpay",
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //             color: themeNotifier.isDark
                    //                 ? const Color.fromRGBO(16, 16, 16, 1)
                    //                 : const Color.fromRGBO(243, 243, 243, 1),
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //         SvgPicture.asset(
                    //           themeNotifier.isDark
                    //               ? "assets/images/shortRightIcon.svg"
                    //               : "assets/images/shortRightIcondark.svg",
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CountCard(
                cardHeight: 300,
                dataBox: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => const ContactUs(),
              ),
              );
              },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Help",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: themeNotifier.isDark
                                    ? const Color.fromRGBO(16, 16, 16, 1)
                                    : const Color.fromRGBO(243, 243, 243, 1),
                              ),
                            ),
                            SvgPicture.asset(
                              themeNotifier.isDark
                                  ? "assets/images/shortRightIcon.svg"
                                  : "assets/images/shortRightIcondark.svg",
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Tnc(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Terms and Conditions",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: themeNotifier.isDark
                                    ? const Color.fromRGBO(16, 16, 16, 1)
                                    : const Color.fromRGBO(243, 243, 243, 1),
                              ),
                            ),
                            SvgPicture.asset(
                              themeNotifier.isDark
                                  ? "assets/images/shortRightIcon.svg"
                                  : "assets/images/shortRightIcondark.svg",
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPolicyWidget(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: themeNotifier.isDark
                                    ? const Color.fromRGBO(16, 16, 16, 1)
                                    : const Color.fromRGBO(243, 243, 243, 1),
                              ),
                            ),
                            SvgPicture.asset(
                              themeNotifier.isDark
                                  ? "assets/images/shortRightIcon.svg"
                                  : "assets/images/shortRightIcondark.svg",
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Check Updates",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: themeNotifier.isDark
                                  ? const Color.fromRGBO(16, 16, 16, 1)
                                  : const Color.fromRGBO(243, 243, 243, 1),
                            ),
                          ),
                          SvgPicture.asset(
                            themeNotifier.isDark
                                ? "assets/images/shortRightIcon.svg"
                                : "assets/images/shortRightIcondark.svg",
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Version",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: themeNotifier.isDark
                                  ? const Color.fromRGBO(16, 16, 16, 1)
                                  : const Color.fromRGBO(243, 243, 243, 1),
                            ),
                          ),
                          Text(
                            "1.2.04vs(Beta)",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: themeNotifier.isDark
                                  ? const Color.fromRGBO(16, 16, 16, 0.5)
                                  : const Color.fromRGBO(243, 243, 243, 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                height: 45,
                decoration: const BoxDecoration(
                  color: Color(0xffFF3D12),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: const Center(
                  child: Text(
                    "Delete Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
