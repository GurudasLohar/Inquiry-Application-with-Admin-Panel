import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'navigation_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class FranchiseInquiry extends StatefulWidget {
  const FranchiseInquiry({Key? key}) : super(key: key);

  @override
  _FranchiseInquiryState createState() => _FranchiseInquiryState();
}

class _FranchiseInquiryState extends State<FranchiseInquiry> {


  var currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? userMap;

  var nameCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var productCtrl = TextEditingController();
  var areaCtrl = TextEditingController();
  var cityCtrl = TextEditingController();


  late String name;
  late String phone;
  late String email;
  late String product;
  late String area;
  late String city;

  String? _timestamp;
  String? _date;

  String currentAddress = 'Current Address';
  late Position currentposition;

  late SharedPreferences logindata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
    getuserMap();
    getDate();
    _determinePosition();
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
    }
  }

  Future getDate() async {
    DateTime now = DateTime.now();
    String _d = DateFormat('dd MMMM yy').format(now);
    String _t = DateFormat('yyyyMMddHHmmss').format(now);
    setState(() {
      _timestamp = _t;
      _date = _d;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Form(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
          child: ListView(
            children: <Widget>[

              const SizedBox(height: 20,),

              const Text('Franchise Inquiry', style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w900),textAlign: TextAlign.center),
              const SizedBox(height: 5,),

              const Text('follow the simple steps', style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent),textAlign: TextAlign.center),
              const SizedBox(height: 30,),

              TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                      hintText: 'Enter Person Name',
                      labelText: 'Full Name'
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) return "name can't be empty";
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      name = value;
                    });
                  }
              ),
              const SizedBox(height: 20,),

              TextFormField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                    hintText: 'Enter Contact Number',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) return "number can't be empty";
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      phone = value;
                    });
                  }
              ),
              const SizedBox(height: 20,),


              TextFormField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter Email Address',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) return "email can't be empty";
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  }
              ),
              const SizedBox(height: 20,),

              TextFormField(
                  controller: productCtrl,
                  decoration: const InputDecoration(
                      hintText: 'Enter Product Description',
                      labelText: 'Product'
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) return "product can't be empty";
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      product = value;
                    });
                  }
              ),
              const SizedBox(height: 20,),

              TextFormField(
                  controller: areaCtrl,
                  decoration: const InputDecoration(
                      hintText: 'Enter Area Name',
                      labelText: 'Area'
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) return "area name can't be empty";
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      area = value;
                    });
                  }
              ),
              const SizedBox(height: 20,),


              TextFormField(
                  controller: cityCtrl,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    hintText: 'Enter City Name',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) return "city name can't be empty";
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      city = value;
                    });
                  }
              ),
              const SizedBox(height: 30,),

              Row(
                children: [
                  Container(
                    child: Text('Current Location: \n' +currentAddress,
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 17, fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
              const SizedBox(height: 40,),

              SizedBox(
                height: 45,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((
                            states) => Colors.red)
                    ),
                    child: const Text('Submit',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    onPressed: () {
                      saveRegistration();
                    }),
              ),
              const SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }

  void saveRegistration() {
    FirebaseFirestore.instance
        .collection('Franchise Inquiry').doc(phone)
        .set({
      'area': area,
      'city': city,
      'contact number': phone,
      'name': name,
      'email': email,
      'product': product,
      'inquiryBy' : userMap!['name'],
      'DateTime' : _timestamp,
      'currentLocation' : currentAddress,
    });

    Fluttertoast.showToast(
        msg: "Franchise Inquiry submitted successfully",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );

    nameCtrl.clear();
    phoneCtrl.clear();
    emailCtrl.clear();
    productCtrl.clear();
    areaCtrl.clear();
    cityCtrl.clear();
  }


  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
      print(currentAddress);
      print(currentposition);
    } catch (e) {
      print(e);
    }
  }
}
