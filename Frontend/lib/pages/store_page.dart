import 'package:flutter/material.dart';

import 'package:cosa_atm/bottom_bar.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BaseStorePage(),
    );
  }
}

class BaseStorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<BaseStorePage> {
  String selectedButton = '아이템';

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
                    '            상점',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: 'Bit'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text('1200 G', style: TextStyle(fontFamily: 'Bit'),),
                ),
                SizedBox(width: 16.0),
              ],
            ),
            SizedBox(height: 40.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedButton = '아이템';
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedButton == '아이템'
                              ? Colors.grey[700]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          '아이템',
                          style: TextStyle(color: Color(0xFFFFCD4A), fontFamily: 'Bit'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 1.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedButton = '뽑기';
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedButton == '뽑기'
                              ? Colors.grey[700]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          '뽑기',
                          style: TextStyle(color: Color(0xFFFFCD4A), fontFamily: 'Bit'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.sort),
                Text('정렬', style: TextStyle(fontFamily: 'Bit'),),
                SizedBox(width: 16.0),
              ],
            ),
            Container(
              height: 2,
              color: Colors.grey[300],
              margin: EdgeInsets.symmetric(vertical: 8.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: Image.asset(
                            'assets/images/item1.png',
                            height: 100,
                            width: 100,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text('아이템 뽑기권 3회', style: TextStyle(fontFamily: 'Bit')),
                        SizedBox(height: 6.0),
                        Text('300G', style: TextStyle(fontFamily: 'Bit')),
                        SizedBox(height: 6.0),
                        ElevatedButton(
                          onPressed: () {
                            // 구매 버튼 기능 추가
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFCD4A),
                          ),
                          child: Text(
                            '구매',
                            style: TextStyle(
                              color: Colors.grey[800], fontFamily: 'Bit'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: Image.asset(
                            'assets/images/item2.png',
                            height: 100,
                            width: 100,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text('리워드 2배 적용권', style: TextStyle(fontFamily: 'Bit')),
                        SizedBox(height: 6.0),
                        Text('800G', style: TextStyle(fontFamily: 'Bit')),
                        SizedBox(height: 6.0),
                        ElevatedButton(
                          onPressed: () {
                            // 구매 버튼 기능 추가
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFCD4A),
                          ),
                          child: Text(
                            '구매',
                            style: TextStyle(
                              color: Colors.grey[800], fontFamily: 'Bit'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: Image.asset(
                            'assets/images/item3.png',
                            height: 100,
                            width: 100,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text('아이템 뽑기권 3회', style: TextStyle(fontFamily: 'Bit')),
                        SizedBox(height: 6.0),
                        Text('300G', style: TextStyle(fontFamily: 'Bit')),
                        SizedBox(height: 6.0),
                        ElevatedButton(
                          onPressed: () {
                            // 구매 버튼 기능 추가
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFCD4A),
                          ),
                          child: Text(
                            '구매',
                            style: TextStyle(
                              color: Colors.grey[800], fontFamily: 'Bit'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: Image.asset(
                            'assets/images/item4.png',
                            height: 100,
                            width: 100,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text('리워드 2배 적용권', style: TextStyle(fontFamily: 'Bit')),
                        SizedBox(height: 6.0),
                        Text('800G', style: TextStyle(fontFamily: 'Bit')),
                        SizedBox(height: 6.0),
                        ElevatedButton(
                          onPressed: () {
                            // 구매 버튼 기능 추가
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFCD4A),
                          ),
                          child: Text(
                            '구매',
                            style: TextStyle(
                              color: Colors.grey[800], fontFamily: 'Bit'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final Widget itemImage;

  ItemCard(
      {required this.itemName,
      required this.itemPrice,
      required this.itemImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          itemImage,
          SizedBox(height: 8.0),
          Text(itemName),
          Text(itemPrice),
        ],
      ),
    );
  }
}
