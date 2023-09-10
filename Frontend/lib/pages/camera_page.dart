import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosa_atm/bottom_bar.dart';
import 'package:cosa_atm/pages/map_page.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// A screen that allows users to take a picture using a given camera.
class camera_page extends StatefulWidget {
  const camera_page({
    super.key,
    required this.camera,
    required this.marker,
  });

  final CameraDescription camera;
  final List<Marker> marker;

  @override
  State<camera_page> createState() => _camera_pageState();
}

class _camera_pageState extends State<camera_page> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(flex:1, child: CameraPreview(_controller)),
                  ],
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width/100*85,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(color: Color(0xFFFFCD4A),width: 3)
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height/100*20,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5)
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/100*8),
                      child: Text("원의 크기에 맞춰서\n맨홀을 촬영해 주세요",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 25),textAlign: TextAlign.center,)
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        setState(() {
                          currentTap=0;
                        });
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close,color: Colors.white,),
                    ),
                  ),
                )
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.large(
          onPressed: () async {
            _controller.takePicture().then((image) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    imagePath: image.path,
                    markers: widget.marker,
                  ),
                ),
              );
            });
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                ),
              ),
              Center(
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black,width: 3)
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
/*class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width/100*90,
              height: MediaQuery.of(context).size.height/100*70,
              child: Image.file(File(imagePath),fit: BoxFit.contain,)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                child: Container(
                  width: MediaQuery.of(context).size.width/100*40,
                  height: MediaQuery.of(context).size.height/100*8,
                  child: Center(child: Text("다시 찍기")),
                  decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                onPressed: () async {
                  final cameras = await availableCameras();
                  final firstCamera = cameras.first;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => camera_page(
                        camera: firstCamera,
                      ),
                    ),
                  );
                },
              ),
              MaterialButton(
                child: Container(
                  width: MediaQuery.of(context).size.width/100*40,
                  height: MediaQuery.of(context).size.height/100*8,
                  child: Center(child: Text("확인")),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                onPressed: (){
                  add_marker("사진 이름");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => map_page(),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}*/

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final List<Marker> markers;

  const DisplayPictureScreen({
    super.key,
    required this.imagePath,
    required this.markers,
  });

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('User');

    Future<void> add_marker(String a,String imagePath)async {
      widget.markers.add(
          Marker(
              markerId: MarkerId(a),
              draggable: true,
              position: LatLng(current_latitude,current_longitude),
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
                          width: MediaQuery.of(context).size.width*0.7,
                          height: MediaQuery.of(context).size.height*0.35,
                          child: Column(
                            children: [
                              Text("맨홀 사진",style: TextStyle(fontSize: 25,fontFamily: 'Bit',),),
                              Container(
                                  width: MediaQuery.of(context).size.width*0.56,
                                  height: MediaQuery.of(context).size.height*0.28,
                                  child: Image.file(File(widget.imagePath),fit: BoxFit.fill,)
                              ),
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

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/100*10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/100*90,
            child: Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/100*100,
                    height: MediaQuery.of(context).size.height/100*90,
                    child: Image.file(File(widget.imagePath),fit: BoxFit.cover,)
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height/100*10,
                    color: Colors.black.withOpacity(0.7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          child: Container(
                            width: MediaQuery.of(context).size.width/100*40,
                           height: MediaQuery.of(context).size.height/100*8,
                           child: Center(child: Text("다시 시도",style: TextStyle(fontFamily: 'Bit',color: Colors.white,fontSize: 20),)),
                         ),
                         onPressed: () async {
                           final cameras = await availableCameras();
                            final firstCamera = cameras.first;
                            Navigator.of(context).push(
                             MaterialPageRoute(
                               builder: (context) => camera_page(
                                 camera: firstCamera,
                                 marker: widget.markers,
                               ),
                             ),
                            );
                         },
                        ),
                        MaterialButton(
                         child: Container(
                           width: MediaQuery.of(context).size.width/100*40,
                           height: MediaQuery.of(context).size.height/100*8,
                            child: Center(child: Center(child: Text("확인",style: TextStyle(fontFamily: 'Bit',color: Colors.white,fontSize: 20),)),),
                          ),
                          onPressed: () async {
                            setState(() {
                              currentTap=0;
                            });
                            add_marker("사진 이름",widget.imagePath);

                            DocumentSnapshot userInfo = await user.doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3').get();
                            Map<String, dynamic> data = userInfo.data()! as Map<String, dynamic>;
                            List<dynamic> li = data["character"];
                            for (int i = 0; i < li.length; i++) {
                              if (li[i]["key"] == data["select"]) {
                                li[i]["exp"] += 10;
                                // 여기서 어떻게 레벨 올릴지도 고민
                              }
                            }

                            bool isToday(Timestamp timestamp) {
                              DateTime date = timestamp.toDate();
                              DateTime now = DateTime.now();

                              return date.year == now.year && date.month == now.month && date.day == now.day;
                            }

                            Map<String, dynamic> quest = data["quest"] as Map<String, dynamic>;
                            if (isToday(quest["date"])) {
                              quest['quest1'] = quest['quest2'] = quest['quest3'] = 0;
                            }
                            quest['quest2'] += 1;

                            user
                                .doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3')
                                .update({'character': li, 'count': data["count"] + 1, 'quest': quest})
                                .then((value) => print("User Updated"))
                                .catchError((error) => print("Failed to update user: $error"));

                           Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => map_page(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// A widget that displays the picture taken by the user.