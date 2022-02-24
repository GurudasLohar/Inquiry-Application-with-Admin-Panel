import 'package:admin_sollywood_inquiry/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminSignIn extends StatefulWidget {
  const AdminSignIn({Key? key}) : super(key: key);

  @override
  _AdminSignInState createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var passwordCtrl = TextEditingController();

  late String password;

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 10,
                    offset: const Offset(3, 3))
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Sollywood Inquiry',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Welcome to Admin Panel',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Form(
                      child: TextFormField(
                        controller: passwordCtrl,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Enter Password',
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                            contentPadding: const EdgeInsets.only(right: 0, left: 10),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey[300],
                                child: IconButton(
                                    icon: const Icon(Icons.close, size: 15),
                                    onPressed: () {
                                      passwordCtrl.clear();
                                    }),
                              ),
                            )),

                        validator: (String? value) {
                          if (value!.length == 0)
                            return "Password can't be empty";
                        },

                        onChanged: (String value) {
                          setState(() {
                            password = value;
                          });
                        },
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey[400]!,
                            blurRadius: 10,
                            offset: const Offset(2, 2))
                      ]),
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                    label: const Text(
                      'Sign In',
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    onPressed: () => {
                        submitLoginHandle(),
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

 void submitLoginHandle() {

   firestore
       .collection('admin')
       .doc('user type')
       .get()
       .then((DocumentSnapshot snap) {
        String? _aPass = snap['admin password'];

        if(password == _aPass){
          logindata.setBool('login', false);

          Navigator.push(context,MaterialPageRoute(builder: (context) => const HomeScreen()));

        } else {

          Fluttertoast.showToast(
              msg: "please enter valid password",
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }


   });
 }
}
