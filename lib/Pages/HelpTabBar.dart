import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HelpTabBar extends StatefulWidget {
  const HelpTabBar({Key key}) : super(key: key);

  @override
  _HelpTabBarState createState() => _HelpTabBarState();
}

class _HelpTabBarState extends State<HelpTabBar> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Shoes').snapshots();
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Shoes')
        .doc('ZZn4fifwNu49PybKbEMe')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return new ListTile(
              title: new Text(data['brand']),
              subtitle: new Text(data['price']),
            );
          }).toList(),
        );
      },
    ));
  }
}
