import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inquiry/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? userMap;

  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  late String userPhoto;

  late SharedPreferences logindata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
    getuserMap();
  }


  void initial() async {
    logindata = await SharedPreferences.getInstance();
  }

  Future getuserMap() async {
    if (currentUser == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      await firestore.collection('User Data')
          .where("email", isEqualTo: currentUser?.email)
          .get()
          .then((value) {
        setState(() {
          userMap = value.docs[0].data();
        });
      });
      userPhoto =(userMap?['id photo']);
      print(userMap);
    }
  }

  @override
  Widget build(BuildContext context) {

    if (userMap?['id photo'] == null){
      userPhoto = "images/user.jpg";
    }else{
      userPhoto = (userMap?['id photo']).toString();
    }

    return SingleChildScrollView(
        child: Column(
          children: [
            //for circle avtar image
            _getHeader(),
            const SizedBox(
              height: 20,
            ),
            _heading("Personal Details"),
            const SizedBox(
              height: 6,
            ),
            _detailsCard(),
            const SizedBox(
              height: 10,
            ),
            _heading("Settings"),
            const SizedBox(
              height: 6,
            ),
            _settingsCard(),
          ],
        )
    );
  }

  Widget _getHeader() {
    return Container(
        width: double.infinity,
        height: 200.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.grey.shade100, Colors.grey.shade100]
            )
        ),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => {
                      // _selectPhoto(),
                },
            child: const CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('images/user.png'),
            radius: 60.0,
            ),
          ),
        ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80, //80% of width,
              child: Center(
                child: Text((userMap?['name']),
                      style: const TextStyle(
                      color: Colors.black, fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ),
            )
        ],
      )
    );
  }

  Widget _heading(String heading) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Text(heading, style: const TextStyle(fontSize: 17),
      ),
    );
  }

  Widget _detailsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children:[
            ListTile(
              leading: const Icon(Feather.mail, color: Colors.redAccent,),
              title: Text((userMap?['email']), style: const TextStyle(fontSize: 15),),
            ),
            const Divider(
              height: 0.6,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Feather.phone_call, color: Colors.redAccent),
              title: Text((userMap?['contact number']), style: const TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each details
            ListTile(
              leading: const Icon(Feather.inbox, color: Colors.redAccent),
              title: const Text("Contact Us", style: TextStyle(fontSize: 15)),
              onTap: (){
                  launch('mailto:sollywoodinquiry@gmail.com');
              },
            ),
            const Divider(
              height: 0.6,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Feather.log_out, color: Colors.redAccent),
              title: const Text("Log Out", style: const TextStyle(fontSize: 15)),
              onTap: (){
                logindata.setBool('login', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }


  Future _selectPhoto() async {
    await showModalBottomSheet(context: context, builder: (context) => BottomSheet(
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(leading: const Icon(Icons.camera), title: const Text('Camera'), onTap: () {
            Navigator.of(context).pop();
            _pickImage(ImageSource.camera);
          }),
          ListTile(leading: const Icon(Icons.filter), title: const Text('Pick a file'), onTap: () {
            Navigator.of(context).pop();
            _pickImage(ImageSource.gallery);
          }),
        ],
      ),
      onClosing: () {},
    ));
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }

    await _uploadFile(pickedFile.path);
  }


  Future _uploadFile(String path) async {


    final ref = storage.FirebaseStorage.instance.ref()
        .child('Profile Photo')
        .child(userMap?['email'])
        .child('Passport Photo')
        .child('${DateTime.now().toIso8601String() + p.basename(path)}');


    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imageUrl = fileUrl;
      userPhoto = fileUrl;
    });
  }
}
