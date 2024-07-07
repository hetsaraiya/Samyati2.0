import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:samyati/constants/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarWidget extends StatefulWidget {
  final String? title;
  const AppBarWidget({super.key, this.title});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  String? userName;
  @override
  void initState() {
    fetchUserData();
    super.initState();
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/user.png",
          height: 54,
          width: 54,
          fit: BoxFit.contain,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, ${userName}",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 14),
            ),
            Text(
              "Good Afternoon!",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 21,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(),
      ],
    );
  }
}
