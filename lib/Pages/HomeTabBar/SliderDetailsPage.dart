import 'package:flutter/material.dart';

class SliderDetailsPage extends StatefulWidget {
  const SliderDetailsPage({Key key, this.img}) : super(key: key);
  final String img;

  @override
  _SliderDetailsPageState createState() => _SliderDetailsPageState();
}

class _SliderDetailsPageState extends State<SliderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online-Mart"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(),
        // child: Image.network(data.docs[index]['img']),
      ),
    );
  }
}
