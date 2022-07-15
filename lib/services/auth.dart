import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase1/model/user.dart';

/// Google Authentication Service 를 사용하기 위한 파일이다. 디렉토리로 나누어 놨고 여기가 auth 를 연결하는 service 의 통로인 셈이다.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // 맨처응 auth 를 연결한 수 있는 정적 인스턴스를 얻어와야 한다. private 변수로 선언.


  /// sign in anonymous, will be asynchronous
  ///
  /// 먼저 구글 Authentication 에 Anonymous 사용하는 걸 등록해야 함
  /// 시간을 요하는 작업이므로 Future 가 리턴될텐데
  ///
  /// - 성공하면 : return [UserCredentical]
  /// - 실패하면 : return null // terminal 에서 에러코드 프린트 된 걸 확인가능
  ///
  /// ## 여기서 잘봐야 하는게 sign-in 하게 되어 uid 를 얻으면 내가 원하는 UserModel 객체를 넘겨주어서 계속 작업을 하는것이다.
  /// 다시말하면 연결이 정상적으로 되었다는 뜻이지.
  Future signInAnon() async { // sign in anonymous, will be asynchronous
    try {
      var result = await _auth.signInAnonymously();
      var userCredential = result; // TODO null 일때 에러 잡기
      print(userCredential.toString());
      return _userFromFirebaseUser(userCredential.user); // 여기를 보면 제대로 연결이 되었기 때문에 uid 를 가진 UserModel 객체가 넘어오는 거다. 제대로 로그인이 되었다는 거지.
    } catch (e) {
      print(e.toString());
      return null; // will return null if some errors found
    }
  }

  /// create userModel object based on FirebaseUser
  ///
  /// 생각해보니 기존의 User 를 계속 사용하여도 될 것 같다.
  UserModel? _userFromFirebaseUser(User? user) { // TODO : 나중에 UserModel 과 User 를 합칠 생각을 해보자.
    return user != null ? UserModel(uid: user.uid.toString()) : null; // null 사용법
  }


  // sign in with email & password

  // register with email & password

  // sign out
}