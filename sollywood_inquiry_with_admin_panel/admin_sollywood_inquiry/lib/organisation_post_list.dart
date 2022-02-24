import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit_staff_profile.dart';
import 'home_screen.dart';

class OrganisationPostList extends StatefulWidget {
  const OrganisationPostList({Key? key}) : super(key: key);

  @override
  _OrganisationPostListState createState() => _OrganisationPostListState();
}

class _OrganisationPostListState extends State<OrganisationPostList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text("Organisation Post Details"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
        ),
      ),
      body: Container(
        child: postDetailsList(),
      ),
    );
  }


  Widget postDetailsList(){

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
                          label: Text('Department',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),

                      DataColumn(
                          label: Text('Post',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                      DataColumn(
                          label: Text('Zone',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                      DataColumn(
                          label: Text('State',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                      DataColumn(
                          label: Text('District',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                      DataColumn(
                          label: Text('Taluka',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                      DataColumn(
                          label: Text('Edit Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.red
                            ),)
                      ),
                      DataColumn(
                          label: Text('Delete Profile',
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
                              Text(storedocs[i]['org department name'],textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['org post']??='Nil',textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['org zone name']??='Nil',textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['org state name']??='Nil',textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['org district name']??='Nil',textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              Text(storedocs[i]['org taluka name']??='Nil',textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
                          ),
                          DataCell(
                              IconButton(
                                  icon: Icon(Icons.edit_road),
                                  onPressed: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditStaffProfile(staffName: storedocs[i]['name'], staffNumber: storedocs[i]['contact number'],)));
                                  })
                          ),
                          DataCell(
                              IconButton(
                                  icon: Icon(Icons.delete_forever_outlined),
                                  onPressed: (){

                                  })
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
