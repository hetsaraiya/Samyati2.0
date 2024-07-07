// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:samyati/Theme/theme_modal.dart';
import 'package:samyati/Widgets/challenge_widget.dart';
import 'package:samyati/constants/api.dart';
import 'package:samyati/models/challanges.dart';
import 'package:samyati/models/score.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import '../Widgets/count_card.dart';
import '../Widgets/score_table.dart';

class ChallengeTab extends StatefulWidget {
  const ChallengeTab({Key? key}) : super(key: key);

  @override
  State<ChallengeTab> createState() => _ChallengeTabState();
}

class _ChallengeTabState extends State<ChallengeTab> {
  late Future<List<Challenge>> futureChallenges;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    futureChallenges = fetchChallenges();
  }

  Future<List<Challenge>> fetchChallenges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString("jwtToken");
    final response = await http.get(
      Uri.parse('$api/api/challenge'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      List<dynamic> json = jsonDecode(response.body);
      return json.map((data) => Challenge.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Column(
        children: [
          const Text(
            "Daily Challenges",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Challenge>>(
              future: futureChallenges,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.only(top: 90),
                    width: 300,
                    child: Text(
                      "No Challenges Available For You",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ChallengeCard(
                          challenge: snapshot.data![index],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      );
    });
  }
}

class FriendsTab extends StatefulWidget {
  const FriendsTab({super.key});

  @override
  State<FriendsTab> createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  bool light = true;
  List<Score> friendsScores = [];
  String? shareLink;

  Future<List<dynamic>> getfriends() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString("jwtToken");
    final response = await http.get(
      Uri.parse('$api/api/getFriends'), // Adjust the URL as necessary
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load friends data');
    }
  }

  Future<void> _loadFriendsData() async {
    final data = await getfriends();
    setState(() {
      friendsScores = [];
      shareLink = null;

      for (var item in data) {
        if (item.containsKey('refer')) {
          shareLink = item['refer'];
        } else {
          friendsScores.add(Score.fromJson(item));
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFriendsData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: 300,
              child: themeNotifier.isDark? Lottie.asset("assets/images/runing(white).json"):Lottie.asset("assets/images/runing(black).json")
            ),
            const Text(
              "Coming Soon...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // CountCard(
            //   cardHeight: 383,
            //   dataBox: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: friendsScores.map((score) {
            //       return Container(
            //         height: 74,
            //         padding: const EdgeInsets.symmetric(
            //             vertical: 10, horizontal: 20),
            //         decoration: BoxDecoration(
            //           border: Border(
            //             bottom: BorderSide(
            //               width: 0.75,
            //               color: themeNotifier.isDark
            //                   ? const Color.fromRGBO(255, 255, 255, 1)
            //                   : const Color.fromRGBO(111, 111, 111, 1),
            //             ),
            //           ),
            //         ),
            //         child: Center(
            //           child: ScoreTableConstruction(
            //             userText: score.userText,
            //             userImage: score.userImage,
            //             userColor: score.userColor,
            //             userName: score.userName,
            //             userId: score.userId,
            //             userStep: score.userStep,
            //             userCoin: score.userCoin,
            //           ),
            //         ),
            //       );
            //     }).toList(),
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: 10),
            //   height: 45,
            //   decoration: const BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [
            //         Color.fromRGBO(240, 82, 37, 1),
            //         Color.fromRGBO(238, 168, 32, 1)
            //       ],
            //     ),
            //     borderRadius: BorderRadius.all(Radius.circular(6)),
            //   ),
            //   child: const Center(
            //     child: Text(
            //       "See All History",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 18,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
            // CountCard(
            //     cardHeight: 86,
            //     dataBox: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Share Step With Followers",
            //               style: TextStyle(
            //                 color: themeNotifier.isDark
            //                     ? Color.fromRGBO(16, 16, 16, 0.5)
            //                     : Color.fromRGBO(238, 238, 236, 1),
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //             SizedBox(
            //               height: 5,
            //             ),
            //             Text(
            //               "We'll Share your steps with people that follow you",
            //               maxLines: 2,
            //               style: TextStyle(
            //                 color: themeNotifier.isDark
            //                     ? Color.fromRGBO(16, 16, 16, 0.5)
            //                     : Color.fromRGBO(238, 238, 236, 1),
            //                 fontSize: 9,
            //                 fontWeight: FontWeight.w400,
            //               ),
            //             ),
            //           ],
            //         ),
            //         FlutterSwitch(
            //           width: 60,
            //           height: 35,
            //           value: light,
            //           activeColor: const Color.fromRGBO(240, 82, 37, 1),
            //           onToggle: (bool value) {
            //             setState(() {
            //               light = value;
            //             });
            //           },
            //         )
            //       ],
            //     )),
            // const SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
            //   child: const Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Find Contacts",
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // CountCard(
            //   cardHeight: 148,
            //   dataBox: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           "Just tap “OK” When Your Phone asks for access. Well never contact anyone without your permission.",
            //           style: TextStyle(
            //             fontSize: 13,
            //             color: themeNotifier.isDark
            //                 ? Color.fromRGBO(16, 16, 16, 0.5)
            //                 : Color.fromRGBO(238, 238, 236, 1),
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 20,
            //         ),
            //         Container(
            //           height: 40,
            //           decoration: const BoxDecoration(
            //             color: Color.fromRGBO(35, 175, 0, 1),
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(5),
            //             ),
            //           ),
            //           child: const Center(
            //             child: Text(
            //               "Claim Now",
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
            //   child: const Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Share Code",
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // CountCard(
            //   cardHeight: 50,
            //   dataBox: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 5),
            //         child: themeNotifier.isDark
            //             ? SvgPicture.asset("assets/images/linkdark.svg")
            //             : SvgPicture.asset("assets/images/linklight.svg"),
            //       ),
            //       SizedBox(
            //         width: 210,
            //         child: Text(
            //           shareLink ?? "None",
            //           style: TextStyle(
            //             fontSize: 10,
            //             color: themeNotifier.isDark
            //                 ? Color.fromRGBO(16, 16, 16, 0.5)
            //                 : Color.fromRGBO(238, 238, 236, 1),
            //           ),
            //         ),
            //       ),
            //       InkWell(
            //         onTap: () {
            //           Clipboard.setData(
            //                   ClipboardData(text: shareLink ?? "None"))
            //               .then(
            //             (value) => ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(
            //                 content: ClipRRect(
            //                   child: BackdropFilter(
            //                     filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            //                     child: Container(
            //                       padding: const EdgeInsets.all(14),
            //                       decoration: BoxDecoration(
            //                         color: themeNotifier.isDark
            //                             ? const Color.fromRGBO(
            //                                 238, 238, 238, 0.8)
            //                             : const Color.fromRGBO(16, 16, 16, 0.8),
            //                         borderRadius: BorderRadius.circular(5),
            //                       ),
            //                       child: Center(
            //                         child: Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: [
            //                             Icon(
            //                               Icons.copy_all_outlined,
            //                               color: themeNotifier.isDark
            //                                   ? const Color.fromRGBO(
            //                                       238, 238, 238, 0.8)
            //                                   : const Color.fromRGBO(
            //                                       16, 16, 16, 0.8),
            //                               size: 20,
            //                             ),
            //                             const SizedBox(
            //                               width: 10,
            //                             ),
            //                             Text(
            //                               "Code Copied",
            //                               style: TextStyle(
            //                                 color: themeNotifier.isDark
            //                                     ? const Color.fromRGBO(
            //                                         16, 16, 16, 0.8):
            //                                   const Color.fromRGBO(
            //                                   238, 238, 238, 0.8),
            //                                 fontWeight: FontWeight.w600,
            //                               ),
            //                             )
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 backgroundColor: Colors.transparent,
            //                 elevation: 0,
            //                 // behavior: SnackBarBehavior.floating,
            //               ),
            //             ),
            //           );
            //         },
            //         child: Container(
            //           height: 40,
            //           padding: const EdgeInsets.all(5),
            //           decoration: BoxDecoration(
            //             gradient: const LinearGradient(
            //               colors: [
            //                 Color.fromRGBO(240, 82, 37, 1),
            //                 Color.fromRGBO(238, 168, 32, 1)
            //               ],
            //             ),
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: const Center(
            //             child: Text(
            //               "Copy Code",
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 80,
            // )
          ],
        ),
      );
    });
  }
}

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 130, right: 20, left: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Search",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // search box

                Container(
                  height: 50,
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
                  child: TextField(
                      decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    border: InputBorder.none,
                    hintText: "Search Here",
                    hintStyle: TextStyle(
                      color: themeNotifier.isDark
                          ? const Color.fromRGBO(16, 16, 16, 0.8)
                          : const Color.fromRGBO(238, 238, 238, 0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: themeNotifier.isDark
                              ? SvgPicture.asset(
                                  "assets/images/Search.svg",
                                )
                              : SvgPicture.asset(
                                  "assets/images/lightSearch.svg",
                                )),
                    ),
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: themeNotifier.isDark
                        ? const Color.fromRGBO(243, 243, 243, 1)
                        : const Color.fromRGBO(255, 255, 255, 0.10),
                    borderRadius: BorderRadius.circular(05),
                    border: Border.all(
                      width: 0.75,
                      color: themeNotifier.isDark
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(111, 111, 111, 1),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      tabs: const [
                        Tab(
                          child: Text('Challenges'),
                        ),
                        Tab(
                          child: Text('Friends'),
                        ),
                      ],
                      dividerColor:  Colors.transparent,
                      isScrollable: false,
                      indicatorPadding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: themeNotifier.isDark
                          ? const Color.fromRGBO(16, 16, 16, 0.8)
                          : const Color.fromRGBO(238, 238, 238, 1),
                      labelColor: const Color.fromRGBO(238, 238, 238, 1),
                      labelPadding: const EdgeInsets.only(left: 0, right: 0),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(240, 82, 37, 1),
                            Color.fromRGBO(238, 168, 32, 1)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 520,
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      ChallengeTab(),
                      FriendsTab(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ));
    });
  }
}
