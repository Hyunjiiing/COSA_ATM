import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

int currentTap=0;

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[100],
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(
                        'assets/user_icon.png'),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LeeDY',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              WhiteBox(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconWithTitle(
                        icon: Icons.star,
                        title: '포인트',
                      ),
                      Container(
                        height: 24,
                        child: VerticalDivider(color: Colors.grey),
                      ),
                      IconWithTitle(
                        icon: Icons.emoji_events,
                        title: '내 티어',
                      ),
                      Container(
                        height: 24,
                        child: VerticalDivider(color: Colors.grey),
                      ),
                      IconWithTitle(
                        icon: Icons.badge,
                        title: '내 배지',
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              WhiteBox(
                children: [
                  ListTile(
                    leading: Icon(Icons.notification_important),
                    title: Text(
                      '공지 및 이벤트',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text(
                      '활동 기록',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text(
                      '뽑기 내역',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text(
                      '알림 수신 설정',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                      ),
                    ),
                    trailing: Transform.scale(
                      scale: 0.8, // 원하는 크기 비율로 조절 (1.0이 기본 크기)
                      child: CupertinoSwitch(
                        value: true,
                        onChanged: (value) {
                          // 스위치 버튼의 상태 변경에 대한 로직
                        },
                        activeColor: Color(0xFFFFCD4A),
                        trackColor: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              WhiteBox(
                children: [
                  ListTile(
                    leading: Icon(Icons.description),
                    title: Text(
                      '약관 및 정책',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text(
                      '버전 정보',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                      ),
                    ),
                    trailing:  Text(
                      '0.0.0',
                      style: TextStyle(
                        color: Colors.grey[350],
                        fontSize: 15,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.person_remove),
                    title: Text(
                      '회원 탈퇴',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Team COSA',
                      style: TextStyle(
                        color: Colors.grey[350],
                        fontSize: 12,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'K-HACATHON 11',
                      style: TextStyle(
                        color: Colors.grey[350],
                        fontSize: 12,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
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

class IconWithTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  IconWithTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32),
        SizedBox(height: 8.0),
        Text(title),
      ],
    );
  }
}

class WhiteBox extends StatelessWidget {
  final List<Widget> children;

  WhiteBox({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
    ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: children,
      ),
    );
  }
}