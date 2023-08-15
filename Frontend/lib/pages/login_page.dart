import 'package:cosa_atm/pages/map_page.dart';
import 'package:cosa_atm/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Container(
              child: Image.asset(
                'assets/images/ATM_logo.png',
                width: 250,
              ),
            ),
            SizedBox(height: 100),
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
                  labelText: '이메일',
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
                  labelText: '비밀번호',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                obscureText: true,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Perform 회원가입 logic here
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                    ),
                    child: const Text('아이디 찾기',
                        style: TextStyle(color: Colors.black)),
                  ),
                  Text('|', style: TextStyle(color: Colors.black)),
                  OutlinedButton(
                    onPressed: () {
                      // Perform 회원가입 logic here
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                    ),
                    child: const Text('비밀번호 찾기',
                        style: TextStyle(color: Colors.black)),
                  ),
                  Text('|', style: TextStyle(color: Colors.black)),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                    ),
                    child: const Text('회원가입',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: const Color(0xffffCD4A),
        child: InkWell(
          onTap: () {
            // Perform login logic here
            _login();
            print('Email: ${emailController.text}');
            print('Password: ${passwordController.text}');
          },
          child: const SizedBox(
            height: 70,
            width: double.infinity,
            child: Center(
              child: Text(
                '로그인하기',
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

  _login() async {
    // Firebase 사용자 인증, 사용자 등록
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //추후 testPage를 우리 앱의 메인 페이지로 변경
      Get.offAll(() => MapPage());
    } on FirebaseAuthException catch (e) {
      //print(e);
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.yellow,
        ),
      );
    }
  }
}
