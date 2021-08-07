import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:online_mart/Utils/Constrains.dart';

import '../../CRUD/crudService.dart';

class expandablePage extends StatefulWidget {
  const expandablePage({Key key}) : super(key: key);

  @override
  _expandablePageState createState() => _expandablePageState();
}

class _expandablePageState extends State<expandablePage> {
  crudService crudObj = crudService();

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('HelpField').snapshots();

  String title;
  String subtitle;

  //Update  the data

  Future<bool> updateDialog(BuildContext context, selectDoc) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                "Update Data And Please do not give the blank of TextField"),
            content: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  onChanged: (value) {
                    this.title = value;
                  },
                ),
                TextField(
                  maxLines: 20,
                  maxLength: 500,
                  minLines: 1,
                  decoration: InputDecoration(labelText: 'SubTitle'),
                  onChanged: (value) {
                    this.subtitle = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      crudObj
                          .updateData(selectDoc, {
                            'title': this.title,
                            'subtitle': this.subtitle,
                          })
                          .then((result) {})
                          .catchError((e) {
                            print(e);
                          });
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
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return buildText(context);
  }

  Widget buildText(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
          physics: ScrollPhysics(),
          clipBehavior: Clip.antiAlias,
          itemBuilder: (BuildContext context, index) {
            return InkWell(
                onTap: () {
                  //Update the data
                  updateDialog(context, data.docs[index].id);
                },
                onLongPress: () {
                  // Delete teh data
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 5),
                    content: Text(
                      "Are you sure you want to delete me?",
                      style: TextStyle(fontSize: 15),
                    ),
                    action: SnackBarAction(
                        label: 'Yes',
                        textColor: Colors.green,
                        onPressed: () {
                          crudObj.deleteData(data.docs[index].id);
                        }),
                  ));
                },
                child: Column(
                  children: [
                    ExpansionTile(
                      // initiallyExpanded: true,
                      title: Text(data.docs[index]['title']),
                      expandedAlignment: Alignment.topLeft,
                      childrenPadding: EdgeInsets.only(bottom: 5),

                      children: [
                        Text(
                          data.docs[index]['subtitle'],
                          style: TextStyle(color: black1),
                        ),
                      ],
                    ),
                    DottedLine(dashGapLength: 1, dashColor: Colors.black26)
                  ],
                ));
          },
        );
      },
    );
  }
}
