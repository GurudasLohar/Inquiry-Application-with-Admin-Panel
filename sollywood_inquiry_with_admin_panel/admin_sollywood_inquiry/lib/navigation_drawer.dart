import 'package:admin_sollywood_inquiry/main.dart';
import 'package:admin_sollywood_inquiry/organisation_post_list.dart';
import 'package:admin_sollywood_inquiry/staff_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        children: <Widget>[
          createDrawerHeader(),

          createDrawerBodyItem(
              icon: Icons.wallet_giftcard_rounded,
              text: 'Organisation Post',
              onTap: () =>{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OrganisationPostList())),
              }
          ),

          createDrawerBodyItem(
              icon: Icons.list_alt,
              text: 'Staff List',
              onTap: () =>{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StaffList())),
              }
          ),

          createDrawerBodyItem(
              icon: Icons.business,
              text: 'Franchise Organisation',
              onTap: () =>{
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DocumentList())),
              }
          ),

          createDrawerBodyItem(
              icon: Icons.add_chart,
              text: 'Direct Sales',
              onTap: () =>{
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DocumentList())),
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp())),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  fontWeight: FontWeight.w900))
        ],
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
