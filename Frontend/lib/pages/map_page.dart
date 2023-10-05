import 'dart:async';
import 'dart:typed_data';
import 'package:circular_menu/circular_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosa_atm/bottom_bar.dart';
import 'package:cosa_atm/pages/camera_page.dart';
import 'package:cosa_atm/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui' as ui;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:camera/camera.dart';

List<String> quest =[
  "맨홀찍기 3회",
  "검토하기 3회",
  "공유하기 1회",
  "모든 퀘스트 성공",
];

List<String> quest_reward =[
  "100",
  "100",
  "100",
  "200",
];

List<String> quest_clear =[
  "3",
  "3",
  "1",
  "3",
];

List<String> quest_name =[
  "quest1",
  "quest2",
  "quest3",
  "quest4",
];

List<String> lanking_name =[
  "leedongyull",
  "mondayy1",
  "KangJiUng",
  "Hyunjiiing",
  "kjh3291",
];

List<String> lanking_Score =[
  "32",
  "26",
  "20",
  "17",
  "3",
];



Map<dynamic,String> mainCharacter = {
  "character1":"assets/images/character1.png",
  "character2":"assets/images/character2.png",
  "character3":"assets/images/character3.png",
  "character4":"assets/images/character4.png",
  "character5":"assets/images/character5.png",
  "character6":"assets/images/character6.png",
  "character7":"assets/images/character7.png",
};

Map<String,dynamic> quest_current={};

List<dynamic>? user_mainCharacter;
String user_name="";
int user_money=0;

bool isPopupOpen = false;

class map_page extends StatefulWidget {
  const map_page({
    required this.marker,
  });

  final List<Marker> marker;
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

void getUserInfo() async {
  final documentSnapshot = await FirebaseFirestore.instance
      .collection("User")
      .doc("YlKcdF67V6WGeFUmNhcQFuv5NrE3")
      .get();

  user_money=documentSnapshot.get("money");
  user_name=documentSnapshot.get("name");
  user_mainCharacter=documentSnapshot.data()?["character"];


  if (documentSnapshot.exists) {
    quest_current = documentSnapshot.data()?["quest"];
  } else {
    // 문서가 존재하지 않는 예외처리
  }
}



class _map_pageState extends State<map_page> {
  Completer<GoogleMapController> _controller = Completer();
  CollectionReference user = FirebaseFirestore.instance.collection('User');


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserInfo();
      _getPosition();
      if (!isPopupOpen) {
        _showPopup();
      }
    });
  }

  void _closePopup() {
    setState(() {
      isPopupOpen = false;
    });
  }

  void _showPopup() {
    setState(() {
      isPopupOpen = true;
    });
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            actions: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/100*40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height/100*5,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Center(child: Text("개선상황",style: TextStyle(fontFamily: 'Bit',fontSize: 25),))
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height/100*20,
                            child: Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/100*30,
                                    height: MediaQuery.of(context).size.height/100*15,
                                    child: Image.asset("assets/images/before.jpg",fit: BoxFit.cover,)
                                ),
                                Text("Before",style: TextStyle(fontFamily: 'Bit',fontSize: 25,color: Colors.red),),
                              ],
                            )
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height/100*20,
                            child: Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/100*30,
                                    height: MediaQuery.of(context).size.height/100*15,
                                    child: Image.asset("assets/images/after.jpg",fit: BoxFit.cover,)
                                ),
                                Text("After",style: TextStyle(fontFamily: 'Bit',fontSize: 25,color: Colors.green),)
                              ],
                            )
                        ),
                      ],
                    ),
                    Text("2023-09-22",style: TextStyle(fontFamily: 'Bit',fontSize: 20,color: Colors.black),),
                    Container(
                      height: MediaQuery.of(context).size.height/100*6,
                      width: MediaQuery.of(context).size.width*0.3,
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Center(child: Text("확인",style: TextStyle(fontFamily: "Bit",fontSize: 20),)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
    );
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
                      margin: EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/100*70,
                      child: Column(
                        children: [
                          Align(alignment: Alignment.topCenter,child: Text("Rankings",style: TextStyle(fontFamily: "Bit",fontSize: 40),),),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/100*1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                padding: EdgeInsets.zero,
                                minWidth: MediaQuery.of(context).size.width/100*20,
                                onPressed: (){
                                  setState(() {
                                    lankingTab=0;
                                  });
                                },
                                child: Container(
                                  width:MediaQuery.of(context).size.width/100*20,
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
                                minWidth: MediaQuery.of(context).size.width/100*20,
                                onPressed: (){
                                  setState(() {
                                    lankingTab=1;
                                  });
                                },
                                child: Container(
                                  width:MediaQuery.of(context).size.width/100*20,
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
                                  width: MediaQuery.of(context).size.width/100*65,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("순위",style: TextStyle(color: Colors.grey,fontSize: 16),),
                                      Text("닉네임",style: TextStyle(color: Colors.grey,fontSize: 16),),
                                      Text("점수  ",style: TextStyle(color: Colors.grey,fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width/100*68,
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
                                                    children: [
                                                      Container(
                                                        margin:EdgeInsets.only(left: 20,right: 10),
                                                          width: MediaQuery.of(context).size.width/100*5,
                                                          child: Text("${index+1}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20))
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width/100*10,
                                                        height: MediaQuery.of(context).size.height/100*5,
                                                        child: Image.asset("${mainCharacter["character${index+1}"]}",fit: BoxFit.cover,),
                                                      ),
                                                      SizedBox(width: MediaQuery.of(context).size.width/100*2,),
                                                      SizedBox(width: MediaQuery.of(context).size.width/100*20,child: Center(child: Text("${lanking_name[index]}"))),
                                                      SizedBox(width: MediaQuery.of(context).size.width/100*14,),
                                                      SizedBox(width: MediaQuery.of(context).size.width/100*5,child: Center(child: Text("${lanking_Score[index]}")))
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
                                                    children: [
                                                      Container(
                                                          margin:EdgeInsets.only(left: 20,right: 10),
                                                          width: MediaQuery.of(context).size.width/100*5,
                                                          child: Text("${index+1}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20))
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width/100*10,
                                                        height: MediaQuery.of(context).size.height/100*5,
                                                        child: Image.asset("${mainCharacter["character${index+1}"]}",fit: BoxFit.cover,),
                                                      ),
                                                      SizedBox(width: MediaQuery.of(context).size.width/100*2,),
                                                      SizedBox(width: MediaQuery.of(context).size.width/100*20,child: Center(child: Text("${lanking_name[index]}"))),
                                                      SizedBox(width: MediaQuery.of(context).size.width/100*14,),
                                                      SizedBox(width: MediaQuery.of(context).size.width/100*5,child: Center(child: Text("${lanking_Score[index]}")))
                                                    ],
                                                  ),
                                                );
                                              }
                                          ),
                                        ),
                                        Icon(Icons.more_vert,size: 70,color: Colors.grey[300],),
                                        Container(
                                          width: MediaQuery.of(context).size.width/100*68,
                                          height: MediaQuery.of(context).size.height/100*6,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey[300]
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin:EdgeInsets.only(left: 20,right: 10),
                                                  width: MediaQuery.of(context).size.width/100*5,
                                                  child: Text("1",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20))
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width/100*10,
                                                height: MediaQuery.of(context).size.height/100*5,
                                                child: Image.asset("${mainCharacter["character1"]}",fit: BoxFit.cover,),
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width/100*2,),
                                              SizedBox(width: MediaQuery.of(context).size.width/100*20,child: Center(child: Text("${lanking_name[0]}"))),
                                              SizedBox(width: MediaQuery.of(context).size.width/100*14,),
                                              Text("${lanking_Score[0]}")
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )
                              :
                          Container(
                            width: MediaQuery.of(context).size.width/100*70,
                            height: MediaQuery.of(context).size.height/100*50,
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/images/namhan.jpg",
                                  width: MediaQuery.of(context).size.width/100*70,
                                  height: MediaQuery.of(context).size.height/100*50,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: MediaQuery.of(context).size.height/100*10,
                                    left: MediaQuery.of(context).size.width/100*20,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("경기도",style: TextStyle(fontSize: 20,fontFamily: 'Bit'),),
                                        Text("204",style: TextStyle(fontSize: 15,fontFamily: 'Bit'),)
                                      ],
                                    )
                                ),
                                Positioned(
                                    top: MediaQuery.of(context).size.height/100*8,
                                    right: MediaQuery.of(context).size.width/100*22,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("강원도",style: TextStyle(fontSize: 20,fontFamily: 'Bit'),),
                                        Text("108",style: TextStyle(fontSize: 15,fontFamily: 'Bit'),)
                                      ],
                                    )
                                ),
                                Positioned(
                                    top: MediaQuery.of(context).size.height/100*20,
                                    left: MediaQuery.of(context).size.width/100*14,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("충청남도",style: TextStyle(fontSize: 20,fontFamily: 'Bit'),),
                                        Text("129",style: TextStyle(fontSize: 15,fontFamily: 'Bit'),),
                                      ],
                                    )
                                ),
                                Positioned(
                                    top: MediaQuery.of(context).size.height/100*17,
                                    left: MediaQuery.of(context).size.width/100*28,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("충청북도",style: TextStyle(fontSize: 20,fontFamily: 'Bit'),),
                                        Text("193",style: TextStyle(fontSize: 15,fontFamily: 'Bit'),),
                                      ],
                                    )
                                ),
                                Positioned(
                                    top: MediaQuery.of(context).size.height/100*21,
                                    right: MediaQuery.of(context).size.width/100*13,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("경상북도",style: TextStyle(fontSize: 20,fontFamily: 'Bit'),),
                                        Text("167",style: TextStyle(fontSize: 15,fontFamily: 'Bit'),),
                                      ],
                                    )
                                ),
                                Positioned(
                                    top: MediaQuery.of(context).size.height/100*26.5,
                                    right: MediaQuery.of(context).size.width/100*10,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/crown.png",
                                          width:MediaQuery.of(context).size.height/100*16,
                                          height: MediaQuery.of(context).size.width/100*8,
                                        ),
                                        Text("경상남도",style: TextStyle(fontSize: 20,fontFamily: 'Bit'),),
                                        Text("208",style: TextStyle(color: Colors.red,fontSize: 20,fontFamily: 'Bit'),),
                                      ],
                                    )
                                ),
                                Positioned(
                                    top: MediaQuery.of(context).size.height/100*27,
                                    left: MediaQuery.of(context).size.width/100*19,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("전라북도",style: TextStyle(fontSize: 20,fontFamily: 'Bit'),),
                                        Text("98",style: TextStyle(fontSize: 15,fontFamily: 'Bit'),),
                                      ],
                                    )
                                ),
                                Positioned(
                                    top: MediaQuery.of(context).size.height/100*33.5,
                                    left: MediaQuery.of(context).size.width/100*15,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("전라남도",style: TextStyle(fontSize: 20,fontFamily: 'Bit'),),
                                        Text("142",style: TextStyle(fontSize: 15,fontFamily: 'Bit'),),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/100*6,
                            width: MediaQuery.of(context).size.width*0.3,
                            child: MaterialButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Center(child: Text("확인",style: TextStyle(fontFamily: "Bit",fontSize: 20),)),
                            ),
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
            getUserInfo();
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
                      height: MediaQuery.of(context).size.height/100*60,
                      child: Column(
                        children: [
                          Container(margin: EdgeInsets.only(top: 10),child: Align(alignment: Alignment.topCenter,child: Text("일일 퀘스트",style: TextStyle(fontFamily: 'Bit',fontSize: 25,),),)),
                          Container(
                            width: MediaQuery.of(context).size.width/100*70,
                            height: MediaQuery.of(context).size.height/100*55,
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/100*70,
                                  height: MediaQuery.of(context).size.height/100*50,
                                  child: ListView.builder(
                                      itemCount: 4,
                                      itemBuilder: (BuildContext ctx, int idx) {
                                        return Container(
                                          margin: EdgeInsets.only(top: 10,bottom: 10),
                                          height: MediaQuery.of(context).size.height/100*10,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15.0,right: 15),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text("${quest[idx]}",style: TextStyle(fontSize: 20,fontFamily: 'Bit'),),
                                                      Text("${quest_current[quest_name[idx]]}/${quest_clear[idx]}",style: TextStyle(fontSize: 20,fontFamily: 'Bit'),)
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width/100*20,
                                                        height: MediaQuery.of(context).size.height/100*3.5,
                                                        decoration: BoxDecoration(
                                                          color: Colors.black.withOpacity(0.5),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text("${quest_reward[idx]}",style: TextStyle(color: Colors.white),),
                                                            Image.asset("assets/images/dollar.png"),
                                                          ],
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                          onPressed: (){
                                                            switch (idx) {
                                                              case 0:
                                                                if(quest_current["quest${idx+1}_clear"]==false){
                                                                  if (quest_current["quest${idx+1}"].toString() == 3.toString()) {
                                                                    setState(() {
                                                                      user
                                                                          .doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3')
                                                                          .update({
                                                                            'money': user_money + 100,
                                                                            "quest.quest${idx+1}_clear" : true,
                                                                            "quest.quest4" : quest_current["quest4"]+1,
                                                                          })
                                                                          .then((value) => print("User Updated"))
                                                                          .catchError((error) => print("Failed to update user: $error"));
                                                                      getUserInfo();
                                                                    });
                                                                  }
                                                                }
                                                                break;
                                                              case 1:
                                                                if(quest_current["quest${idx+1}_clear"]==false){
                                                                  if (quest_current["quest${idx+1}"].toString() == 3.toString()) {
                                                                    setState(() {
                                                                      user
                                                                          .doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3')
                                                                          .update({
                                                                        'money': user_money + 100,
                                                                        "quest.quest${idx+1}_clear" : true,
                                                                        "quest.quest4" : quest_current["quest4"]+1,
                                                                      })
                                                                          .then((value) => print("User Updated"))
                                                                          .catchError((error) => print("Failed to update user: $error"));
                                                                      getUserInfo();
                                                                    });
                                                                  }
                                                                }
                                                                break;
                                                              case 2:
                                                                if(quest_current["quest${idx+1}_clear"]==false){
                                                                  if (quest_current["quest${idx+1}"].toString() == 3.toString()) {
                                                                    setState(() {
                                                                      user
                                                                          .doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3')
                                                                          .update({
                                                                        'money': user_money + 100,
                                                                        "quest.quest${idx+1}_clear" : true,
                                                                        "quest.quest4" : quest_current["quest4"]+1,
                                                                      })
                                                                          .then((value) => print("User Updated"))
                                                                          .catchError((error) => print("Failed to update user: $error"));
                                                                      getUserInfo();
                                                                    });
                                                                  }
                                                                }
                                                                break;
                                                              case 3:
                                                                if(quest_current["quest${idx+1}_clear"]==false){
                                                                  if (quest_current["quest${idx+1}"].toString() == 3.toString()) {
                                                                    setState(() {
                                                                      user
                                                                          .doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3')
                                                                          .update({
                                                                        'money': user_money + 200,
                                                                        "quest.quest${idx+1}_clear" : true,
                                                                      })
                                                                          .then((value) => print("User Updated"))
                                                                          .catchError((error) => print("Failed to update user: $error"));
                                                                      getUserInfo();
                                                                    });
                                                                  }
                                                                }
                                                                break;
                                                            }
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width/100*30,
                                                            height: MediaQuery.of(context).size.height/100*3.5,
                                                            decoration: BoxDecoration(
                                                              color:
                                                              quest_current[quest_name[idx]].toString() == quest_clear[idx].toString() ?
                                                                quest_current["quest${idx+1}_clear"]==true?
                                                                  Color(0xff81C147)
                                                                        :
                                                                  Color(0xffFFB156)
                                                                        :
                                                                Colors.grey,
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            child: quest_current[quest_name[idx]].toString() == quest_clear[idx].toString() ?
                                                              quest_current["quest${idx+1}_clear"]==true?
                                                              Center(child: Text("완료",style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Bit'),))
                                                                                                    :
                                                              Center(child: Text("보상 받기",style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Bit'),))
                                                                                                    :
                                                              Center(child: Text("진행중",style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Bit'),)),
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height/100*5,
                                  width: MediaQuery.of(context).size.width*0.3,
                                  child: MaterialButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Center(child: Text("확인",style: TextStyle(fontFamily: "Bit",fontSize: 20),)),
                                  ),
                                )
                              ],
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
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
              markers: Set.from(widget.marker),
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
                            SizedBox(
                              height: MediaQuery.of(context).size.height/100*1.4,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/100*15,
                              height: MediaQuery.of(context).size.height/100*2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(child: Text("${user_name}",style: TextStyle(fontSize: 10,fontFamily: 'Bit'),)),
                            )
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/100*16,
                          height: MediaQuery.of(context).size.height/100*10,
                          child: Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width/100*13.4,
                                  height: MediaQuery.of(context).size.height/100*6.7,
                                  child: Image.asset("${mainCharacter[user_mainCharacter?[0]["key"]]}",fit: BoxFit.cover,)
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height/100*0.5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/100*15,
                                height: MediaQuery.of(context).size.height/100*2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(child: Text("${user_mainCharacter?[0]["name"]}",style: TextStyle(fontSize: 10,fontFamily: 'Bit'),)),
                              )
                            ],
                          ),
                        ),
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
                                    Image.asset("assets/images/dollar.png"),
                                    Container(
                                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/100*4),
                                        child: Text("${user_money}",style: TextStyle(color: Colors.white),)
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
                                          child: Text("LV.${user_mainCharacter?[0]["level"]}",style: TextStyle(color: Colors.white),)
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
                          width: MediaQuery.of(context).size.width/100*35,
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
        bottomNavigationBar: MapBottomBar(marker: widget.marker,),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MaterialButton(
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFCD4A)
            ),
            child: Icon(Icons.camera_alt,color: Colors.black,),
          ),
          onPressed: () async {
            _getPosition();
            final cameras = await availableCameras();
            final firstCamera = cameras.first;
            Navigator.push(context, MaterialPageRoute(builder: (context)=>camera_page(camera: firstCamera,marker: widget.marker,)));
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
              zoom: 20
            )
        )
    );
  }
}
