import 'package:cosa_atm/map_page.dart';
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
                                Icon(
                                  Icons.home,
                                  color: currentTap==0 ? Colors.white : Colors.grey,
                                ),
                                Text(
                                  '홈',
                                  style: TextStyle(color: currentTap==0 ? Colors.white : Colors.grey),
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
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: currentTap==1 ? Colors.white : Colors.grey,
                            ),
                            Text(
                              '쇼핑',
                              style: TextStyle(color: currentTap==1 ? Colors.white : Colors.grey),
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
                              MaterialPageRoute(builder: (context)=>map_page())
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
                              Icons.house_outlined,
                              color: currentTap==2 ? Colors.white : Colors.grey,
                            ),
                            Text(
                              '집',
                              style: TextStyle(color: currentTap==2 ? Colors.white : Colors.grey),
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
                                  color: currentTap==3 ? Colors.white : Colors.grey,
                                ),
                                Text(
                                  '설정',
                                  style: TextStyle(color: currentTap==3 ? Colors.white : Colors.grey),
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