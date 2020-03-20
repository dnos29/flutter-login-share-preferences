import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_sharepreference/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              isLoading ? Text("Loading...") : Text(""),
              TextField(
                controller: emailController,
              ),
              TextField(
                controller: passwordController,
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  login();
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var jsonRes;
    var res = await http.get('https://jsonplaceholder.typicode.com/users/1');
    if (res.statusCode == 200) {
      print(res);
      jsonRes = json.decode(res.body);
      if (jsonRes != null) {
        setState(() {
          isLoading = false;
        });
        // print(jsonRes['name']);
        // preferences.setString("name", jsonRes['name']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      }
    }
    print(emailController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
