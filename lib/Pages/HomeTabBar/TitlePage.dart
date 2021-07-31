import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({Key key}) : super(key: key);

  @override
  _TitlePageState createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('HomePageIcon').snapshots();

  @override
  Widget build(BuildContext context) {
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
            scrollDirection: Axis.horizontal,
            itemCount: data.docs.length,
            itemBuilder: (context, index) {
              return Container(
                  // height: 40,
                  margin: EdgeInsets.only(left: 5),
                  width: 75,
                  // color: Colors.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage(data.docs[index]['img'])),
                      Text(
                        data.docs[index]['title'],
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ));
            });
      },
    ));
  }
}
