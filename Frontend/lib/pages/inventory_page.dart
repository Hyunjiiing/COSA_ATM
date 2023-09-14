import 'package:cosa_atm/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InventoryPage extends StatelessWidget {
  final List<Marker> marker;

  InventoryPage({
    required List<Marker> this.marker
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Bit',
      ),
      home: InventoryScreen(marker: this.marker,),
    );
  }
}

class InventoryScreen extends StatefulWidget {
  final List<Marker> marker;

  InventoryScreen({
    required List<Marker> this.marker
  });

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  int showItems = 0;

  final List<String> itemNames = [
    '게임아이템 3회 뽑기권',
    '리워드 2배 적용권',
    '펫 먹이',
    '꾸밈 아이템 3회 뽑기권',
    '경험치 피버 타임 적용권',
    // 임시, db연동하면 삭제할 예정
  ];

  final List<int> itemCount = [
    1,
    3,
    41,
    2,
    2,
  ];

  final List<String> itemImagePaths = [
    'assets/images/item1.png',
    'assets/images/item2.png',
    'assets/images/item3.png',
    'assets/images/item1.png',
    'assets/images/item4.png',
  ];

  final List<String> catNames = [
    '냥냥이',
    '치즈냥이',
    '도둑냥이',
    '반반이',
    '오드냥이',
    '양말냥이',
    '수제비'
  ];

  final List<String> catImagePaths = [
    'assets/images/character1.png',
    'assets/images/character2.png',
    'assets/images/character3.png',
    'assets/images/character4.png',
    'assets/images/character5.png',
    'assets/images/character6.png',
    'assets/images/character7.png',
  ];

  int currentTap = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '인벤토리',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 33,
                        ),
                      ),
                    ),
                    Container(
                      child: Image(
                        image: AssetImage('assets/images/inven_cat.gif'),
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Text(
                      '냥냥이',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Text(
                      'Level 6/20',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(height: 17),
                    Padding(
                      padding: EdgeInsets.only(left: 5.6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showItems=0;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  topRight: Radius.circular(13),
                                ),
                                color: showItems==0
                                    ? Color(0xFFFFCD4A)
                                    : Color(0xFFFFCD4A).withOpacity(0.5),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 9),
                              child: Row(
                                children: [
                                  Text(
                                    '내 아이템',
                                    style: TextStyle(
                                      color: showItems==0
                                          ? Colors.black
                                          : Colors.grey,
                                      fontSize: 17,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showItems=1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(13),
                                  topLeft: Radius.circular(13),
                                ),
                                color: showItems==1
                                    ? Color(0xFFFFCD4A)
                                    : Color(0xFFFFCD4A).withOpacity(0.5),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 9),
                              child: Row(
                                children: [
                                  Text(
                                    '내 캐릭터',
                                    style: TextStyle(
                                      color: showItems==1
                                          ? Colors.black
                                          : Colors.grey,
                                      fontSize: 17,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showItems=2;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(13),
                                  topLeft: Radius.circular(13),
                                ),
                                color: showItems==2
                                    ? Color(0xFFFFCD4A)
                                    : Color(0xFFFFCD4A).withOpacity(0.5),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 9),
                              child: Row(
                                children: [
                                  Text(
                                    '꾸미기',
                                    style: TextStyle(
                                      color: showItems==2
                                          ? Colors.black
                                          : Colors.grey,
                                      fontSize: 17,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.44,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: showItems==0
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 5.0,
                                    ),
                                    itemCount: 5,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Container(
                                          color: Colors.grey[200],
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 8),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[350],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Image.asset(
                                                        itemImagePaths[index],
                                                        width: 63,
                                                        height: 63,
                                                      ),
                                                      Container(
                                                        width: 63,
                                                        height: 63,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 0.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                itemNames[index],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(width: 8),
                                                  Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[350],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Text(
                                                      ' ${itemCount[index]} 개',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  '아이템 사용하기'),
                                                              content: Text(
                                                                  '${itemNames[index]}을(를) 사용합니다.'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    '취소',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFFFFCD4A),
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 8),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xFFFFCD4A),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    minimumSize:
                                                                        Size(72,
                                                                            32),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          8,
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    '사용하기',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Color(0xFFFFCD4A),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        minimumSize:
                                                            Size(50, 32),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 10,
                                                          vertical: 8,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        '사용하기',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : showItems==1 ?
                                    GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 6.0,
                                mainAxisSpacing: 6.0,
                              ),
                              itemCount: 7,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    color: Colors.grey[200],
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 3),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[350],
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8),
                                            ),
                                            child: Image.asset(
                                              catImagePaths[index],
                                              width: 60,
                                              height: 60,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          catNames[index],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            SizedBox(width: 8),
                                            Container(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // 사용하기 버튼이 눌렸을 때 실행되는 코드 작성
                                                },
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                  Color(0xFFFFCD4A),
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(8),
                                                  ),
                                                  minimumSize:
                                                  Size(72, 32),
                                                ),
                                                child: Text(
                                                  '장착하기',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                                            :
                                    GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 6.0,
                                mainAxisSpacing: 6.0,
                              ),
                              itemCount: 7,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    color: Colors.grey[200],
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 3),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[350],
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8),
                                            ),
                                            child: Image.asset(
                                              catImagePaths[index],
                                              width: 60,
                                              height: 60,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          catNames[index],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            SizedBox(width: 8),
                                            Container(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // 사용하기 버튼이 눌렸을 때 실행되는 코드 작성
                                                },
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                  Color(0xFFFFCD4A),
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(8),
                                                  ),
                                                  minimumSize:
                                                  Size(72, 32),
                                                ),
                                                child: Text(
                                                  '장착하기',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(marker: widget.marker,));
  }
}
