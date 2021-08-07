import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationPage extends StatefulWidget {
  const CurrentLocationPage({Key key}) : super(key: key);

  @override
  _CurrentLocationPageState createState() => _CurrentLocationPageState();
}

class _CurrentLocationPageState extends State<CurrentLocationPage> {
  var locationMessage = '';

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    setState(() {
      locationMessage = '$position.latitude,$position.longitude';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            size: 46,
            color: Colors.blue,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Get User Location",
              style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 20),
          Text(locationMessage),
          FlatButton(
              onPressed: () {
                getCurrentLocation();
              },
              color: Colors.blue[800],
              child: Text("Get Current Location",
                  style: TextStyle(color: Colors.white))),
        ],
      )),
    );
  }
}
