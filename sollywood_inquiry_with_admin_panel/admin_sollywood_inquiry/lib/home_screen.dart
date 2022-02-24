import 'package:admin_sollywood_inquiry/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late SharedPreferences logindata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              logindata.setBool('login', true);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MyApp()));
            },
          )
        ],
        title: const Text("Sollywood Inquiry"),
      ),
      drawer: const NavigationDrawer(),

      body: Center(
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                child: SizedBox(
                  height: 150,
                  width: 350,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    shadowColor: Colors.redAccent.shade100,
                    elevation: 30,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                  child: SizedBox(
                    height: 200,
                    width: 180,
                    child: Card(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                      color: Colors.white,
                      shadowColor: Colors.redAccent.shade100,
                      elevation: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                  child: SizedBox(
                    height: 200,
                    width: 180,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      shadowColor: Colors.redAccent.shade100,
                      elevation: 50,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
              child: SizedBox(
                height: 150,
                width: 350,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  shadowColor: Colors.redAccent.shade100,
                  elevation: 30,
                ),
              ),
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
      )
    );
  }
}
