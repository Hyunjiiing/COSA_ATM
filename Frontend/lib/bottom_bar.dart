import 'package:cosa_atm/map_page.dart';
import 'package:cosa_atm/shop_page.dart';
import 'package:flutter/material.dart';

class bottom_bar extends StatefulWidget {

  const bottom_bar({Key? key}) : super(key: key);

  @override
  State<bottom_bar> createState() => _bottom_barState();
}

int currentTap=0;

class _bottom_barState extends State<bottom_bar> {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 60,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 40,
                      onPressed: (){
                        setState((){
                          currentTap=0;
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>map_page())
                          );
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
                              color: currentTap==0 ?  Colors.yellow : Colors.transparent,
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
                    MaterialButton(
                      minWidth: 40,
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        setState((){
                          currentTap=1;
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> map_page())
                          );
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: currentTap==1?  Colors.yellow : Colors.transparent,
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
                  ],
                ),
                Row(
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        setState((){
                          currentTap=2;
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>shop_page())
                          );
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: currentTap==2?  Colors.yellow : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: currentTap==2 ? Colors.black : Colors.grey,
                            ),
                            Text(
                              '상점',
                              style: TextStyle(color: currentTap==2 ? Colors.black : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ), //유저
                    MaterialButton(
                      minWidth: 40,
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        setState((){
                          currentTap=3;
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>map_page())
                          );
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
                              color: currentTap==3 ?  Colors.yellow : Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: currentTap==3 ? Colors.black : Colors.grey,
                                ),
                                Text(
                                  '설정',
                                  style: TextStyle(color: currentTap==3 ? Colors.black : Colors.grey),
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
    );
  }
}