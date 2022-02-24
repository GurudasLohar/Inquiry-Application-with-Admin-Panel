import 'package:flutter/material.dart';
import 'package:inquiry/documents_list.dart';
import 'package:inquiry/franchise_inquiry.dart';
import 'package:inquiry/home_screen.dart';
import 'package:inquiry/list_franchise_inquiry.dart';
import 'package:inquiry/list_registration_done.dart';
import 'package:inquiry/person_registration.dart';
import 'package:inquiry/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.how_to_reg,
            text: 'Person Registration',
            onTap: () =>{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())),
            }
          ),

          createDrawerBodyItem(
              icon: Icons.list_outlined,
              text: 'Person Registration List',
              onTap: () =>{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListRegistrationDone())),
              }
          ),

          createDrawerBodyItem(
              icon: Icons.app_registration,
              text: 'Franchise Inquiry',
              onTap: () =>{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())),
              }
          ),

          createDrawerBodyItem(
              icon: Icons.list_outlined,
              text: 'Franchise Inquiry List',
              onTap: () =>{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListFranchiseInquiry())),
              }
          ),

          createDrawerBodyItem(
              icon: Icons.file_present,
              text: 'Upload Document',
              onTap: () =>{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DocumentList())),
              }
          ),

          createDrawerBodyItem(
            icon: Icons.inbox,
            text: 'Contact US',
            onTap: () => {
                launch('mailto:sollywoodinquiry@gmail.com'),
            }
          ),

          Card(
            child:  ListTile(
              title: Row(
                children: const <Widget>[
                  Icon(Icons.logout, color: Colors.red,),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Log Out', style: TextStyle(fontWeight: FontWeight.w500),),
                  )
                ],
              ),
              onTap: () => {
                logindata.setBool('login', true),
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())),
              },
            ),
          ),

          const Divider(
            color: Colors.grey,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.orangeAccent, Colors.deepOrangeAccent,Colors.redAccent],
          center: Alignment(0.3, -0.5),
          focal: Alignment(0.5, -0.1),
          focalRadius: 1.5,
        ),
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 38,
                  child: ClipRRect(
                    child: Image.asset(
                      'images/icon.png',
                    ),
                  ),
                )
            ),
            const SizedBox(height: 10,),

            const Text("Sollywood Inquiry",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }

  Widget createDrawerBodyItem(
      {required IconData icon, required String text, required GestureTapCallback onTap}) {
    return Card(
      child:  ListTile(
        title: Row(
          children: <Widget>[
            Icon(icon, color: Colors.red,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text, style: TextStyle(fontWeight: FontWeight.w500),),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}