import 'package:admin_sollywood_inquiry/staff_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListFranchiseInquiry extends StatefulWidget {

  final String staffName;
  final String staffNumber;

  const ListFranchiseInquiry({Key? key, required this.staffName, required this.staffNumber}) : super(key: key);

  @override
  _ListFranchiseInquiryState createState() => _ListFranchiseInquiryState();
}

class _ListFranchiseInquiryState extends State<ListFranchiseInquiry> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           backgroundColor: Colors.red,
          title: Text('Franchise Inquiry by '+ widget.staffName),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const StaffList()));
            },
          ),
        ),
        body: Container(
            child: franchiseInquiryList()
        )
    );
  }

  Widget franchiseInquiryList(){

    late Stream<QuerySnapshot> RegistrationListStream = FirebaseFirestore.instance
        .collection('Franchise Inquiry')
        .where('inquiryBy', isEqualTo: widget.staffName)
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
