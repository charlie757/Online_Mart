import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:online_mart/Pages/Services/CRUD.dart';

import 'Modal/data.dart';

class HomeTabBar extends StatefulWidget {
  const HomeTabBar({Key key}) : super(key: key);

  @override
  _HomeTabBarState createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  // QuerySnapshot _shoes;
  // crudMethods crudObj = new crudMethods();
  // @override
  // void initState() {
  //   crudObj.getData().then((results) {
  //     setState(() {
  //       _shoes = results;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Shoes')
                .doc()
                .snapshots(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data.toString().length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot shoes = snapshot.data();
                    return ListTile(
                      // leading: Image.network(shoes['img']),
                      title: Text(shoes['brand']),
                    );
                  });
            }));
  }

  // Widget _shoesList() {
  //   if (_shoes != null) {
  //     return ListView.builder(
  //         itemCount: _shoes.docs.length,
  //         itemBuilder: (context, index) {
  //           return ListTile(
  //             title: Text(_shoes.docs[index].get('price')),
  //           );
  //         });
  //   } else {
  //     return Text("Loding, Please Wait....");
  //   }
  // }
}
