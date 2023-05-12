import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:photo_app/utils/utils.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({super.key, required this.name});

  final String name;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  File? _image;

  final picker = ImagePicker();

  final fireStore = FirebaseFirestore.instance.collection('posts');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 300,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _image == null
                  ? Text('No image selected.')
                  : Image.file(
                      _image!,
                      width: 200,
                      height: 200,
                    ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(160, 148, 227, 1)),
                ),
                onPressed: getImage,
                child: Text('Insert Image'),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      child: Text("Upload"),
                      onPressed: () {
                        firebase_storage.Reference ref = firebase_storage
                            .FirebaseStorage.instance
                            .ref('/posts/' +
                                DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString());
                        firebase_storage.UploadTask uploadTask =
                            ref.putFile(_image!.absolute);

                        Future.value(uploadTask).then((value) async {
                          var newUrl = await ref.getDownloadURL();
                          String id =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          fireStore.doc(id).set({
                            'user': widget.name,
                            'imageUrl': newUrl,
                            'id': id
                          }).then((value) {
                            Utils().toastMessage('uploaded');
                          }).onError((error, stackTrace) {
                            print(error.toString());
                          });
                        }).onError((error, stackTrace) {
                          Utils().toastMessage(error.toString());
                        });
                        Navigator.pop(context);
                      }),
                  const SizedBox(
                    width: 8,
                  ),
                  TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              )
            ]),
      ),
    );
  }
}
