import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:samyati/Theme/theme_modal.dart';
import 'package:samyati/Widgets/count_card.dart';
import 'package:samyati/constants/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

// Graph
class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 289.681,
      height: 232.645,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(interval: 2),
        trackballBehavior: _trackballBehavior,
        series: <LineSeries>[
          LineSeries<ChartData, String>(
              animationDuration: 2500,
              width: 2,
              markerSettings: const MarkerSettings(
                isVisible: true,
                width: 10,
                height: 10,
                color: Colors.white,
                borderWidth: 2,
              ),
              dataSource: [
                ChartData('Mon', 0.4, const Color.fromRGBO(240, 82, 37, 1)),
                ChartData('Tue', 1.5, const Color.fromRGBO(240, 82, 37, 1)),
                ChartData('Wed', 0.3, const Color.fromRGBO(240, 82, 37, 1)),
                ChartData('Thrus', 3.5, const Color.fromRGBO(240, 82, 37, 1)),
                ChartData('Fri', 10, const Color.fromRGBO(240, 82, 37, 1)),
                ChartData('Sat', 3, const Color.fromRGBO(240, 82, 37, 1)),
                ChartData('Sun', 6, const Color.fromRGBO(240, 82, 37, 1)),
              ],
              // Bind the color for all the data points from the data source
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              enableTooltip: true)
        ],
      ),
    );
  }
}

// Main
class EarningPage extends StatefulWidget {
  final String? title;
  const EarningPage({super.key, this.title});

  @override
  State<EarningPage> createState() => _EarningPageState(title: this.title);
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

// late TooltipBehavior _tooltipBehavior;
late TrackballBehavior _trackballBehavior;

class _EarningPageState extends State<EarningPage> {
  String? title;
  String earnedCoinsTs = "0";
  String earnedTodays = "0";
  _EarningPageState({required this.title});

  Future<void> fetchCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString("jwtToken");
    String apiUrl = '$api/api/getCoins';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        earnedTodays = data['coins'].toString();
        earnedCoinsTs = data['coinstotal'].toString().isEmpty ? "0" : data['coinstotal'].toString();
      });
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineWidth: 0,
      hideDelay: 3000.0,
      lineType: TrackballLineType.none,
      activationMode: ActivationMode.singleTap,
      builder: (BuildContext context, TrackballDetails trackballDetails) {
        return Container(
          height: 22,
          width: 54,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(240, 82, 37, 1),
              Color.fromRGBO(238, 168, 32, 1)
            ]),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Center(
            child: Text(
              trackballDetails.point!.y.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        );
      },
    );
    fetchCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Center(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 130, right: 20, left: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Total Coins",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CountCard(
                cardHeight: 71.52,
                dataBox: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/coin.png",
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          earnedCoinsTs,
                          style: const TextStyle(
                              color: Color.fromRGBO(255, 133, 0, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Coins",
                          style: TextStyle(
                              color: themeNotifier.isDark
                                  ? const Color.fromRGBO(16, 16, 16, 0.5)
                                  : const Color.fromRGBO(238, 238, 236, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    GradientText(
                      "Redeem Now",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      colors: const [
                        Color.fromRGBO(240, 82, 37, 1),
                        Color.fromRGBO(238, 168, 32, 1),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CountCard(
                cardHeight: 387,
                dataBox: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Today's Earning",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: themeNotifier.isDark
                                        ? const Color.fromRGBO(16, 16, 16, 1)
                                        : const Color.fromRGBO(
                                            238, 238, 236, 1),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/coin.png",
                                      height: 40,
                                      width: 40,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      earnedTodays,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(255, 133, 0, 1),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Coins',
                                      style: TextStyle(
                                          color: themeNotifier.isDark
                                              ? const Color.fromRGBO(
                                                  16, 16, 16, 1)
                                              : const Color.fromRGBO(
                                                  238, 238, 236, 1),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Earned Coins",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: themeNotifier.isDark
                                        ? const Color.fromRGBO(16, 16, 16, 1)
                                        : const Color.fromRGBO(
                                            238, 238, 236, 1),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    openCalenderBox();
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Today",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: themeNotifier.isDark
                                              ? const Color.fromRGBO(
                                                  16, 16, 16, 0.5)
                                              : const Color.fromRGBO(
                                                  238, 238, 236, 1),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.asset(
                                        themeNotifier.isDark
                                            ? "assets/images/calendar.svg"
                                            : "assets/images/calendar_dark.svg",
                                        width: 20,
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Graph(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 45,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(240, 82, 37, 1),
                      Color.fromRGBO(238, 168, 32, 1)
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: const Center(
                  child: Text(
                    "See All History",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Your Offers",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // const Offer1(),
              const SizedBox(
                height: 10,
              ),
              // const Offer2(),
              const SizedBox(
                height: 10,
              ),
              // const Offer3(),
              const SizedBox(
                height: 10,
              ),
              // const Offer4(),
              const SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
      );
    });
  }

  Future openCalenderBox() => showGeneralDialog(
        context: context,
        pageBuilder: (ctx, a1, a2) {
          return Container();
        },
        transitionBuilder: (ctx, a1, a2, child) {
          var curve = Curves.easeInOut.transform(a1.value);
          return Transform.scale(
            scale: curve,
            child:
                Consumer(builder: (context, ThemeModal themeNotifier, child) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 220, horizontal: 10),
                decoration: BoxDecoration(
                  color: themeNotifier.isDark
                      ? const Color.fromRGBO(250, 250, 250, 1)
                      : const Color.fromRGBO(0, 0, 0, 1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10.0), child: Container()
                    // SfDateRangePicker(
                    //   monthCellStyle: const DateRangePickerMonthCellStyle(
                    //     todayTextStyle: TextStyle(
                    //         color: Color.fromRGBO(0, 124, 255, 1),
                    //         fontWeight: FontWeight.w700),
                    //   ),
                    //   headerHeight: 80,
                    //   headerStyle: const DateRangePickerHeaderStyle(
                    //       textAlign: TextAlign.center,
                    //       textStyle: TextStyle(
                    //         color: Color.fromRGBO(2, 2, 2, 1),
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w600,
                    //       )),
                    //   view: DateRangePickerView.month,
                    //   selectionMode: DateRangePickerSelectionMode.range,
                    //   showActionButtons: true,
                    //   showNavigationArrow: true,
                    //   onCancel: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   onSubmit: (Object? value) {
                    //     // ignore: avoid_print
                    //     print(value);
                    //     Navigator.of(context).pop();
                    //   },
                    //   rangeTextStyle: const TextStyle(
                    //     color: Color.fromRGBO(106, 106, 109, 1),
                    //     fontSize: 14,
                    //   ),
                    //   rangeSelectionColor: const Color.fromRGBO(221, 236, 253, 1),
                    //   startRangeSelectionColor:
                    //       const Color.fromRGBO(240, 82, 37, 1),
                    //   endRangeSelectionColor:
                    //       const Color.fromRGBO(240, 82, 37, 1),
                    //   todayHighlightColor: themeNotifier.isDark
                    //       ? const Color.fromRGBO(106, 106, 109, 1)
                    //       : const Color.fromRGBO(255, 255, 255, 1),
                    // ),
                    ),
              );
            }),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      );
}
