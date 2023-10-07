import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosa_atm/bottom_bar.dart';
import 'package:cosa_atm/pages/upload_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class community_page extends StatefulWidget {
  final List<Marker> marker;

  community_page({
    required List<Marker> this.marker
  });


  @override
  State<community_page> createState() => _community_pageState();
}

List<String> improve_title=[
  "가로등 파손 교체 요청",
  "표지판 교체 요청"
];

List<String> improve_before=[
  "assets/images/before.jpg",
  "assets/images/before2.png",
];

List<String> improve_after=[
  "assets/images/after.jpg",
  "assets/images/after2.png",
];

List<String> improve_time=[
  "2023-09-22",
  "2023-08-13",
];

List<String> improve_adress=[
  "충청북도 청주시 서원구 충대로 1",
  "충청북도 청주시 서원구 개신동 3-16",
];

class _community_pageState extends State<community_page> {
  List<String> title=[];
  List<String> description=[];
  List<String> type=[];
  List<String> User_name=[];
  List<String> url=[];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage storage=FirebaseStorage.instance;
  int cnt=0;
  int com_tab=0;

  void getCommunityInfo() async {
    await FirebaseAuth.instance.signInAnonymously();

    await _firestore.collection('Community').count().get().then(
            (res) => cnt=res.count
    );

    final documentSnapshot = await FirebaseFirestore.instance
        .collection("Community")
        .get();

    for(int index=0;index<cnt;index++){
      title.add(documentSnapshot.docs[index].get("Title").toString());
      User_name.add(documentSnapshot.docs[index].get("User_name").toString());
      type.add(documentSnapshot.docs[index].get("Type").toString());
      description.add(documentSnapshot.docs[index].get("Description").toString());
      url.add(documentSnapshot.docs[index].get("url").toString());
    }
  }

  @override
  void initState() {
    getCommunityInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height/100*10,
            child: Center(
              child: Text("커뮤니티",style: TextStyle(fontSize: 25,fontFamily: 'Bit'),),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height/100*7,
            child: Row(
              children: [
                MaterialButton(
                  padding: EdgeInsets.zero,
                    minWidth: MediaQuery.of(context).size.width/100*33,
                    onPressed: (){
                      setState(() {
                        com_tab=0;
                      });
                    },
                  child: Container(
                    width: MediaQuery.of(context).size.width/100*33,
                    height: MediaQuery.of(context).size.height/100*7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: com_tab == 0 ? Border(
                        bottom: BorderSide(color: Color(0xffFFB156),width: 4),
                      ) : Border()
                    ),
                    child: Center(child: Text("게시판",style: TextStyle(fontFamily: 'Bit',fontSize: 20),),),
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  minWidth: MediaQuery.of(context).size.width/100*33,
                  onPressed: (){
                    setState(() {
                      com_tab=1;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/100*33,
                    height: MediaQuery.of(context).size.height/100*7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: com_tab == 1 ? Border(
                          bottom: BorderSide(color: Color(0xffFFB156),width: 4),
                        ) : Border()
                    ),
                    child: Center(child: Text("개선상황",style: TextStyle(fontFamily: 'Bit',fontSize: 20),),),
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  minWidth: MediaQuery.of(context).size.width/100*33,
                  onPressed: (){
                    setState(() {
                      com_tab=2;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/100*33,
                    height: MediaQuery.of(context).size.height/100*7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: com_tab == 2 ? Border(
                          bottom: BorderSide(color: Color(0xffFFB156),width: 4),
                        ) : Border()
                    ),
                    child: Center(child: Text("공지사항",style: TextStyle(fontFamily: 'Bit',fontSize: 20),),),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height/100*75,
            child: com_tab ==0?
              ListView.builder(
              padding: EdgeInsets.only(top: 10),
                itemCount: cnt,
                itemBuilder: (BuildContext ctx, int idx) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: MediaQuery.of(context).size.height/100*15,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black)
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width/100*30,
                            height: MediaQuery.of(context).size.height/100*15,
                            child: Image.network(url[idx],fit: BoxFit.cover,)
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          width: MediaQuery.of(context).size.width/100*70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${title[idx]}",style: TextStyle(fontSize: 20,fontFamily: 'Bit',overflow: TextOverflow.ellipsis,),),
                                  Text("${User_name[idx]}",style: TextStyle(color:Colors.grey[600],fontSize: 20,fontFamily: 'Bit',overflow: TextOverflow.ellipsis,),),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height/100*1,),
                              Text("${type[idx]}",style: TextStyle(color: Colors.redAccent,fontSize: 15,fontFamily: 'Bit'),),
                              Text("${description[idx]}",maxLines: 5,style: TextStyle(fontSize: 15,fontFamily: 'Bit',overflow: TextOverflow.ellipsis,),)
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
            )
                    :
                com_tab==1 ?
                    Container(
                      height: MediaQuery.of(context).size.height/100*75,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 2,
                        itemBuilder: (BuildContext ctx, int idx) {
                          return MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: (){
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
                                                            child: Image.asset("${improve_before[idx]}",fit: BoxFit.cover,)
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
                                                              child: Image.asset("${improve_after[idx]}",fit: BoxFit.cover,)
                                                          ),
                                                          Text("After",style: TextStyle(fontFamily: 'Bit',fontSize: 25,color: Colors.green),)
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                              Text("${improve_time[idx]}",style: TextStyle(fontFamily: 'Bit',fontSize: 20,color: Colors.black),),
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
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: MediaQuery.of(context).size.height/100*15,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black)
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width/100*30,
                                      height: MediaQuery.of(context).size.height/100*15,
                                      child: Image.asset("${improve_before[idx]}",fit: BoxFit.cover,)
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 10),
                                    width: MediaQuery.of(context).size.width/100*70,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("${improve_title[idx]}",style: TextStyle(fontFamily: 'Bit',fontSize: 25),),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${improve_adress[idx]}",style: TextStyle(fontFamily: 'Bit',fontSize: 15,color: Colors.grey),),
                                            Text("${improve_time[idx]}",style: TextStyle(fontFamily: 'Bit',fontSize: 15,color: Colors.grey),),
                                          ],
                                        )
                                      ],
                                    )
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    )
                        :
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            height: MediaQuery.of(context).size.height/100*10,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:Text("공지사항",style: TextStyle(fontFamily: 'Bit',fontSize: 40),),
                              )
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 20),
                              margin: EdgeInsets.only(bottom: 20),
                              height: MediaQuery.of(context).size.height/100*5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:Text("ATM에서 전하는 새로운 소식을 확인하세요.",style: TextStyle(fontFamily: 'Bit',fontSize: 20),),
                              )
                          ),
                          Container(
                            height: 1000,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                                itemCount: 1,
                                itemBuilder: (BuildContext ctx, int idx) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    height: MediaQuery.of(context).size.height/100*10,
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(color: Colors.black)
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left: 20),
                                                width: MediaQuery.of(context).size.width/100*85,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width/100*12,
                                                          height: MediaQuery.of(context).size.height/100*3,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(40),
                                                            border: Border.all(color: Colors.redAccent),
                                                          ),
                                                          child: Center(
                                                            child: Text("공지",style: TextStyle(color: Colors.redAccent,fontFamily: 'Bit',fontSize: 15),),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.only(left: 15),
                                                          width: MediaQuery.of(context).size.width/100*68,
                                                          child: Text(
                                                            "ATM에서 전하는 새로운 소식을 확인하세요.",
                                                            style: TextStyle(fontFamily: 'Bit',fontSize: 20,),
                                                            maxLines: 3,
                                                            overflow: TextOverflow.fade,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text("2023-09-21",style: TextStyle(fontFamily: 'Bit',fontSize: 15,color: Colors.grey),),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width/100*15,
                                                child: Align(
                                                  alignment: Alignment.topCenter,
                                                  child: Icon(Icons.keyboard_arrow_down,size: 50,color: Colors.grey,),
                                                ),
                                              )
                                            ],
                                          )
                                        )
                                      ],
                                    ),
                                  );
                                }
                            ),
                          )
                        ],
                      ),
                    )
          )
        ],
      ),
      floatingActionButton: MaterialButton(
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 4,
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(1,1)
                )
              ]
          ),
          child: Icon(Icons.add,color: Colors.black,size: 50,),
        ),
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => upload_page(marker: widget.marker,)
              )
          );
        },
      ),
      bottomNavigationBar: BottomBar(marker: widget.marker),
    );
  }
}
