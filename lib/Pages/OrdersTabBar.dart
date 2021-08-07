import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_mart/CRUD/crudService.dart';

class OrdersTabBar extends StatefulWidget {
  const OrdersTabBar({Key key, this.documentId}) : super(key: key);
  final String documentId;

  @override
  _OrdersTabBarState createState() => _OrdersTabBarState();
}

class _OrdersTabBarState extends State<OrdersTabBar> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  TextEditingController img = TextEditingController();
  File image;
  String imgUrl;
  sendData() async {
    if (formkey.currentState.validate()) {
      var storageImage = FirebaseStorage.instance.ref().child(image.path);
      var task = storageImage.put(image);
      // imgUrl = await (await task.file.
      await FirebaseFirestore.instance
          .collection('HelpField')
          .add({'title': title.text, 'img': img, 'subtitle': subtitle});
    }
  }

  Future getImage() async {
    var img = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img as File;
    });
  }

  crudService crudObj = crudService();
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('HelpField').snapshots();
  // For Update Data

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Somthing went Wrong");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }
        final data = snapshot.requireData;
        return ListView.builder(
          itemCount: data.docs.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return InkWell(
                child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.docs[index]['title']),
                Text(data.docs[index]['subtitle'])
              ],
            ));
          },
        );
      },
    ));
  }

  //Add data
  Widget DetailsPage() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
            key: formkey,
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    getImage();
                  },
                  child: CircleAvatar(
                      radius: 100,
                      backgroundImage: image != null
                          ? FileImage(image)
                          : NetworkImage('null')),
                ),
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "It is empty";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: subtitle,
                  maxLines: 20,
                  maxLength: 500,
                  minLines: 1,
                  decoration: InputDecoration(labelText: 'SubTitle'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "It is empty";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      Map<String, dynamic> data = {
                        // "title": sampleData,
                        // "subtitle": sampleData1
                      };
                      FirebaseFirestore.instance
                          .collection('HelpField')
                          .add(data);

                      Navigator.of(context).pop();
                    },
                    child: Material(
                      child: Container(
                        alignment: Alignment.center,
                        // color: lightblack,
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ))
              ],
            )));
  }
}
