import 'dart:async';

import 'package:cosa_atm/bottom_bar.dart';
import 'package:cosa_atm/camera_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:camera/camera.dart';


class map_page extends StatefulWidget {
  const map_page({Key? key}) : super(key: key);

  @override
  State<map_page> createState() => _map_pageState();
}


double current_latitude =0;
double current_longitude =0;


List<Marker> _markers = [
  Marker(markerId: MarkerId("맨홀1"),draggable: true,position: LatLng(36.6305, 127.4578),infoWindow: InfoWindow(title: "1234")),
  Marker(markerId: MarkerId("전봇대1"),draggable: true,position: LatLng(36.6299, 127.4590),infoWindow: InfoWindow(title: "5678"))

];

Future<void> _getPosition() async{
  LocationPermission permission = await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  current_latitude = position.latitude;
  current_longitude = position.longitude;
}

class _map_pageState extends State<map_page> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition My_location = CameraPosition(
    target: LatLng(current_latitude, current_longitude),
    zoom: 15,
  );

  @override
  void initState() {
    // TODO: implement initState
    _getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            markers: Set.from(_markers),
            initialCameraPosition: CameraPosition(
                target: LatLng(current_latitude,current_longitude)
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              setState(() {
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(current_latitude,current_longitude),
                            zoom : 15
                        )
                    )
                );
              });
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/100*5),
              width: MediaQuery.of(context).size.width/100*80,
              height: MediaQuery.of(context).size.height/100*13,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.account_circle,color: Colors.white,size: 40,),
                          Container(
                            width: MediaQuery.of(context).size.width/100*15,
                            height: MediaQuery.of(context).size.height/100*2.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(child: Text("LeeDY",style: TextStyle(fontSize: 10),)),
                          )
                        ],
                      ),
                      Icon(Icons.pets,size: 55,color: Colors.white,),
                      Container(
                        width: MediaQuery.of(context).size.width/100*30,
                        height: MediaQuery.of(context).size.height/100*10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/100*30,
                              height: MediaQuery.of(context).size.height/100*4,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.currency_bitcoin,color: Colors.yellow,),
                                  Container(
                                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/100*4),
                                      child: Text("1240W",style: TextStyle(color: Colors.white),)
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/100*30,
                              height: MediaQuery.of(context).size.height/100*4,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Container(
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/100*1),
                                child: Row(
                                  children: [
                                    Icon(Icons.leaderboard,color: Colors.yellow,),
                                    Container(
                                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/100*4),
                                        child: Text("LV.1",style: TextStyle(color: Colors.white),)
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/100*70,
                        height: MediaQuery.of(context).size.height/100*1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/100*50,
                        height: MediaQuery.of(context).size.height/100*1,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      )
                    ],
                  ) //경험치 바
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MaterialButton(
              child: Container(
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text("내 위치")
                  ],
                ),
              ),
              onPressed: (_goToTheMyLocation),
            ),
          )
        ],
      ),
      bottomNavigationBar: bottom_bar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MaterialButton(
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.yellow
          ),
          child: Icon(Icons.camera_alt,color: Colors.black,),
        ),
        onPressed: () async {
          final cameras = await availableCameras();
          final firstCamera = cameras.first;
          Navigator.push(context, MaterialPageRoute(builder: (context)=>camera_page(camera: firstCamera,)));
        },
      ),
    );
  }
  Future<void> _goToTheMyLocation() async {
    _getPosition();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(current_latitude,current_longitude),
              zoom: 15
            )
        )
    );
    print(current_latitude);
    print(current_longitude);
  }
}
