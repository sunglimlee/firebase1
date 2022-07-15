import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Google Authentication Service 를 사용하기 위한 파일이다. 디렉토리로 나누어 놨고 여기가 auth 를 연결하는 service 의 통로인 셈이다.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // 맨처응 auth 를 연결한 수 있는 정적 인스턴스를 얻어와야 한다.


  /// sign in anonymous, will be asynchronous
  ///
  /// 먼저 구글 Authentication 에 Anonymous 사용하는 걸 등록해야 함
  /// 시간을 요하는 작업이므로 Future 가 리턴될텐데
  ///
  /// - 성공하면 : return [UserCredentical]
  /// - 실패하면 : return null // terminal 에서 에러코드 프린트 된 걸 확인가능
  Future signInAnon() async { // sign in anonymous, will be asynchronous
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