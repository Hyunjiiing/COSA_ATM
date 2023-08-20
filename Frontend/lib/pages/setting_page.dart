import 'package:cosa_atm/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: baseSettingsPage(),
    );
  }
}

class baseSettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

int currentTap = 0;

class _SettingsPageState extends State<baseSettingsPage> {
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
                    backgroundImage: AssetImage('assets/user_icon.png'),
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
                    trailing: Text(
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
      bottomNavigationBar: BottomBar(),
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
    return Container(
      decoration: BoxDecoration(
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
