import 'package:admin_sollywood_inquiry/edit_staff_profile.dart';
import 'package:admin_sollywood_inquiry/list_franchise_inquiry.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home_screen.dart';
import 'list_registration_done.dart';

class StaffList extends StatefulWidget {
  const StaffList({Key? key}) : super(key: key);

  @override
  _StaffListState createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Staff Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
      ),


      body: Container(
        child: registrationList()
      )
    );
  }

  Widget registrationList(){

    final Stream<QuerySnapshot> staffStream =
    FirebaseFirestore.instance.collection('User Data').snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: staffStream,
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
            margin: const EdgeInsets.only(left: 10, right: 20, top: 20),
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
                                color: Colors.red
                            ),)
                      ),

                      DataColumn(
                          label: Text('ID number',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                      DataColumn(
                          label: Text('Password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                      DataColumn(
                          label: Text('View \n Registration',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                      DataColumn(
                          label: Text('View \n Franch. Inquiry',
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
                              Text(storedocs[i]['id number'],textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['password'],textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(Center(
                              child: IconButton(
                                  icon: Icon(Icons.list_outlined),
                                  onPressed: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListRegistrationDone(staffName: storedocs[i]['name'],staffNumber: storedocs[i]['contact number'],)));
                                  })
                          ),),
                          DataCell(Center(
                              child: IconButton(
                                  icon: Icon(Icons.list_outlined),
                                  onPressed: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListFranchiseInquiry(staffName: storedocs[i]['name'],staffNumber: storedocs[i]['contact number'],)));
                                  })
                          ),),
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
