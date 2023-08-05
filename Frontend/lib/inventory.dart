import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 6,
              child: GestureDetector(
                onTap: () {
                  // 뒤로가기 기능 추가
                },
                child: Icon(
                  Icons.chevron_left,
                  size: 35,
                ),
              ),
            ),
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
                        fontSize: 25,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -2,
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
                      fontSize: 17,
                      fontFamily: 'Noto Sans KR Medium',
                      fontWeight: FontWeight.w200,
                      letterSpacing: -2,
                    ),
                  ),
                  Text(
                    'Level 6/20',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Noto Sans KR Medium',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -2,
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
                                horizontal: 16, vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  '내 아이템',
                                  style: TextStyle(
                                    color:
                                    showItems ? Colors.black : Colors.grey,
                                    fontSize: 15,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -1.5,
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
                                horizontal: 16, vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  '내 캐릭터',
                                  style: TextStyle(
                                    color:
                                    !showItems ? Colors.black : Colors.grey,
                                    fontSize: 15,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -1.5,
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
                    height: 250,
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
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 6.0,
                            mainAxisSpacing: 6.0,
                          ),
                          itemCount: 17,
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: Colors.grey[200],
                                child: Center(
                                  child: Text(
                                    'Item $index',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Noto Sans KR',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -2,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                            : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 6.0,
                            mainAxisSpacing: 6.0,
                          ),
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              // Wrap the content with ClipRRect
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: Colors.grey[200],
                                child: Center(
                                  child: Text(
                                    'Character $index',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Noto Sans KR',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -2,
                                    ),
                                  ),
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
    );
  }
}
