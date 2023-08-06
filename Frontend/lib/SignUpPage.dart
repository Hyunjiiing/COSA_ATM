import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:core';
import 'package:get/get_core/src/get_main.dart';

import 'loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.yellow,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String passwordStrength = '';
  String errMsg = "";

  bool isPasswordValid(String password) {
    final RegExp passwordFormat = RegExp(
        r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#*$._~%^&])(?=.*?[A-Za-z]).{8,16}$');
    return passwordFormat.hasMatch(password);
  }

  bool checkPasswordsMatch() {
    return passwordController.text == confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); //뒤로가기
            },
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            Text(
              "회원가입",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            Text(
              "원할한 앱 사용을 위해 회원가입이 필요해요.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 100),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffCD4A)),
                      ),
                      labelText: '이름 입력',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffCD4A)),
                      ),
                      labelText: '이메일 입력',
                      labelStyle: TextStyle(color: Colors.grey),
                      hintText: 'example@gmail.com',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffCD4A)),
                      ),
                      labelText: '비밀번호 입력(영문+숫자+특수문자 총 8~15문자)',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        errMsg = "";
                        passwordStrength = isPasswordValid(value) ? '강함' : '약함';
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '비밀번호 강도: $passwordStrength',
                    style: TextStyle(
                        color: isPasswordValid(passwordController.text)
                            ? Colors.green
                            : Colors.red),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffCD4A)),
                      ),
                      labelText: '비밀번호 확인',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        errMsg = "";
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    errMsg,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ])),
      bottomNavigationBar: Material(
        color: const Color(0xffffCD4A),
        child: InkWell(
          onTap: () {
            // Perform signup logic here
            if (!checkPasswordsMatch()) {
              setState(() {
                errMsg = "비밀번호 불일치";
              });
            } else if (isPasswordValid(passwordController.text)) {
              // Perform sign up logic here
              _join();
              print('Username: ${usernameController.text}');
              print('Email: ${emailController.text}');
              print('Password: ${passwordController.text}');
            } else {
              print('Invalid password');
            }
          },
          child: const SizedBox(
            height: 70,
            width: double.infinity,
            child: Center(
              child: Text(
                '회원가입하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _join() async {
    // Firebase 사용자 인증, 사용자 등록
    try {
      final User? user =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )).user;

      Get.offAll(() => LoginPage());
      //추후 testPage를 우리 앱의 메인 페이지로 변경
      /*CollectionReference userCollection = FirebaseFirestore.instance.collection('user');
      userCollection.doc(user!.uid).set({
        'name': _nameController.text,
        'profileUrl': "",
      }).then((value) async {
        await FirebaseAuth.instance.signOut();
        Get.offAll(()=>const LoginPage());
      }).catchError((e) async {
        logger.e(e);

        await FirebaseAuth.instance.currentUser!.delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e),
            backgroundColor: Colors.deepOrange,
          ),
        );
      });*/
    } on FirebaseAuthException catch (e) {
      print(e);
      String message = '';

      if (e.code == 'user-not-found') {
        message = '사용자가 존재하지 않습니다.';
      } else if (e.code == 'wrong-password') {
        message = '비밀번호를 확인하세요';
      } else if (e.code == 'invalid-email') {
        message = '이메일을 확인하세요.';
      }

      /*final snackBar = SnackBar(
          content: Text(message),
          backgroundColor: Colors.deepOrange,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      */
    }
  }
}
