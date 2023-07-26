import 'package:cosa_atm/bottom_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GachaPage(),
    );
  }
}

class GachaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    '          아이템 뽑기',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text('5 장'),
                ),
                SizedBox(width: 16.0),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              height: 2,
              color: Colors.grey[300],
              margin: EdgeInsets.symmetric(vertical: 8.0),
            ),
            Image.asset(
              'images/img3.png',
              height: 470,
              width: 470,
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // 뽑기 버튼 기능
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFCD4A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                '뽑기',
                style: TextStyle(
                  backgroundColor: Color(0xFFFFCD4A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
