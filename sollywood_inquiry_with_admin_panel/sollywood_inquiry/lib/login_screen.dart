import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inquiry/forget_password.dart';
import 'package:inquiry/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => StartState();
}

class LockIcon {
  Icon lock = Icon(Icons.lock_outline);
  Icon open = Icon(Icons.lock_open);

}

class StartState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;

  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  late String email;
  late String pass;

  bool offsecureText = true;
  Icon lockIcon = LockIcon().lock;


  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckAlreadyLogin();
  }

  void CheckAlreadyLogin() async {

    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);

    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }


  void lockPressed (){
    if(offsecureText == true){
      setState(() {
        offsecureText = false;
        lockIcon = LockIcon().open;

      });
    } else {
      setState(() {
        offsecureText = true;
        lockIcon = LockIcon().lock;

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                color: Colors.red,
                gradient: RadialGradient(
                  colors: [Colors.orangeAccent, Colors.deepOrangeAccent,Colors.redAccent],
                  center: Alignment(0.3, -0.5),
                  focal: Alignment(0.5, -0.1),
                  focalRadius: 1.5,
                ),
              ),
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 60),


                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(120.0),
                            child: Image.asset(
                              'images/icon.png',
                            ),
                          ),
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 30, top: 20, bottom: 7),
                        alignment: Alignment.bottomRight,
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)
                  ),
                ],
              ),
              child: TextFormField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.red,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: Colors.red,
                  ),
                  hintText: "Enter Email",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                validator: (String? value){
                  if (value!.isEmpty) return "Email can't be empty";
                  return null;
                },
                onChanged: (String value){
                  setState(() {
                    email = value;
                  });
                },
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffEEEEEE),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 20),
                      blurRadius: 100,
                      color: Color(0xffEEEEEE)
                  ),
                ],
              ),
              child: TextFormField(
                obscureText: offsecureText,
                controller: passwordCtrl,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  focusColor: Colors.red,
                  icon: const Icon(
                    Icons.vpn_key,
                    color: Colors.red,
                  ),
                  hintText: "Enter Password",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: IconButton(
                      icon: lockIcon,
                      onPressed: (){
                        lockPressed();
                  }),
                ),
                validator: (String? value){
                  if (value!.isEmpty) return "Password can't be empty";
                  return null;
                },
                onChanged: (String value){
                  setState(() {
                    pass = value;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPassword(),
                      )
                  );

                },
                child: const Text("Forget Password?"),
              ),
            ),

            GestureDetector(
              onTap: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(email: email, password: pass);
                  if (user != null) {
                    logindata.setBool('login', false);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        )
                    );
                  }
                } catch (error) {
                  Fluttertoast.showToast(
                      msg: error.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      fontSize: 16.0
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.red, Colors.redAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                  ),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)
                    ),
                  ],
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      //fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an Account?  "),
                  GestureDetector(
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      // Write Tap Code Here.
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          )
                      );
                    },

                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }



}

