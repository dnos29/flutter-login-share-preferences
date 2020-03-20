import 'package:flutter/material.dart';
import 'package:login_sharepreference/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  SharedPreferences preferences;
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getString("name") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          (Route<dynamic> route) => false);
    }else{
      setState(() {
        name = preferences.getString("name");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(name),
              RaisedButton(
                onPressed: () {
                  preferences.clear();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
                },
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
