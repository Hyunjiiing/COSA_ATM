import 'package:cosa_atm/pages/camera_page.dart';
import 'package:cosa_atm/pages/map_page.dart';
import 'package:cosa_atm/pages/pet_page.dart';
import 'package:cosa_atm/pages/setting_page.dart';
import 'package:cosa_atm/pages/store_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapBottomBar extends StatefulWidget {
  const MapBottomBar({Key? key}) : super(key: key);

  @override
  State<MapBottomBar> createState() => _MapBottomBarState();
}

int currentTap = 0;

Future<void> _getPosition() async {
  LocationPermission permission = await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  current_latitude = position.latitude;
  current_longitude = position.longitude;
}

class _MapBottomBarState extends State<MapBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 60,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentTap = 0;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => map_page()));
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentTap == 0
                                  ? Colors.yellow
                                  : Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:30,
                                  height: 30,
                                  child: Image.asset(
                                    "images/map.png",
                                    color: currentTap==0 ? Colors.black : Colors.grey,
                                  ),
                                ),
                                Text(
                                  '지도',
                                  style: TextStyle(color: currentTap==0 ? Colors.black : Colors.grey,
                                    fontFamily: 'Bit',
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ), //홈
                    MaterialButton(
                      minWidth: 40,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          currentTap = 1;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PetPage()));
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: currentTap == 1
                              ? Colors.yellow
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                "images/petprint.png",
                                color: currentTap==1 ? Colors.black : Colors.grey,
                              ),
                            ),
                            Text(
                              '펫',
                              style: TextStyle(color: currentTap==1 ? Colors.black : Colors.grey,
                                  fontFamily: 'Bit'
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          currentTap = 2;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StorePage()));
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: currentTap == 2
                              ? Colors.yellow
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: currentTap==3 ? Colors.black : Colors.grey,
                            ),
                            Text(
                              '상점',
                              style: TextStyle(color: currentTap==3 ? Colors.black : Colors.grey,
                                fontFamily: 'Bit',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), //유저
                    MaterialButton(
                      minWidth: 40,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          currentTap = 3;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingPage()));
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentTap == 3
                                  ? Colors.yellow
                                  : Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.perm_identity,
                                  color: currentTap==4 ? Colors.black : Colors.grey,
                                ),
                                Text(
                                  '내 정보',
                                  style: TextStyle(color: currentTap==4 ? Colors.black : Colors.grey,
                                    fontFamily: 'Bit',
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 60,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 40,
                      onPressed: (){
                        setState((){
                          currentTap=0;
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>map_page())
                              );
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentTap==0 ?  Color(0xFFFFCD4A) : Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:30,
                                  height: 30,
                                  child: Image.asset(
                                    "images/map.png",
                                    color: currentTap==0 ? Colors.black : Colors.grey,
                                  ),
                                ),
                                Text(
                                  '지도',
                                  style: TextStyle(color: currentTap==0 ? Colors.black : Colors.grey,
                                    fontFamily: 'Bit',
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ), //홈
                    SizedBox(width: 38),
                    MaterialButton(
                      minWidth: 40,
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        setState((){
                          currentTap=1;
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=> PetPage())
                              );
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: currentTap==1?  Color(0xFFFFCD4A) : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                "images/petprint.png",
                                color: currentTap==1 ? Colors.black : Colors.grey,
                              ),
                            ),
                            Text(
                              '펫',
                              style: TextStyle(color: currentTap==1 ? Colors.black : Colors.grey,
                                  fontFamily: 'Bit'
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 38),
                    MaterialButton(
                      minWidth: 40,
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        setState((){
                          currentTap=2;
                          /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>CameraPage(camera: ,))
                              );*/
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: currentTap==2?  Color(0xFFFFCD4A) : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: currentTap==2 ? Colors.black : Colors.grey,
                            ),
                            Text(
                              '카메라',
                              style: TextStyle(color: currentTap==2 ? Colors.black : Colors.grey,
                                fontFamily: 'Bit',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), //유저
                    SizedBox(width: 38),
                    MaterialButton(
                      minWidth: 40,
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        setState((){
                          currentTap=3;
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>StorePage())
                              );
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: currentTap==3?  Color(0xFFFFCD4A) : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: currentTap==3 ? Colors.black : Colors.grey,
                            ),
                            Text(
                              '상점',
                              style: TextStyle(color: currentTap==3 ? Colors.black : Colors.grey,
                                fontFamily: 'Bit',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), //상점
                    SizedBox(width: 38),
                    MaterialButton(
                      minWidth: 40,
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        setState((){
                          currentTap=4;
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>SettingPage())
                              );
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentTap==4?  Color(0xFFFFCD4A) : Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.perm_identity,
                                  color: currentTap==4 ? Colors.black : Colors.grey,
                                ),
                                Text(
                                  '내 정보',
                                  style: TextStyle(color: currentTap==4 ? Colors.black : Colors.grey,
                                    fontFamily: 'Bit',
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
