import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samyati/constants/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tnc extends StatefulWidget {
  const Tnc({super.key});

  @override
  State<Tnc> createState() => _TncState();
}

class _TncState extends State<Tnc> {
  String title = "Terms and Conditions";
  String privacyPolicyContent = "";

  @override
  void initState() {
    super.initState();
    _fetchPrivacyPolicy();
  }

  Future<void> _fetchPrivacyPolicy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString("jwtToken");

    final response = await http.get(
      Uri.parse('$api/api/getPrivacyPolicy?title=${title}'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        privacyPolicyContent = jsonDecode(response.body)['content'];
      });
    } else {
      setState(() {
        privacyPolicyContent = "Failed to load privacy policy";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            privacyPolicyContent,
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
