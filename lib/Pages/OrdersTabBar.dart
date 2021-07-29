import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersTabBar extends StatefulWidget {
  const OrdersTabBar({Key key, this.documentId}) : super(key: key);
  final String documentId;

  @override
  _OrdersTabBarState createState() => _OrdersTabBarState();
}

class _OrdersTabBarState extends State<OrdersTabBar> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Shoes');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc('ZZn4fifwNu49PybKbEMe').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          return ListTile(title: Text(data['brand']));
        }

        return Text("loading");
      },
    );
  }
}
