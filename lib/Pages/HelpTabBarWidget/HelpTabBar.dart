import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_mart/Pages/HelpTabBarWidget/Expandable.dart';
import 'package:online_mart/Pages/OrdersTabBar.dart';
import 'package:online_mart/Utils/Constrains.dart';

class HelpTabBar extends StatefulWidget {
  const HelpTabBar({Key key}) : super(key: key);

  @override
  _HelpTabBarState createState() => _HelpTabBarState();
}

class _HelpTabBarState extends State<HelpTabBar> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void validate() {
    if (formkey.currentState.validate()) {
      print("Ok");
    } else {
      print("Error");
    }
  }

  // For Add Data
  TextEditingController sampleData = TextEditingController();
  TextEditingController sampleData1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => DetailsPage());
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 10, top: 15),
        child: ListView(
          clipBehavior: Clip.antiAlias,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            _BuildForm(),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Registration",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            expandablePage(),
          ],
        ),
      ),
    );
  }

  Widget _BuildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          color: lightblack,
          width: 450,
          height: 35,
          child: Text(
            "FAQs",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Frequently Asked Questions:"),
        SizedBox(
          height: 10,
        ),
        Text(
            "Check out this section to get answers for all the frequently asked questions.")
      ],
    );
  }

//Add data
  Widget DetailsPage() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
            key: formkey,
            child: ListView(
              children: [
                TextFormField(
                  controller: sampleData,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "required";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: sampleData1,

                  // expands: true,
                  maxLines: 20,
                  maxLength: 500,
                  minLines: 1,
                  decoration: InputDecoration(labelText: 'SubTitle'),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "required";
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
                      validate();

                      Map<String, dynamic> data = {
                        "title": sampleData.text,
                        "subtitle": sampleData1.text
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
