import 'dart:async';

import 'package:cosa_atm/map_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class loading_page extends StatefulWidget {
  const loading_page({Key? key}) : super(key: key);

  @override
  State<loading_page> createState() => _loading_pageState();
}

Future<void> _getPosition() async{
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  current_latitude = position.latitude;
  current_longitude = position.longitude;
  print(current_latitude);
  print(current_longitude);
}


class _loading_pageState extends State<loading_page> {

  @override
  void initState(){
    _getPosition();
    setCustomMapPin();
    Timer(Duration(milliseconds: 2000), () {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => map_page()
      )
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("아이콘"),
            Text("로고"),
            Text("© Copyright 2023, ATM"),
          ],
        ),
      ),
    );
  }
}