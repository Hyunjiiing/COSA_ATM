import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosa_atm/bottom_bar.dart';
import 'package:cosa_atm/pages/inventory_page.dart';
import 'package:cosa_atm/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_share/flutter_share.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class PetPage extends StatelessWidget {
  final List<Marker> marker;

  PetPage({required List<Marker> this.marker});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PetScreen(
        marker: this.marker,
      ),
    );
  }
}

class PetScreen extends StatefulWidget {
  final List<Marker> marker;

  PetScreen({required List<Marker> this.marker});

  @override
  State<PetScreen> createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('User');
    CollectionReference pet = FirebaseFirestore.instance.collection('Character');
    Future<DocumentSnapshot> userInfo = user.doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3').get();
    Future<dynamic> petInfo = pet.get();

    double screenHeight = MediaQuery.of(context).size.height;
    double containerStartingHeight = screenHeight * 0.3;
    double paddingTop = 10.0;

    return FutureBuilder<List<dynamic>>(
        future: Future.wait([userInfo, petInfo]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          int index = 0;
          String rank = "";
          List<dynamic> li = snapshot.data![0]["character"];

          for(int i = 0; i < li.length; i++) {
            if (snapshot.data![0]["select"] == li[i]["key"]){
              index = i;
              break;
            }
          }

          QuerySnapshot querySnapshot = snapshot.data![1];
          querySnapshot.docs.forEach((doc) {
            var data = doc.data()! as Map<String, dynamic>;
            if (data['name'] == snapshot.data![0]['select']) {
              rank = data['grade'];
              print("1");
            }
          });

          return Scaffold(
            body: Stack(
              children: [
                // Background image
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Top grey container
                Positioned(
                  top: screenHeight * 0.07,
                  left: MediaQuery.of(context).size.width * 0.3,
                  right: MediaQuery.of(context).size.width * 0.3,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(50, 50, 50, 0.67),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/dollar.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 7),
                          Text(
                            snapshot.data![0]["money"].toString(),
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                                fontFamily: 'Bit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: containerStartingHeight + 50,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: screenHeight - screenHeight * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(85),
                        topRight: Radius.circular(85),
                      ),
                    ),
                  ),
                ),
                // Bottom grey container
                Positioned(
                  top: screenHeight * 0.12,
                  left: MediaQuery.of(context).size.width * 0.3,
                  right: MediaQuery.of(context).size.width * 0.3,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(50, 50, 50, 0.67),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/level.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Level ' + li[index]["level"].toString(),
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                                fontFamily: 'Bit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: containerStartingHeight + 140, // 위젯의 위치 조정
                  left: 0,
                  right: 0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //BlocBuilder<PetBloc, PetState>(
                        //builder: (context, state) {
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: TextFormField(
                                    initialValue: li[index]["name"],
                                    onChanged: (newName) {
                                      //context
                                      //.read<PetBloc>()
                                      //.add(UpdateNameEvent(newName: newName));
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontFamily: 'Bit'), // 글씨 크기 변경
                                  ),
                                ),
                                Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Color(0xff626161),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              child: Text(
                                rank,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Bit'),
                              ),
                              onPressed: () {
                                // 동작을 추가해주세요
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffA5C8FD), // 버튼 색상을 변경합니다.
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 8),
                              ),
                            ),
                            SizedBox(height: 25),
                            Text(
                              'LEVEL ' + li[index]["level"].toString() + '/20',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Bit'),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(0.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10),
                                    buildLinearPercentIndicator(
                                        li[index]["exp"] / 100, Color(0xffFFCD4A), li[index]["exp"].toString() + "%"),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InventoryPage(
                                                  marker: widget.marker,
                                                )))
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 55,
                                        height: 55,
                                        child: Image.asset(
                                          "assets/images/inventory.png",
                                        ),
                                      ),
                                      Text(
                                        '인벤토리',
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: 'Bit'),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            actionsPadding: EdgeInsets.zero,
                                            contentPadding: EdgeInsets.zero,
                                            content: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  100 *
                                                  40,
                                              child: Column(
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          "일일 퀘스트",
                                                          style: TextStyle(
                                                            fontFamily: 'Bit',
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                      )),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            100 *
                                                            70,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            100 *
                                                            35,
                                                    child: ListView.builder(
                                                        itemCount: 4,
                                                        itemBuilder:
                                                            (BuildContext ctx,
                                                                int idx) {
                                                          return Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    bottom: 10),
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                100 *
                                                                6,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "${quest[idx]}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontFamily:
                                                                            'Bit'),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width /
                                                                                100 *
                                                                                15,
                                                                            height: MediaQuery.of(context).size.height /
                                                                                100 *
                                                                                4,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.black.withOpacity(0.5),
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  "${quest_reward[idx]}",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                                Image.asset(
                                                                                  'assets/images/dollar.png',
                                                                                  height: 20,
                                                                                  width: 20,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          MaterialButton(
                                                                              onPressed: () {
                                                                                switch (idx) {
                                                                                  case 0:
                                                                                    if (snapshot.data![0]['quest']['quest1'] >= 3) {
                                                                                      setState(() {
                                                                                        user
                                                                                            .doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3')
                                                                                            .update({'money': snapshot.data![0]['money'] + 100})
                                                                                            .then((value) => print("User Updated"))
                                                                                            .catchError((error) => print("Failed to update user: $error"));
                                                                                      });
                                                                                    }
                                                                                    break;
                                                                                  case 1:
                                                                                    if (snapshot.data![0]['quest']['quest2'] >= 3) {
                                                                                      setState(() {
                                                                                        user
                                                                                            .doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3')
                                                                                            .update({'money': snapshot.data![0]['money'] + 100})
                                                                                            .then((value) => print("User Updated"))
                                                                                            .catchError((error) => print("Failed to update user: $error"));
                                                                                      });
                                                                                    }
                                                                                    break;
                                                                                  case 2:
                                                                                    if (snapshot.data![0]['quest']['quest3'] >= 1) {
                                                                                      setState(() {
                                                                                        user
                                                                                            .doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3')
                                                                                            .update({'money': snapshot.data![0]['money'] + 100})
                                                                                            .then((value) => print("User Updated"))
                                                                                            .catchError((error) => print("Failed to update user: $error"));
                                                                                      });
                                                                                    }
                                                                                    break;
                                                                                  case 3:
                                                                                    if (snapshot.data![0]['quest']['quest1'] >= 3 && snapshot.data![0]['quest']['quest2'] >= 3 && snapshot.data![0]['quest']['quest3'] >= 1) {
                                                                                      //경험치 Up
                                                                                      setState(() {
                                                                                        user
                                                                                            .doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3')
                                                                                            .update({'money': snapshot.data![0]['money'] + 200})
                                                                                            .then((value) => print("User Updated"))
                                                                                            .catchError((error) => print("Failed to update user: $error"));
                                                                                      });
                                                                                    }
                                                                                    break;
                                                                                }
                                                                              },
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width / 100 * 15,
                                                                                height: MediaQuery.of(context).size.height / 100 * 4,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFFFFCD4A),
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "받기",
                                                                                  style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Bit'),
                                                                                )),
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
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }, // 여기에 공유 기능
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 55,
                                        height: 55,
                                        child: Image.asset(
                                            "assets/images/quest.png"
                                        ),
                                      ),
                                      Text(
                                        '일일 퀘스트',
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: 'Bit'
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    sharePet(context);
                                  }, // 여기에 공유 기능
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 55,
                                        height: 55,
                                        child: Image.asset(
                                          "assets/images/insta.png",
                                        ),
                                      ),
                                      Text(
                                        '공유하기',
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: 'Bit'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ]),
                ),
              Positioned(
                top: containerStartingHeight / 2 + 50,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/character1.png',
                  height: 200,
                  width: 200,
                ),
              ),]
            ),
            bottomNavigationBar: BottomBar(marker: widget.marker),
          );
        });
  }

  Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _writeImageFile(String imagePath) async {
    final imageName = 'character1.png';
    final path = await _localPath();
    print(path);
    final imageFilePath = '$path/$imageName';
    final File file = File(imageFilePath);

    final data = await rootBundle.load('assets/images/character1.png');
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return file.writeAsBytes(bytes);
  }

  Future<void> sharePet(BuildContext context) async {
    //final dogName = context.read<PetBloc>().state.pet.name;
    final imagePath = 'assets/images/character1.png';

    try {
      final imageFile = await _writeImageFile(imagePath);
      await FlutterShare.shareFile(
        title: 'Pet Sharing',
        //text: 'Check out my awesome pet, $dogName!',
        filePath: imageFile.path,
        chooserTitle: 'Sharing with',
      );
    } catch (e) {
      print('Error while sharing: $e');
    }
  }

  LinearPercentIndicator buildLinearPercentIndicator(
      double percent, Color color, String label) {
    return LinearPercentIndicator(
      lineHeight: 30.0,
      percent: percent,
      backgroundColor: Colors.grey[300],
      progressColor: color,
      center: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      barRadius: const Radius.circular(16),
      // 막대 끝을 둥글게 설정
      animation: true,
      animationDuration: 1000,
    );
  }
}
