import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inquiry/home_screen.dart';

class ListFranchiseInquiry extends StatefulWidget {
  const ListFranchiseInquiry({Key? key}) : super(key: key);

  @override
  _ListFranchiseInquiryState createState() => _ListFranchiseInquiryState();
}

class _ListFranchiseInquiryState extends State<ListFranchiseInquiry> {


  var currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? userMap;



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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Franchise Inquiry List'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
      ),

      body:  Container(
          child: inquiryList()
      ),
    );
  }


  Widget inquiryList(){

    late Stream<QuerySnapshot> RegistrationListStream = FirebaseFirestore.instance
        .collection('Franchise Inquiry')
        .where('inquiryBy', isEqualTo: userMap?['name'])
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: RegistrationListStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: const EdgeInsets.only(left: 10, right: 20, top: 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        )),
                    columns: const [
                      DataColumn(
                          label: Text('Name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Colors.red,
                            ),)
                      ),
                      DataColumn(
                          label: Text('Contact Number',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Colors.red,
                            ),)
                      ),
                      DataColumn(
                          label: Text('Email Address',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Colors.red,
                            ),)
                      ),
                      DataColumn(
                          label: Text('City',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),

                      DataColumn(
                          label: Text('Area',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                      DataColumn(
                          label: Text('Product',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                      DataColumn(
                          label: Text('Date & Time',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                    ],

                    rows: [
                      for (var i = 0; i < storedocs.length; i++) ...[
                        DataRow(cells: [
                          DataCell(
                              Text(storedocs[i]['name'],textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['contact number'],textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['email'],textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['city']??='NA',textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['area']??='NA',textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['product']??='NA',textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['DateTime']??='NA',textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                        ]),
                      ]
                    ]
                ),
              ),
            ),
          );
        });
  }
}
