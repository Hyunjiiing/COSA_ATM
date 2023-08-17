import 'dart:async';
import 'package:cosa_atm/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class loading_page extends StatefulWidget {
  const loading_page({Key? key}) : super(key: key);

  @override
  State<loading_page> createState() => _loading_pageState();
}

Future<void> _getPosition() async{
  LocationPermission permission = await Geolocator.requestPermission(); //오류 해결 코드
  Position position = await Geolocator.
  getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  current_latitude = position.latitude;
  current_longitude = position.longitude;
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
        width: MediaQuery.of(context).size.width,
        height:  MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/ATM_logo.png"),
            Text("© Copyright 2023, ATM"),
          ],
        ),
      ),
    );
  }
}