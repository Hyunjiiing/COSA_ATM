import 'package:camera/camera.dart';
import 'package:cosa_atm/bottom_bar.dart';
import 'package:cosa_atm/camera_page.dart';
import 'package:cosa_atm/map_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class shop_page extends StatefulWidget {
  const shop_page({Key? key}) : super(key: key);

  @override
  State<shop_page> createState() => _shop_pageState();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: MaterialButton(
          onPressed: (){
            setState(() {
              currentTap=0;
            });
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: shopTap ==0 ?
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/100*7,
              child: Center(
                child: Text("상점",style: TextStyle(fontSize: 25),),
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
                        color: Color(0xffFFCD4A),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0,
                            color: Color(0xffFFB156),
                            offset: const Offset(2, -2)
                          )
                        ]
                      ),
                      child: Center(child: Text("아이템",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800),)),
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
                      child: Center(child: Text("뽑기",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color: Colors.grey,))),
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
              child: ListView.builder(
                itemCount: 10,
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
                                        child: Image.asset("images/img.png",fit: BoxFit.fill,)),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height/100*3,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey)
                                    )
                                  ),
                                    child: Text("${idx},asdfasdf",style: TextStyle(fontSize: 20),),
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
                                          Text("50",style: TextStyle(fontSize: 20),),
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
                                            child: Text("구매",style: TextStyle(color: Colors.white,fontSize: 15),)
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
                                        child: Image.asset("images/img1.png",fit: BoxFit.contain,)),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height/100*3,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(color: Colors.grey)
                                      )
                                  ),
                                  child: Text("${idx+1},sdfzsdf",style: TextStyle(fontSize: 20),),
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
                                          Text("50",style: TextStyle(fontSize: 20),),
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
                                            child: Text("구매",style: TextStyle(color: Colors.white,fontSize: 15),)
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
                      Container()
                    ;
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
                child: Text("상점",style: TextStyle(fontSize: 25),),
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
                      child: Center(child: Text("아이템",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color: Colors.grey,),)),
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
                      child: Center(child: Text("뽑기",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800))),
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
                        child: Image.asset("images/img3.png",fit: BoxFit.contain,)
                    ),
                    MaterialButton(
                        onPressed: (){},
                      child: Container(
                          width: MediaQuery.of(context).size.width/100*40,
                          height: MediaQuery.of(context).size.height/100*17,
                          child: Image.asset("images/drawing.png",fit: BoxFit.cover,)
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
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
      bottomNavigationBar: bottom_bar(),
    );
  }
}
