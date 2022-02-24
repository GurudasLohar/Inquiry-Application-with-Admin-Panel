import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'admin_sign_in.dart';



void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminSignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color(0xFFFFEBEE),
                gradient: LinearGradient(colors: [(Color(0xFFFFEBEC)), Color(0xFFFFEBEB)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(
                height: 200, width: 200,
                child:
                Image.asset("images/icon.png"),),
                SizedBox(height: 5,),
                Text('Sollywood System', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.red),textAlign: TextAlign.center,),
                SizedBox(height: 5,),
                Text('Admin panel', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.red),textAlign: TextAlign.center)
              ],
            ),
            ),
        ],
      ),
    );
  }
}