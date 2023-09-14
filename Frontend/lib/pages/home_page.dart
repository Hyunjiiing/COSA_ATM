import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GridView',
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(child: Home())));
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeX = (MediaQuery.of(context).size.width);
    final sizeY = (MediaQuery.of(context).size.height - 100);
    return Container(
      child: Column(
        children: [
          Container(
            height: 25,
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
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
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
              child: GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 3,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                padding: const EdgeInsets.all(5.0),
                children: createGallery(9),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);// Handle the button press here
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
                onPressed: () {
                  // Handle the button press here
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

  List<Widget> createGallery(int numImg) {
    List<Widget> images = [];
    List<String> urls = [];
    urls.add('../assets/images/manhole1.png');
    urls.add('../assets/images/manhole2.png');
    urls.add('../assets/images/manhole3.png');
    urls.add('../assets/images/manhole4.png');
    urls.add('../assets/images/manhole5.png');
    urls.add('../assets/images/manhole6.png');
    urls.add('../assets/images/manhole7.png');
    urls.add('../assets/images/manhole8.png');
    urls.add('../assets/images/manhole9.png');

    Widget image;
    int i = 0;
    int len = urls.length;
    while (i < numImg) {
      image = SelectableImage(imageUrl: urls[i % len]);
      images.add(image);
      i++;
    }
    return images;
  }
}

class SelectableImage extends StatefulWidget {
  final String imageUrl;
  const SelectableImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _SelectableImageState createState() => _SelectableImageState();
}

class _SelectableImageState extends State<SelectableImage> {
  bool _isSelected = false;

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage(widget.imageUrl)),
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
                      child: Image.asset('../assets/images/check.png'),
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
