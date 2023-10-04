import 'package:flutter/material.dart';

class share_page extends StatefulWidget {
  const share_page({Key? key}) : super(key: key);

  @override
  State<share_page> createState() => _share_pageState();
}

class _share_pageState extends State<share_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset("assets/images/share.png",fit: BoxFit.contain,),
      ),
    );
  }
}
