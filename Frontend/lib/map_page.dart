import 'dart:async';
import 'dart:typed_data';

import 'package:cosa_atm/bottom_bar.dart';
import 'package:cosa_atm/camera_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
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
late Uint8List markerIcon;

List<Marker> _markers = [
  Marker(markerId: MarkerId("맨홀1"),draggable: true,position: LatLng(36.6305, 127.4578),infoWindow: InfoWindow(title: "1234"),icon: BitmapDescriptor.fromBytes(markerIcon)),
  Marker(markerId: MarkerId("전봇대1"),draggable: true,position: LatLng(36.6299, 127.4590),infoWindow: InfoWindow(title: "5678"),icon: BitmapDescriptor.fromBytes(markerIcon))

];

Future<void> add_marker(String a)async {
  _markers.add(Marker(markerId: MarkerId(a),draggable: true,position: LatLng(current_latitude,current_longitude),infoWindow: InfoWindow(title: a),icon: BitmapDescriptor.fromBytes(markerIcon)));
}

Future<void> _getPosition() async{
  LocationPermission permission = await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  current_latitude = position.latitude;
  current_longitude = position.longitude;
}

void setCustomMapPin() async {
  markerIcon = await getBytesFromAsset('images/pin.png', 130);
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

class _map_pageState extends State<map_page> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    setCustomMapPin();
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
                target: LatLng(current_latitude,current_longitude),
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
                margin: EdgeInsets.only(bottom: 60,right: 10),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(child: Image.asset("images/crown.png",width: 40,))
              ),
              onPressed: (){
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        actionsPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.zero,
                        content: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/100*70,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey
                                    ),
                                    child: Icon(Icons.close),
                                  ),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  }
                                ),
                              ),
                              Align(alignment: Alignment.topCenter,child: Text("Rankings",style: TextStyle(fontSize: 40),),),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("순위",style: TextStyle(color: Colors.grey,fontSize: 16),),
                                    Text("닉네임",style: TextStyle(color: Colors.grey,fontSize: 16),),
                                    Text("점수",style: TextStyle(color: Colors.grey,fontSize: 16),),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width/100*60,
                                      height: MediaQuery.of(context).size.height/100*30,
                                      child: ListView.builder(
                                          itemCount: 5,
                                          itemBuilder: (BuildContext context,int index){
                                            return index%2==0 ?
                                            Container(
                                              height: MediaQuery.of(context).size.height/100*6,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.grey[300]
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text("${index+1}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20)),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.cruelty_free),
                                                      Text("닉네임"),
                                                    ],
                                                  ),
                                                  Text("점수")
                                                ],
                                              ),
                                            )
                                                :
                                            Container(
                                              height: MediaQuery.of(context).size.height/100*6,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text("${index+1}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20)),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.cruelty_free),
                                                      Text("닉네임"),
                                                    ],
                                                  ),
                                                  Text("점수")
                                                ],
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                    Icon(Icons.more_vert,size: 100,color: Colors.grey[300],),
                                    Container(
                                      width: MediaQuery.of(context).size.width/100*60,
                                      height: MediaQuery.of(context).size.height/100*6,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey[300]
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text("75",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                          Row(
                                            children: [
                                              Icon(Icons.cruelty_free),
                                              Text("닉네임"),
                                            ],
                                          ),
                                          Text("점수")
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              )
                            ],
                          ),
                        ),
                      );
                    }
                );
              },
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
          ),
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
          _getPosition();
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
