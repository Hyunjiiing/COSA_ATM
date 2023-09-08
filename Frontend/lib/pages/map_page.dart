import 'dart:async';
import 'dart:typed_data';

import 'package:circular_menu/circular_menu.dart';
import 'package:cosa_atm/bottom_bar.dart';
import 'package:cosa_atm/pages/camera_page.dart';
import 'package:cosa_atm/testPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui' as ui;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:camera/camera.dart';

List<String> quest =[
  "검토하기 3회",
  "맨홀찍기 3회",
  "공유하기 1회",
  "모든 퀘스트 성공",
];

List<String> quest_reward =[
  "100",
  "100",
  "100",
  "200",
];


List<Marker> _markers = [];

class map_page extends StatefulWidget {
  const map_page({Key? key}) : super(key: key);

  @override
  State<map_page> createState() => _map_pageState();
}


double current_latitude =0;
double current_longitude =0;

int lankingTab=0;
late Uint8List markerIcon;


Future<void> _getPosition() async{
  LocationPermission permission = await Geolocator.requestPermission(); //오류 해결 코드
  Position position = await Geolocator.
  getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  current_latitude = position.latitude;
  current_longitude = position.longitude;
}

void setCustomMapPin() async {
  markerIcon = await getBytesFromAsset('assets/images/manhole_pin.png', 130);
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
    _getPosition();
  }

  @override
  Widget build(BuildContext context) {

    final circularMenu = CircularMenu(
      alignment: Alignment.bottomLeft,
      toggleButtonColor: Colors.white,
      toggleButtonIconColor: Colors.black,
      toggleButtonBoxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.7),
          blurRadius: 5.0,
          spreadRadius: 0.0,
          offset: const Offset(0,7),
        )
      ],
      items: [
        CircularMenuItem(
          onTap: (){
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
                          Row(
                            children: [
                              SizedBox(width: MediaQuery.of(context).size.width/100*7,),
                              MaterialButton(
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  setState(() {
                                    lankingTab=0;
                                  });
                                },
                                child: Container(
                                  width:MediaQuery.of(context).size.width/100*15,
                                  height: MediaQuery.of(context).size.height/100*4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffFFB156),
                                  ),
                                  child: Center(
                                    child: Text("유저별",style: TextStyle(fontSize: 20,fontFamily: 'Bit',color: Colors.white),),
                                  ),
                                ),
                              ),
                              MaterialButton(
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  setState(() {
                                    lankingTab=1;
                                  });
                                },
                                child: Container(
                                  width:MediaQuery.of(context).size.width/100*15,
                                  height: MediaQuery.of(context).size.height/100*4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffFFB156),
                                  ),
                                  child: Center(
                                    child: Text("지역별",style: TextStyle(fontSize: 20,fontFamily: 'Bit',color: Colors.white),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          lankingTab==0 ?
                          Container(
                            child: Column(
                              children: [
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
                          )
                              :
                          Container(
                            width: MediaQuery.of(context).size.width/100*60,
                            height: MediaQuery.of(context).size.height/100*30,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          },
          icon: Icons.leaderboard,
          iconColor: Color(0xffFFB156),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: const Offset(0,7),
            )
          ],
        ),
        CircularMenuItem(
          onTap: (){
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
                      height: MediaQuery.of(context).size.height/100*40,
                      child: Column(
                        children: [
                          Container(margin: EdgeInsets.only(top: 5,bottom: 5),child: Align(alignment: Alignment.topCenter,child: Text("일일 퀘스트",style: TextStyle(fontFamily: 'Bit',fontSize: 25,),),)),
                          Container(
                            width: MediaQuery.of(context).size.width/100*70,
                            height: MediaQuery.of(context).size.height/100*35,
                            child: ListView.builder(
                              itemCount: 4,
                              itemBuilder: (BuildContext ctx, int idx) {
                                return Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  height: MediaQuery.of(context).size.height/100*6,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${quest[idx]}",style: TextStyle(fontSize: 17,fontFamily: 'Bit'),),
                                        Container(
                                          child:Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width/100*15,
                                                  height: MediaQuery.of(context).size.height/100*4,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(0.5),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("${quest_reward[idx]}",style: TextStyle(color: Colors.white),),
                                                      Icon(Icons.currency_bitcoin,color: Colors.yellow,),
                                                    ],
                                                  ),
                                                ),
                                                MaterialButton(
                                                  onPressed: (){},
                                                  child: Container(
                                                      width: MediaQuery.of(context).size.width/100*15,
                                                      height: MediaQuery.of(context).size.height/100*4,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffFFB156),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Center(child: Text("받기",style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Bit'),)),
                                                  )
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          },
          icon: FontAwesomeIcons.scroll,
          iconColor: Color(0xffFFB156),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: const Offset(0,7),
            )
          ],
        ),
        CircularMenuItem(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>testPage()));
          },
          icon: Icons.flaky,
          iconColor: Color(0xffFFB156),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: const Offset(0,7),
            )
          ],
        ),
      ],
      radius: 100,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                  margin: EdgeInsets.only(bottom: 10),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  child: Icon(Icons.my_location,color: Colors.black,),
                ),
                onPressed:(){_goToTheMyLocation();},
              ),
            ),
            circularMenu
          ],
        ),
        bottomNavigationBar: MapBottomBar(marker: _markers,),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>camera_page(camera: firstCamera,marker: _markers,)));
          },
        ),
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
