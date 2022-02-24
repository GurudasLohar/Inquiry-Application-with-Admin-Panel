import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as p;
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpScreen> {

  final _auth = FirebaseAuth.instance;

  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  var nameCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var documentCtrl = TextEditingController();

  late String email;
  late String pass;
  late String name;
  late String phone;
  late String document;

  bool isVisible = false;

  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: Colors.red,
                    gradient: LinearGradient(colors: [Colors.red, Colors.redAccent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
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
                              "Sign Up",
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
                    controller: nameCtrl,
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.red,
                      ),
                      hintText: "Full Name",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                      validator: (String? value){
                        if (value!.isEmpty) return "name can't be empty";
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          name = value;
                        });
                      }
                  )
                ),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                    cursorColor: Colors.red,
                    decoration:  const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.red,
                      ),
                      hintText: "Email",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                      validator: (String? value){
                        if (value!.isEmpty) return "email can't be empty";
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          email = value;
                        });
                      }
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
                    controller: phoneCtrl,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      focusColor: Colors.red,
                      icon: Icon(
                        Icons.phone,
                        color: Colors.red,
                      ),
                      hintText: "Phone Number",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                      validator: (String? value){
                        if (value!.isEmpty) return "number can't be empty";
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          phone = value;
                        });
                      }
                  ),
                ),


                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                    controller: documentCtrl,
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.file_present,
                        color: Colors.red,
                      ),
                      hintText: "ID proof number",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                      validator: (String? value){
                        if (value!.isEmpty) return "ID number can't be empty";
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          document = value;
                        });
                      }
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                    controller: passCtrl,
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      focusColor: Colors.red,
                      icon: Icon(
                        Icons.vpn_key,
                        color: Colors.red,
                      ),
                      hintText: "Enter Password",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                      validator: (String? value){
                        if (value!.isEmpty) return "password can't be empty";
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          pass = value;
                        });
                      }
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
                      if (newUser != null) {

                        FirebaseFirestore.instance
                            .collection('User Data').doc(phone)
                            .set({
                          'contact number': phone,
                          'id number': document,
                          'email': email,
                          'name': name,
                          'password': pass,
                        });

                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
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
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
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
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?  "),
                      GestureDetector(
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.red
                          ),
                        ),
                        onTap: () {
                          // Write Tap Code Here.
                          Navigator.pop(context);
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