import 'package:admin_sollywood_inquiry/organisation_post_list.dart';
import 'package:admin_sollywood_inquiry/staff_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dialog.dart';

class EditStaffProfile extends StatefulWidget {

  String staffName;
  String staffNumber;

  EditStaffProfile({Key? key, required this.staffName, required this.staffNumber}) : super(key: key);

  @override
  _EditStaffProfileState createState() => _EditStaffProfileState();
}

class _EditStaffProfileState extends State<EditStaffProfile> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var postSelection;
  var departmentSelection;
  var zoneSelection;
  var stateSelection;
  var districtSelection;
  var talukaSelection;

  String? _timestamp;

  var postSelectionCtrl = TextEditingController();
  var deptSelectionCtrl = TextEditingController();
  var zoneSelectionCtrl = TextEditingController();
  var stateSelectionCtrl = TextEditingController();
  var districtSelectionCtrl = TextEditingController();
  var talukaSelectionCtrl = TextEditingController();

  bool _isVisiblePost = true;
  bool _isVisibleZone = true;
  bool _isVisibleState = true;
  bool _isVisibleDistrict = true;
  bool _isVisibleTaluka = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Edit Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const OrganisationPostList()));
            },
          ),
        ),


        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                        colors: [Colors.orangeAccent, Colors.deepOrangeAccent,Colors.redAccent],)),
                  height: 100.0,
                  alignment: Alignment.center,
                  child: Text(widget.staffName, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),),
              ),
              const SizedBox(
                height: 40,
              ),

                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: departmentDropdown(),
                ),
              const SizedBox(height: 30,),

                Visibility(
                    visible: _isVisiblePost,

                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: organisationDropdown(),
                      ),
                      const SizedBox(height: 30,),

                    ],)),

                Visibility(
                    visible: _isVisibleZone,

                    child: Column(children: [

                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: zoneDropdown(),
                      ),
                      const SizedBox(height: 30,),

                    ],)),



                Visibility(
                    visible: _isVisibleState,

                    child: Column(children: [

                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: stateDropdown(),
                      ),
                      const SizedBox(height: 30,),

                    ],)),


                Visibility(
                    visible: _isVisibleDistrict,

                    child: Column(children: [

                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: districtDropdown(),
                      ),
                      const SizedBox(height: 30,),

                    ],)),


                Visibility(
                    visible: _isVisibleTaluka,

                    child: Column(children: [

                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: talukaDropdown(),
                      ),

                    ],)),



              const SizedBox(height: 50,),

              Container(
                height: 50,
                width: 250,
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
                    Icons.update_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                  label: const Text(
                    'Submit the changes',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  onPressed: () => {
                    submitProfileUpdateHandle(),
                  },
                ),
              ),
                const SizedBox(height: 20,),
            ],
            ),
        ),
        )
    );
  }

  Widget departmentDropdown() {

    final Stream<QuerySnapshot> OrgPostStream = 
    firestore
        .collection('Organisation Department')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: OrgPostStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs33 = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs33.add(a);
            a['id'] = document.id;
          }).toList();

          return Card(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey[300]!),),

                child: Row(
                  children: <Widget>[
                    Expanded (
                      child: DropdownButtonFormField(
                        itemHeight: 50,
                        decoration: const InputDecoration(border: InputBorder.none),
                        onChanged: (dynamic value) {
                          setState(() {
                            departmentSelection = value;
                          });
                        },
                        onSaved: (dynamic value) {
                          setState(() {
                            departmentSelection = value;
                          });
                        },
                        value: departmentSelection,
                        hint: const Text('Select Department'),
                        items: storedocs33.map((f33) {
                          return DropdownMenuItem(
                            child: new Text(f33['dept name']),
                            value: f33['dept name'],
                          );
                        }).toList(),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                      child: const Text('Add Dept'),
                      onPressed: () {
                        openDeptDialog();

                      },
                    ),
                  ],
                ),
              )
          );
        });
  }

  Future openDeptDialog() => showDialog
    (context: context,
      builder: (context) => AlertDialog(
        title: const Text('Department Name'),
        content: TextField(
          decoration: const InputDecoration(
              hintText: 'Enter Department Name'),
          controller: deptSelectionCtrl,
        ),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            child: const Text('Submit',style: TextStyle(color: Colors.white),),
            onPressed: submitDept,

          )
        ],
      ));

  void submitDept() {

    firestore.collection('Organisation Department').doc(_timestamp)
        .set({
      'dept name': deptSelectionCtrl.text,
    });
    openDialog(context, deptSelectionCtrl.text+' Department added successfully', '');
    deptSelectionCtrl.clear();
  }

  Widget organisationDropdown() {

    final Stream<QuerySnapshot> OrgPostStream = 
    firestore
          .collection('Organisation Post')
          .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: OrgPostStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs33 = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs33.add(a);
            a['id'] = document.id;
          }).toList();

          return Card(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey[300]!),),

                child: Row(
                  children: <Widget>[
                    Expanded (
                      child: DropdownButtonFormField(
                        itemHeight: 50,
                        decoration: const InputDecoration(border: InputBorder.none),
                        onChanged: (dynamic value) {
                          setState(() {
                            postSelection = value;
                            if(postSelection == 'National Head'){
                              setState(() {
                                _isVisibleZone = false;
                                _isVisibleState = false;
                                _isVisibleDistrict = false;
                                _isVisibleTaluka = false;
                              });
                            } else if (postSelection == 'Zonal Head'){
                              setState(() {
                                _isVisibleZone = true;
                                _isVisibleState = false;
                                _isVisibleDistrict = false;
                                _isVisibleTaluka = false;
                              });
                            } else if (postSelection == 'State Head'){
                              setState(() {
                                _isVisibleZone = true;
                                _isVisibleState = true;
                                _isVisibleDistrict = false;
                                _isVisibleTaluka = false;
                              });
                            } else if (postSelection == 'District Head'){
                              setState(() {
                                _isVisibleZone = true;
                                _isVisibleState = true;
                                _isVisibleDistrict = true;
                                _isVisibleTaluka = false;
                              });
                            } else if (postSelection == 'Taluka Head'){
                              setState(() {
                                _isVisibleZone = true;
                                _isVisibleState = true;
                                _isVisibleDistrict = true;
                                _isVisibleTaluka = true;
                              });
                            } else {
                              _isVisiblePost = true;
                              _isVisibleZone = true;
                              _isVisibleState = true;
                              _isVisibleDistrict = true;
                              _isVisibleTaluka = true;
                            }
                          });
                        },
                        onSaved: (dynamic value) {
                          setState(() {
                            postSelection = value;
                          });
                        },
                        value: postSelection,
                        hint: const Text('Select Organisation Post'),
                        items: storedocs33.map((f33) {
                          return DropdownMenuItem(
                            child: new Text(f33['post name']),
                            value: f33['post name'],
                          );
                        }).toList(),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                      child: const Text('Add Post'),
                      onPressed: () {
                        openPostDialog();

                      },
                    ),
                  ],
                ),
              )
          );
        });
  }

  Future openPostDialog() => showDialog
    (context: context,
      builder: (context) => AlertDialog(
        title: const Text('Organisation Post'),
        content: TextField(
          decoration: const InputDecoration(
              hintText: 'Enter Organisation Post'),
          controller: postSelectionCtrl,
        ),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            child: const Text('Submit',style: TextStyle(color: Colors.white),),
            onPressed: submitPost,
          )
        ],
      ));

  void submitPost() {
    firestore.collection('Organisation Post').doc(_timestamp)
        .set({
      'post name': postSelectionCtrl.text,
    });
    openDialog(context, postSelectionCtrl.text+' Organisation Post added successfully', '');
    postSelectionCtrl.clear();
  }

  Widget zoneDropdown() {

    final Stream<QuerySnapshot> zonePostStream =
    firestore
        .collection('Zone')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: zonePostStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs33 = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs33.add(a);
            a['id'] = document.id;
          }).toList();

          return Card(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey[300]!),),

                child: Row(
                  children: <Widget>[
                    Expanded (
                      child: DropdownButtonFormField(
                        itemHeight: 50,
                        decoration: const InputDecoration(border: InputBorder.none),
                        onChanged: (dynamic value) {
                          setState(() {
                            zoneSelection = value;
                          });
                        },
                        onSaved: (dynamic value) {
                          setState(() {
                            zoneSelection = value;
                          });
                        },
                        value: zoneSelection,
                        hint: const Text('Select Zone'),
                        items: storedocs33.map((f33) {
                          return DropdownMenuItem(
                            child: new Text(f33['zone name']),
                            value: f33['zone name'],
                          );
                        }).toList(),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                      child: const Text('Add Zone'),
                      onPressed: () {
                        openZoneDialog();

                      },
                    ),
                  ],
                ),
              )
          );
        });
  }

  Future openZoneDialog() => showDialog
    (context: context,
      builder: (context) => AlertDialog(
        title: const Text('Zone Name'),
        content: TextField(
          decoration: const InputDecoration(
              hintText: 'Enter Zone Name'),
          controller: zoneSelectionCtrl,
        ),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            child: const Text('Submit',style: TextStyle(color: Colors.white),),
            onPressed: submitZone,

          )
        ],
      ));

  void submitZone() {

    firestore.collection('Zone').doc(_timestamp)
        .set({
      'zone name': zoneSelectionCtrl.text,
    });
    openDialog(context, zoneSelectionCtrl.text+' Zone added successfully', '');
    zoneSelectionCtrl.clear();
  }

  Widget stateDropdown() {

    final Stream<QuerySnapshot> statePostStream = 
    firestore
        .collection('State')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: statePostStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs33 = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            //document.data()?.state name ?? "Not Assigned";
            Map a = document.data() as Map<String, dynamic>;
            storedocs33.add(a);
            a['id'] = document.id;
          }).toList();




          return Card(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey[300]!),),

                child: Row(
                  children: <Widget>[
                    Expanded (
                      child: DropdownButtonFormField(
                        itemHeight: 50,
                        decoration: const InputDecoration(border: InputBorder.none),
                        onChanged: (dynamic value) {
                          setState(() {
                            stateSelection = value;
                          });
                        },
                        onSaved: (dynamic value) {
                          setState(() {
                            stateSelection = value;
                          });
                        },
                        value: stateSelection,
                        hint: const Text('Select State'),
                        items: storedocs33.map((f33) {
                          return DropdownMenuItem(
                            child: new Text(f33['state name']),
                            value: f33['state name'],
                          );
                        }).toList(),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                      child: const Text('Add State'),
                      onPressed: () {
                        openStateDialog();

                      },
                    ),
                  ],
                ),
              )
          );
        });
  }

  Future openStateDialog() => showDialog
    (context: context,
      builder: (context) => AlertDialog(
        title: const Text('State Name'),
        content: TextField(
          decoration: const InputDecoration(
              hintText: 'Enter State Name'),
          controller: stateSelectionCtrl,
        ),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            child: const Text('Submit',style: TextStyle(color: Colors.white),),
            onPressed: submitState,

          )
        ],
      ));

  void submitState() {

    firestore.collection('State').doc(_timestamp)
        .set({
      'state name': stateSelectionCtrl.text,
    });
    openDialog(context, stateSelectionCtrl.text+' State added successfully', '');
    stateSelectionCtrl.clear();
  }

  Widget districtDropdown() {

    final Stream<QuerySnapshot> districtPostStream = 
    firestore
        .collection('District')
        .where('state name', isEqualTo: stateSelection)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: districtPostStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs33 = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs33.add(a);
            a['id'] = document.id;
          }).toList();

          return Card(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey[300]!),),

                child: Row(
                  children: <Widget>[
                    Expanded (
                      child: DropdownButtonFormField(
                        itemHeight: 50,
                        decoration: const InputDecoration(border: InputBorder.none),
                        onChanged: (dynamic value) {
                          setState(() {
                            districtSelection = value;
                          });
                        },
                        onSaved: (dynamic value) {
                          setState(() {
                            districtSelection = value;
                          });
                        },
                        value: districtSelection,
                        hint: const Text('Select District'),
                        items: storedocs33.map((f33) {
                          return DropdownMenuItem(
                            child: new Text(f33['district name']),
                            value: f33['district name'],
                          );
                        }).toList(),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                      child: const Text('Add District'),
                      onPressed: () {
                        openDistrictDialog();

                      },
                    ),
                  ],
                ),
              )
          );
        });
  }

  Future openDistrictDialog() => showDialog
    (context: context,
      builder: (context) => AlertDialog(
        title: const Text('District Name'),
        content: TextField(
          decoration: const InputDecoration(
              hintText: 'Enter district Name'),
          controller: districtSelectionCtrl,
        ),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            child: const Text('Submit',style: TextStyle(color: Colors.white),),
            onPressed: submitDistrict,
          )
        ],
      ));

  void submitDistrict() {
    firestore.collection('District').doc(_timestamp)
        .set({
      'district name' : districtSelectionCtrl.text,
      'state name': stateSelection,
    });
    openDialog(context, districtSelectionCtrl.text+' District added successfully', '');
    districtSelectionCtrl.clear();
  }

  Widget talukaDropdown() {

    final Stream<QuerySnapshot> talukaPostStream = 
    firestore
        .collection('Taluka')
        .where('state name', isEqualTo: stateSelection)
        .where('district name', isEqualTo: districtSelection)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: talukaPostStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs33 = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs33.add(a);
            a['id'] = document.id;
          }).toList();

          return Card(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey[300]!),),

                child: Row(
                  children: <Widget>[
                    Expanded (
                      child: DropdownButtonFormField(
                        itemHeight: 50,
                        decoration: const InputDecoration(border: InputBorder.none),
                        onChanged: (dynamic value) {
                          setState(() {
                            talukaSelection = value;
                          });
                        },
                        onSaved: (dynamic value) {
                          setState(() {
                            talukaSelection = value;
                          });
                        },
                        value: talukaSelection,
                        hint: const Text('Select Taluka'),
                        items: storedocs33.map((f33) {
                          return DropdownMenuItem(
                            child: new Text(f33['taluka name']),
                            value: f33['taluka name'],
                          );
                        }).toList(),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                      child: const Text('Add Taluka'),
                      onPressed: () {
                        openTalukaDialog();

                      },
                    ),
                  ],
                ),
              )
          );
        });
  }

  Future openTalukaDialog() => showDialog
    (context: context,
      builder: (context) => AlertDialog(
        title: const Text('Taluka Name'),
        content: TextField(
          decoration: const InputDecoration(
              hintText: 'Enter Taluka Name'),
          controller: talukaSelectionCtrl,
        ),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            child: const Text('Submit',style: TextStyle(color: Colors.white),),
            onPressed: submitTaluka,
          )
        ],
      ));

  void submitTaluka() {
    firestore.collection('Taluka').doc(_timestamp)
        .set({
      'taluka name' : talukaSelectionCtrl.text,
      'district name' : districtSelection,
      'state name': stateSelection,
    });
    openDialog(context, talukaSelectionCtrl.text+' Taluka added successfully', '');
    talukaSelectionCtrl.clear();
  }

  submitProfileUpdateHandle() {

    firestore.collection('User Data')
        .doc(widget.staffNumber)
        .update({
      'org department name' : departmentSelection,
      'org post' : postSelection,
      'org zone name': zoneSelection,
      'org state name': stateSelection,
      'org district name' : districtSelection,
      'org taluka name' : talukaSelection,
    });
  }
}
