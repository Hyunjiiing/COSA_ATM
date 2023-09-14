import 'package:camera/camera.dart';
import 'package:cosa_atm/bottom_bar.dart';
import 'package:cosa_atm/pages/camera_page.dart';
import 'package:cosa_atm/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<String> shop_images = [
  "assets/images/item1.png",
  "assets/images/item2.png",
  "assets/images/item3.png",
  "assets/images/item4.png",
  "assets/images/item5.png",
  "assets/images/item6.png",
];

List<String> shop_description = [
  "치장아이템 뽑기권",
  "치장 아이템 5회 뽑기권",
  "캐릭터 뽑기권",
  "캐릭터 3회 뽑기권",
  "경험치 5회 부스트",
  "이름변경권",
];
List<String> shop_price = [
  "5000",
  "23900",
  "10000",
  "28900",
  "1000",
  "10000",
];

class shop_page extends StatefulWidget {
  final List<Marker> marker;

  shop_page({
    required List<Marker> this.marker
  });

  @override
  State<shop_page> createState() => _shop_pageState(marker: this.marker);
}

Future<void> _getPosition() async{
  LocationPermission permission = await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  current_latitude = position.latitude;
  current_longitude = position.longitude;
}

int shopTap = 0;

class _shop_pageState extends State<shop_page> {
  final List<Marker> marker;

  _shop_pageState({
    required List<Marker> this.marker
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/100*5,
          ),
          Container(
            color: Colors.white,
            child: shopTap ==0 ?
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/100*7,
                  child: Center(
                    child: Text("상점",style: TextStyle(fontSize: 25,fontFamily: 'Bit',),),
                  ),
                ), //상점 글자
                Container(
                  width: MediaQuery.of(context).size.width/100*90,
                  height: MediaQuery.of(context).size.height/100*5,
                  child: Row(
                    children: [
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          setState(() {
                            shopTap=0;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 2),
                          height: MediaQuery.of(context).size.height/100*6,
                          width: MediaQuery.of(context).size.width/100*30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                            color: Color(0xffFFCD4A),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0,
                                color: Color(0xffFFB156),
                                offset: const Offset(2, -2)
                              )
                            ]
                          ),
                          child: Center(child: Text("아이템",style: TextStyle(fontSize: 15,fontFamily: 'Bit',fontWeight: FontWeight.w800),)),
                        ),
                      ), //아이템 탭
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          setState(() {
                            shopTap=1;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 2),
                          height: MediaQuery.of(context).size.height/100*6,
                          width: MediaQuery.of(context).size.width/100*30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                              color: Color(0xffFFE6A5),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 0,
                                    color: Color(0xffFFB156).withOpacity(0.5),
                                    offset: const Offset(2, -2)
                                )
                              ]
                          ),
                          child: Center(child: Text("뽑기",style: TextStyle(fontFamily: 'Bit',fontSize: 15,fontWeight: FontWeight.w800,color: Colors.grey,))),
                        ),
                      ), //뽑기탭
                    ],
                  ),
                ), // 아이템,뽑기 탭
                Container(
                  width: MediaQuery.of(context).size.width/100*90,
                  height: MediaQuery.of(context).size.height/100*73,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 0.5)
                  ),
                  child: ListView.builder(
                    itemCount: shop_images.length,
                      itemBuilder: (BuildContext ctx, int idx) {
                        return idx%2==0 ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                width: MediaQuery.of(context).size.width/100*40,
                                height: MediaQuery.of(context).size.height/100*20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: MediaQuery.of(context).size.width/100*20,
                                        height: MediaQuery.of(context).size.height/100*10,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey[500],
                                        ),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/100*20,
                                            height: MediaQuery.of(context).size.height/100*10,
                                            child: Image.asset(shop_images[idx],fit: BoxFit.fill,)),
                                      ),
                                    ),
                                    Container(
                                      height: MediaQuery.of(context).size.height/100*3,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey)
                                        )
                                      ),
                                        child: Text(shop_description[idx],style: TextStyle(fontFamily: 'Bit',fontSize: 16),),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width/100*18,
                                          height: MediaQuery.of(context).size.height/100*3.5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey[400],
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(shop_price[idx],style: TextStyle(fontFamily: 'Bit',fontSize: 16),),
                                              Icon(Icons.monetization_on,color: Colors.yellow,)
                                            ],
                                          ),
                                        ),
                                        MaterialButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: (){},
                                          child: Container(
                                            width: MediaQuery.of(context).size.width/100*18,
                                            height: MediaQuery.of(context).size.height/100*3.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Color(0xffFFCD4A),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xffFFB156),
                                                  offset: const Offset(2,2),
                                                )
                                              ]
                                            ),
                                            child: Center(
                                                child: Text("구매",style: TextStyle(fontFamily: 'Bit',color: Colors.white,fontSize: 15),)
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                width: MediaQuery.of(context).size.width/100*40,
                                height: MediaQuery.of(context).size.height/100*20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: MediaQuery.of(context).size.width/100*20,
                                        height: MediaQuery.of(context).size.height/100*10,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey[500],
                                        ),
                                        child: Container(
                                            width: MediaQuery.of(context).size.width/100*20,
                                            height: MediaQuery.of(context).size.height/100*10,
                                            child: Image.asset(shop_images[idx+1],fit: BoxFit.contain,)),
                                      ),
                                    ),
                                    Container(
                                      height: MediaQuery.of(context).size.height/100*3,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(color: Colors.grey)
                                          )
                                      ),
                                      child: Text(shop_description[idx+1],style: TextStyle(fontFamily: 'Bit',fontSize: 16),),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.zero,
                                          width: MediaQuery.of(context).size.width/100*18,
                                          height: MediaQuery.of(context).size.height/100*3.5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey[400],
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(shop_price[idx+1],style: TextStyle(fontSize: 16,fontFamily: 'Bit',),),
                                              Icon(Icons.monetization_on,color: Colors.yellow,)
                                            ],
                                          ),
                                        ),
                                        MaterialButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: (){},
                                          child: Container(
                                            width: MediaQuery.of(context).size.width/100*18,
                                            height: MediaQuery.of(context).size.height/100*3.5,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Color(0xffFFCD4A),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffFFB156),
                                                    offset: const Offset(2,2),
                                                  )
                                                ]
                                            ),
                                            child: Center(
                                                child: Text("구매",style: TextStyle(fontFamily: 'Bit',color: Colors.white,fontSize: 15),)
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                              :
                          Container();
                      }
                  ),
                )
              ],
            )
                :
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/100*7,
                  child: Center(
                    child: Text("상점",style: TextStyle(fontFamily: 'Bit',fontSize: 25),),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/100*90,
                  height: MediaQuery.of(context).size.height/100*5,
                  child: Row(
                    children: [
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          setState(() {
                            shopTap=0;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 2),
                          height: MediaQuery.of(context).size.height/100*6,
                          width: MediaQuery.of(context).size.width/100*30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                              color: Color(0xffFFE6A5),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 0,
                                    color: Color(0xffFFB156).withOpacity(0.5),
                                    offset: const Offset(2, -2)
                                )
                              ]
                          ),
                          child: Center(child: Text("아이템",style: TextStyle(fontFamily: 'Bit',fontSize: 15,fontWeight: FontWeight.w800,color: Colors.grey,),)),
                        ),
                      ), //아이템 탭
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          setState(() {
                            shopTap=1;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 2),
                          height: MediaQuery.of(context).size.height/100*6,
                          width: MediaQuery.of(context).size.width/100*30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                              color: Color(0xffFFCD4A),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 0,
                                    color: Color(0xffFFB156),
                                    offset: const Offset(2, -2)
                                )
                              ]
                          ),
                          child: Center(child: Text("뽑기",style: TextStyle(fontFamily: 'Bit',fontSize: 15,fontWeight: FontWeight.w800))),
                        ),
                      ), //뽑기탭
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/100*90,
                  height: MediaQuery.of(context).size.height/100*68,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 0.5)
                  ),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width/100*90,
                            height: MediaQuery.of(context).size.height/100*50,
                            child: Image.asset("assets/images/drawingMachine.png",fit: BoxFit.contain,)
                        ),
                        MaterialButton(
                            onPressed: (){},
                          child: Container(
                              width: MediaQuery.of(context).size.width/100*40,
                              height: MediaQuery.of(context).size.height/100*17,
                              child: Image.asset("assets/images/button2.gif",fit: BoxFit.contain,)
                          ),
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(marker: widget.marker,),
    );
  }
}
