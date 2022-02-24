import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:inquiry/document_upload1.dart';
import 'package:inquiry/document_upload4.dart';
import 'package:inquiry/document_upload5.dart';
import 'package:inquiry/document_upload6.dart';
import 'package:inquiry/home_screen.dart';

import 'document_upload2.dart';
import 'document_upload3.dart';

class DocumentList extends StatefulWidget {
  const DocumentList({Key? key}) : super(key: key);

  @override
  _DocumentListState createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
           title: const Text('Document List'),
          backgroundColor: Colors.red,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
          ),
        ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 40, 20, 50),
          children: [

            const Text("All the documents are mandatory*", style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 35,),

            Divider(height: 3,
            color: Colors.grey.shade700,),

            ListTile(
              title: const Text('Resume Photo'),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: const Icon(Feather.image, size: 20, color: Colors.white),
              ),
              trailing:  const Icon(Feather.chevron_right, size: 20,),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentUpload1()));
              },

            ),

            Divider(height: 3,
              color: Colors.grey.shade700,),

            ListTile(
              title: const Text('Passport Photo'),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: const Icon(Feather.image, size: 20, color: Colors.white),
              ),
              trailing:  const Icon(Feather.chevron_right, size: 20,),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentUpload2()));
              },
            ),

            Divider(height: 3,
              color: Colors.grey.shade700,),

            ListTile(
              title: const Text('Aadhaar Card Photo'),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: const Icon(Feather.image, size: 20, color: Colors.white),
              ),
              trailing:  const Icon(Feather.chevron_right, size: 20,),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentUpload3()));
              },
            ),

            Divider(height: 3,
              color: Colors.grey.shade700,),

            ListTile(
              title: const Text('PAN Card Photo'),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: const Icon(Feather.image, size: 20, color: Colors.white),
              ),
              trailing:  const Icon(Feather.chevron_right, size: 20,),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentUpload4()));
              },
            ),

            Divider(height: 3,
              color: Colors.grey.shade700,),

            ListTile(
              title: const Text('Family Photo'),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: const Icon(Feather.image, size: 20, color: Colors.white),
              ),
              trailing:  const Icon(Feather.chevron_right, size: 20,),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentUpload5()));
              },
            ),

            Divider(height: 3,
              color: Colors.grey.shade700,),

            ListTile(
              title: const Text('Bank Details Photo'),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: const Icon(Feather.image, size: 20, color: Colors.white),
              ),
              trailing:  const Icon(Feather.chevron_right, size: 20,),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentUpload6()));
              },
            ),

            Divider(height: 3,
              color: Colors.grey.shade700,),

          ],
        )
    );
  }

  Widget _settingsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each deatails
            ListTile(
              leading: const Icon(Feather.inbox, color: Colors.redAccent),
              title: const Text("Contact Us", style: TextStyle(fontSize: 15)),
              onTap: (){
                //launch('mailto:sollywoodinquiry@gmail.com');
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
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
