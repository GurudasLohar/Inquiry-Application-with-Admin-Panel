import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:inquiry/documents_list.dart';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';

class DocumentUpload4 extends StatefulWidget {
  const DocumentUpload4({Key? key}) : super(key: key);

  @override
  _DocumentUpload4State createState() => _DocumentUpload4State();
}

class _DocumentUpload4State extends State<DocumentUpload4> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  final ImagePicker _picker = ImagePicker();

  String? imageUrl;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Documents'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DocumentList()));
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.center,
          children: [
            const Text('PAN Card Photo',
              style: TextStyle(fontSize: 20),
            ),

            const Padding(
              padding: EdgeInsets.all(10.0),
            ),

            if (imageUrl == null)
              InkWell(

                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,

                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:AssetImage("images/image.png"),
                      ),
                    ),
                  ),
                ),

            if (imageUrl != null)
              InkWell(

                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,

                onTap: () => _selectPhoto(),
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          imageUrl!),
                    ),
                  ),
                ),
              ),

            InkWell(
              onTap: () => _selectPhoto(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(imageUrl != null
                    ? 'Change Document'
                    : 'Select Document',
                  style: TextStyle(fontSize:15,color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
              ),
            )
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

    final User? user = auth.currentUser;
    final userid = user?.uid;

    final ref = storage.FirebaseStorage.instance.ref()
        .child('staff documents')
        .child('$userid')
        .child('PAN Card Photo')
        .child('${DateTime.now().toIso8601String() + p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() { imageUrl = fileUrl; });

    Fluttertoast.showToast(
        msg: "PAN Card Photo uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
