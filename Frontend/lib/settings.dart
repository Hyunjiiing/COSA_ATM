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

class SettingsPage extends StatelessWidget {
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
                        '사용자 이름 또는 캐릭터 이름',
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
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        // 스위치 버튼의 상태 변경에 대한 로직을 구현
                      },
                      activeTrackColor: Color(0xFFFFCD4A),
                      activeColor: Color(0xFFFFCD4A),
                      inactiveThumbColor: Colors.grey,
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
                    trailing: Icon(Icons.chevron_right),
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
                        color: Colors.black,
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
                        color: Colors.black,
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