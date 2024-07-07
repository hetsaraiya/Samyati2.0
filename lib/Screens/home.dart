// ignore_for_file: no_logic_in_create_state

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:samyati/Screens/challenges.dart';
import 'package:samyati/Screens/earning.dart';
import 'package:samyati/Screens/home_page.dart';
import 'package:samyati/Screens/setting.dart';
import 'package:samyati/Theme/theme_modal.dart';
import 'package:samyati/Widgets/challenges_appbar.dart';
import 'package:samyati/Widgets/earning_appbar.dart';
import 'package:samyati/Widgets/main_appbar.dart';
import 'package:samyati/Widgets/setting_appbar.dart';

// import 'package:samyati/database/constants.dart';
// import 'package:mongo_dart/mongo_dart.dart' as mongoconn;

class HomePage extends StatefulWidget {
  final String? userName;
  final String? email;
  final String? uId;
  final String? data;

  const HomePage({super.key, this.userName, this.email, this.uId, this.data});

  @override
  State<HomePage> createState() => _HomePageState(
      username: this.userName,
      email: this.email,
      uId: this.uId,
      data: this.data);
}

class _HomePageState extends State<HomePage> {
  String? username;
  String? email;
  String? user_name;

  String? uId;
  String? data;
  _HomePageState(
      {required this.username,
      required this.email,
      required this.uId,
      required this.data});
  int pageIndex = 0;
  late Widget appTitle;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    user_name = username;
    super.setState(fn);
  }

  final pages = [
    const Home_Page(),
    const ChallengePage(),
    const EarningPage(),
    const SettingPage(),
  ];

  Widget _buildCurrentScreen() {
    switch (pageIndex) {
      case 0:
        return Home_Page(title: username);
      case 1:
        return const ChallengePage();
      case 2:
        return EarningPage(
          title: username,
        );
      case 3:
        return const SettingPage();
      default:
        return const SizedBox();
    }
  }

  void _setAppBarContent() {
    switch (pageIndex) {
      case 0:
        setState(() {
          appTitle = AppBarWidget(
            title: widget.userName,
          );
        });
        break;
      case 1:
        setState(() {
          appTitle = const ChallengesAppBar();
        });
        break;
      case 2:
        setState(() {
          appTitle = EarningAppBar();
        });
        break;
      case 3:
        setState(() {
          appTitle = SettingAppBar();
        });
        break;
      default:
        break;
    }
  }

  // void collectionconnect() async {
  //   var db = await mongoconn.Db.create(MONGO_URL);
  //   await db.open();
  //   var status = db.serverStatus();
  //   print("status : ");
  //   print(status);
  //   var collection = db.collection(COLLECTION_NAME);
  //   await collection.insertOne({
  //     'email': email,
  //     'UID': uId,
  //     'UserName': username,
  //     "earnedCoinsT": 0.0,
  //     "earnedToday": 0.0
  //   });
  // }

  @override
  void initState() {
    _setAppBarContent();
    user_name = username;
    // if (data == 'route login') {
    //   collectionconnect();
    // } else {}
    // // _fetchStepData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;

    return Consumer(
      builder: (context, ThemeModal themeNotifier, child) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
              preferredSize: const Size(
                double.infinity,
                60.0,
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: AppBar(
                    toolbarHeight: currentHeight < 670 ? 100 : 60,
                    automaticallyImplyLeading: false,
                    backgroundColor: themeNotifier.isDark
                        ? const Color.fromRGBO(238, 238, 238, 0.8)
                        : const Color.fromRGBO(16, 16, 16, 0.8),
                    elevation: 0,
                    title: appTitle,
                  ),
                ),
              )),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  height: 74,
                  margin:
                      const EdgeInsets.only(bottom: 30, right: 10, left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: themeNotifier.isDark
                        ? const Color.fromRGBO(238, 238, 238, 0.8)
                        : const Color.fromRGBO(16, 16, 16, 0.8),
                    border: Border.all(
                      width: 0.75,
                      color: themeNotifier.isDark
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(16, 16, 16, 0.8),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(183, 183, 183, 0.25),
                        blurRadius: 30.0,
                        offset: Offset(0, 6),
                      )
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            setState(() {
                              pageIndex = 0;
                            });
                            _setAppBarContent();
                          },
                          icon: pageIndex == 0
                              ? SvgPicture.asset(
                                  "assets/images/active_icon1.svg")
                              : SvgPicture.asset(themeNotifier.isDark
                                  ? "assets/images/icon1.svg"
                                  : "assets/images/icon_dark_1.svg"),
                        ),
                        IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            setState(() {
                              pageIndex = 1;
                            });
                            _setAppBarContent();
                          },
                          icon: pageIndex == 1
                              ? SvgPicture.asset(
                                  "assets/images/active_icon2.svg")
                              : SvgPicture.asset(themeNotifier.isDark
                                  ? "assets/images/icon2.svg"
                                  : "assets/images/icon_dark_2.svg"),
                        ),
                        IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            setState(() {
                              pageIndex = 2;
                            });
                            _setAppBarContent();
                          },
                          icon: pageIndex == 2
                              ? SvgPicture.asset(
                                  "assets/images/active_icon3.svg")
                              : SvgPicture.asset(themeNotifier.isDark
                                  ? "assets/images/icon3.svg"
                                  : "assets/images/icon_dark_3.svg"),
                        ),
                        IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            setState(() {
                              pageIndex = 3;
                            });
                            _setAppBarContent();
                          },
                          icon: pageIndex == 3
                              ? SvgPicture.asset(
                                  "assets/images/active_icon4.svg")
                              : SvgPicture.asset(themeNotifier.isDark
                                  ? "assets/images/icon4.svg"
                                  : "assets/images/icon_dark_4.svg"),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          body: _buildCurrentScreen(),
        );
      },
    );
  }
}
