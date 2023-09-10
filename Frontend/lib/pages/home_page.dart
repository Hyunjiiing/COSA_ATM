import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosa_atm/pages/map_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(child: Home()));
  }
}
final List<bool> selectedImageIndexes = [false, false, false, false, false, false, false, false, false];
final List<String> keys = [];

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('User');

    final sizeX = (MediaQuery.of(context).size.width);
    final sizeY = (MediaQuery.of(context).size.height - 100);
    return Container(
      child: Column(
        children: [
          Container(
            height: 55,
            color: Color(0xffFFCD4A),
          ),
          Container(
            color: Color(0xffFFCD4A),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "아래 사진들 중 노후화된\n'맨홀'을 모두 골라주세요",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500, fontFamily: 'Bit',),
                  ),
                ),
                Container(
                  height: 25,
                ),
              ],
            ),
          ),
          Container(
            height: 75,
          ),
      SizedBox(
        width: sizeX,
        height: sizeY - 200,
        child: FutureBuilder(
          future: createGallery(9),
          builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 3,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                padding: const EdgeInsets.all(5),
                children:snapshot.data!,
              );
            }
          },
        ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle the button press here
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffFF6D6D),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // Set borderRadius here
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text(
                    'STOP',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                width: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Handle the button press here
                  // 후처리
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

                  DocumentSnapshot userInfo = await user.doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3').get();
                  Map<String, dynamic> data = userInfo.data()! as Map<String, dynamic>;

                  bool isToday(Timestamp timestamp) {
                    DateTime date = timestamp.toDate();
                    DateTime now = DateTime.now();

                    return date.year == now.year && date.month == now.month && date.day == now.day;
                  }

                  Map<String, dynamic> quest = data["quest"] as Map<String, dynamic>;
                  if (isToday(quest["date"])) {
                    quest['quest1'] = quest['quest2'] = quest['quest3'] = 0;
                  }
                  quest['quest1'] += 1;

                  user
                      .doc('YlKcdF67V6WGeFUmNhcQFuv5NrE3')
                      .update({'quest': quest})
                      .then((value) => print("User Updated"))
                      .catchError((error) => print("Failed to update user: $error"));

                  CollectionReference manhole = FirebaseFirestore.instance.collection('Manhole');
                  for (int i = 0; i < 9; i++) {
                    DocumentSnapshot manholeInfo = await manhole.doc(keys[i]).get();
                    Map<String, dynamic> data = manholeInfo.data()! as Map<String, dynamic>;
                    if (selectedImageIndexes[i]) {
                        manhole
                            .doc(keys[i])
                            .update({'count': data['count'] + 1});
                      }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffFFCD4A),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // Set borderRadius here
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<List<Widget>> createGallery(int numImg) async {
    CollectionReference manhole = FirebaseFirestore.instance.collection('Manhole');
    QuerySnapshot url = await manhole.limit(9).get();

    List<Widget> images = [];
    List<String> urls = [];

    url.docs.forEach((doc) {
      var data = doc.data()! as Map<String, dynamic>;
      urls.add(data['url']);
      keys.add(data['key']);
    });

    Widget image;
    int i = 0;
    int len = urls.length;

    while (i < numImg) {
      image = SelectableImage(imageUrl: urls[i % len], index: i); // 이 부분을 수정했습니다.
      images.add(image);
      i++;
    }

    return images;
  }}

class SelectableImage extends StatefulWidget {
  final String imageUrl;
  final int index;
  const SelectableImage({Key? key, required this.imageUrl, required this.index}) : super(key: key); // 이 부분을 수정했습니다.

  @override
  _SelectableImageState createState() => _SelectableImageState();
}

class _SelectableImageState extends State<SelectableImage> {
  bool _isSelected = false;

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
      selectedImageIndexes[widget.index] = !selectedImageIndexes[widget.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.imageUrl), // Image.network 대신 NetworkImage를 사용합니다.
          ),
        ),
        child: _isSelected
            ? Stack(
          children: [
            Positioned(
              top: 8.0,
              left: 8.0,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child:
                Image.asset('assets/images/check.png'),
              ),
            ),
          ],
        )
            : null,
      ),
    );
  }
  }
