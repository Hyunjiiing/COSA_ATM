import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosa_atm/pages/map_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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
  List<Marker> marker=[];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage storage=FirebaseStorage.instance;
  String url="";

  Future<void> add_marker(double lat,double lon,String url)async {
    marker.add(
        Marker(
            markerId: MarkerId("${lat},${lon}"),
            draggable: true,
            position: LatLng(lat,lon),
            onTap: () async {
              List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
              String locality="${placemarks[0].locality}";
              String subLocality="${placemarks[0].subLocality}";
              String thoroughfare="${placemarks[0].thoroughfare}";
              String subThoroughfare="${placemarks[0].subThoroughfare}";
              String address = locality + " " + subLocality + " " + thoroughfare + " " + subThoroughfare;
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context){
                    return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        actionsPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.zero,
                        content: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.60,
                          child: Column(
                            children: [
                              Container(
                                  height: MediaQuery.of(context).size.height/100*8,
                                  child: Center(child: Text("맨홀 사진",style: TextStyle(fontSize: 30,fontFamily: 'Bit',),))
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width*0.70,
                                  height: MediaQuery.of(context).size.height*0.35,
                                  child: Image.network(url,fit: BoxFit.cover,)
                              ),
                              Container(
                                  height: MediaQuery.of(context).size.height/100*8,
                                  child: Center(child: Text("${address}",style: TextStyle(fontSize: 15,fontFamily: 'Bit',),))
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height*0.08,
                                width: MediaQuery.of(context).size.width*0.4,
                                child: MaterialButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: Center(child: Text("확인",style: TextStyle(fontFamily: "Bit",fontSize: 20),)),
                                ),
                              )
                            ],
                          ),
                        )
                    );
                  }
              );
            },
            icon: BitmapDescriptor.fromBytes(markerIcon)
        )
    );
  }
  getImageUrl(DocumentSnapshot ds, double lat,double lon)async{
    final firebaseStorageRef = storage.ref().child('manhole').child('${lat},${lon}.png');
    url= await firebaseStorageRef.getDownloadURL();
    add_marker(double.parse(ds.get("lat")), double.parse(ds.get("lon")),url);
  }

  @override
  void initState(){
    _getPosition();
    setCustomMapPin();
    _firestore.collection("Marker").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        url = getImageUrl(ds,double.parse(ds.get("lat")), double.parse(ds.get("lon"))).toString();
      }
    });
    Timer(Duration(milliseconds: 2000), () {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => map_page(marker: marker,)
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