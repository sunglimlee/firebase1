import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Google Authentication Service 를 사용하기 위한 파일이다. 디렉토리로 나누어 놨고 여기가 auth 를 연결하는 service 의 통로인 셈이다.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // 맨처응 auth 를 연결한 수 있는 정적 인스턴스를 얻어와야 한다.


  // sign in anonymous, will be asynchronous
  Future signInAnon() async {
    try {
      var result = await _auth.signInAnonymously();
      var user = result.user;
      return user; // will return UserCredential
    } catch (e) {
      print(e.toString());
      return null; // will return null if some errors found
    }
  }


  // sign in with email & password

  // register with email & password

  // sign out
}