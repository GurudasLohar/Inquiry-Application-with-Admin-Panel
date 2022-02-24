import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inquiry/login_screen.dart';

import 'dialog.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  var emailCtrl = TextEditingController();
  late String _email;


  Future<void> resetPassword(String email) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try{
      await auth.sendPasswordResetEmail(email: email);
      openDialog(context, 'Reset Password', 'An email has been sent to $email. \n\nGo to that link & reset your password.');

    } catch(error){
      openDialog(context, 'Error: ',error.toString());
      //openSnacbar(scaffoldKey, error.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Forget Password'),
            backgroundColor: Colors.red,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
            ),
        ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30,top: 80),
          child: ListView(
            children: <Widget>[

              const SizedBox(height: 20,),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,

              ),
              const Text('Reset your password', style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.w700,
              ), textAlign: TextAlign.center,),
              const Text('follow the simple steps', style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey
              ),textAlign: TextAlign.center,),
              const SizedBox(
                height: 50,
              ),

              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'username@mail.com',
                    labelText: 'Email Address'
                  //suffixIcon: IconButton(icon: Icon(Icons.email), onPressed: (){}),

                ),
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value){
                  if (value!.length == 0) return "Email can't be empty";
                  return null;
                },
                onChanged: (String value){
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(height: 60,),


              GestureDetector(
                onTap: () {
                  resetPassword(_email);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50,),

            ],
          ),
        ),
      ),
    );
  }
}
