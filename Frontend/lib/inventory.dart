import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Bit',
      ),
      home: InventoryScreen(),
    );
  }
}

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  bool showItems = true;

  void _toggleItems() {
    setState(() {
      showItems = !showItems;
    });
  }

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

  int currentTap=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
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
                  SizedBox(height: 17),
                  Container(
                    child: Image.asset(
                      'images/cat1.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Text(
                    '반반이',
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
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 5.6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _toggleItems();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(13),
                                topRight: Radius.circular(13),
                              ),
                              color: showItems
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
                                    color:
                                    showItems ? Colors.black : Colors.grey,
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
                            _toggleItems();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(13),
                                topLeft: Radius.circular(13),
                              ),
                              color: !showItems
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
                                    color:
                                    !showItems ? Colors.black : Colors.grey,
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
                    height: 280,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: showItems
                            ? GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 6.0,
                            mainAxisSpacing: 6.0,
                          ),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: Colors.grey[200],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 8),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[350],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Image.asset(
                                          'images/item1.png',
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      itemNames[index],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 8),
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[350],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            ' ${itemCount[index]} 개',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text('아이템 사용하기'),
                                                    content: Text('${itemNames[index]}을(를) 사용합니다.'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text(
                                                          '취소',
                                                          style: TextStyle(
                                                            color: Color(0xFFFFCD4A),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Color(0xFFFFCD4A),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          padding: EdgeInsets.symmetric(
                                                            horizontal: 12,
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
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFFFFCD4A),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
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
                            : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 6.0,
                            mainAxisSpacing: 6.0,
                          ),
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: Colors.grey[200],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 8),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[350],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Image.asset(
                                          'images/character1.png',
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
                            /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>map_page())
                              );*/
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
                                    style: TextStyle(color: currentTap==0 ? Colors.black : Colors.grey),
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
                            /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=> map_page())
                              );*/
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
                                style: TextStyle(color: currentTap==1 ? Colors.black : Colors.grey),
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
                            /* Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>shop_page())
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
                                style: TextStyle(color: currentTap==2 ? Colors.black : Colors.grey),
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
                            /* Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>shop_page())
                              );*/
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
                                style: TextStyle(color: currentTap==3 ? Colors.black : Colors.grey),
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
                            /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>map_page())
                              );*/
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
                                color: currentTap==4?  Color(0xFFFFCD4A) : Colors.transparent,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.settings,
                                    color: currentTap==4 ? Colors.black : Colors.grey,
                                  ),
                                  Text(
                                    '설정',
                                    style: TextStyle(color: currentTap==4 ? Colors.black : Colors.grey),
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
      ),
    );
  }
}