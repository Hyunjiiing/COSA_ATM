import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosa_atm/pages/community_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class upload_page extends StatefulWidget {
  final List<Marker> marker;

  upload_page({
    required List<Marker> this.marker
  });

  @override
  State<upload_page> createState() => _upload_pageState();
}


final TitleController = TextEditingController();
final DescriptionController = TextEditingController();

FocusNode textFocus = FocusNode();
FocusNode titletextFocus = FocusNode();
List<String> dropdownList = ['가로등', '도로', '표지판', '기타 등등'];
String selectedDropdown = dropdownList[0];

class _upload_pageState extends State<upload_page> {
  XFile? pickedFile;
  var images;


  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage storage=FirebaseStorage.instance;
  String url="";

  Future selectFile1()async{
    final result= await ImagePicker().pickImage(source:ImageSource.gallery);
    if(result==null) return;//아무것도 꺼내지않았을 때
    setState((){
      pickedFile=result;
    });
    images= File(pickedFile!.path);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedDropdown = dropdownList[0];
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        textFocus.unfocus();
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/100*5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/100*4,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MaterialButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width/100*20,),
                      Align(alignment: Alignment.center,child: Text("글쓰기",style: TextStyle(fontFamily: 'Bit',fontSize: 30),)),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/100*80,
                  height: MediaQuery.of(context).size.height/100*90,
                  child: ListView(
                    children: [
                      pickedFile==null ?
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: (){
                          selectFile1();
                        },
                        child: DottedBorder(
                            strokeWidth: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width/100*77,
                              height: MediaQuery.of(context).size.height/100*35,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined,size: 60,),
                                  Text("사진을 등록해주세요.")
                                ],
                              )
                            )
                        ),
                      )
                          :
                      MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: MediaQuery.of(context).size.width/100*80,
                          onPressed: (){
                            selectFile1();
                          },
                        child: Container(
                            width: MediaQuery.of(context).size.width/100*70,
                            height: MediaQuery.of(context).size.height/100*35,
                          child: Image.file(images,fit: BoxFit.cover,),
                        )
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/100*4,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height/100*6,
                              child: TextField(
                                focusNode: titletextFocus,
                                controller: TitleController,
                                decoration: InputDecoration(
                                  labelText: '제목',
                                  hintText: '제목을 입력해주세요',
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height/100*1,
                            ),
                            DropdownButton(
                              isExpanded: true,
                              value: selectedDropdown,
                              items: dropdownList
                                  .map((e) => DropdownMenuItem(
                                value: e, // 선택 시 onChanged 를 통해 반환할 value
                                child: Text(e),
                              ))
                                  .toList(),
                              onChanged: (value) { // items 의 DropdownMenuItem 의 value 반환
                                setState(() {
                                  selectedDropdown = value!;
                                });
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height/100*1,
                            ),
                            SizedBox(
                              height: 200,
                              child: TextField(
                                focusNode: textFocus,
                                maxLines: null,
                                expands: true,
                                controller: DescriptionController,
                                decoration: InputDecoration(
                                  labelText: '내용',
                                  hintText: '내용을 입력해주세요',
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                onChanged: (text){
                                  print(text);
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height/100*2,
                            ),
                            MaterialButton(
                              padding: EdgeInsets.zero,
                              minWidth: MediaQuery.of(context).size.width,
                                onPressed: ()async{
                                  await FirebaseAuth.instance.signInAnonymously();
                                  int cnt=0;
                                  await _firestore.collection('Community').count().get().then(
                                        (res) => cnt=res.count
                                  );

                                  final firebaseStorageRef = storage.ref().child('community').child('${cnt}.png');
                                  final uploadTask = firebaseStorageRef.putFile(
                                      images
                                  );

                                  await uploadTask.whenComplete(() => null);

                                  url= await firebaseStorageRef.getDownloadURL();

                                  await _firestore.collection("Community").doc("${cnt}").set(
                                      {
                                        "url": "${url}",
                                        "Title": "${TitleController.text}",
                                        "Type" : "$selectedDropdown",
                                        "Description": "${DescriptionController.text}",
                                        "User_name": "오현지"
                                      }
                                  );
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => community_page(marker: widget.marker,))
                                    );
                                },
                              child: Container(
                                height: MediaQuery.of(context).size.height/100*6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFFFFCD4A),
                                ),
                                child: Center(
                                  child: Text("업로드 하기",style: TextStyle(fontFamily: 'Bit',fontSize: 20),),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
