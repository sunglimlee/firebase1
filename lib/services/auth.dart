import 'package:firebase1/services/database.dart';
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
  /// - 성공하면 : return [UserCredential]
  /// - 실패하면 : return null // terminal 에서 에러코드 프린트 된 걸 확인가능
  ///
  /// ## 여기서 잘봐야 하는게 sign-in 하게 되어 uid 를 얻으면 내가 원하는 UserModel 객체를 넘겨주어서 계속 작업을 하는것이다.
  /// 다시말하면 연결이 정상적으로 되었다는 뜻이지.
  Future signInAnon() async { // sign in anonymous, will be asynchronous
    try {
      var result = await _auth.signInAnonymously();
      var userCredential = result; // TODO null 일때 에러 잡기
      print(userCredential.user?.email != null ? userCredential.user!.email.toString() : " 값이 없습니다.");
      return _userModelFromFirebaseUser(userCredential.user); // 여기를 보면 제대로 연결이 되었기 때문에 uid 를 가진 UserModel 객체가 넘어오는 거다. 제대로 로그인이 되었다는 거지.
    } catch (e) {
      print(e.toString());
      return null; // will return null if some errors found
    }
  }

  /// auth change user stream // 스트림을 사용하기 위한 클래스
  /// UserModel 의 값이 들어오는지 감시하겠다는거다.
  ///
  /// ## 정말 중요하다. 매번 받는 객체를 내가 원하는 객체로 즉각 변환해 주게 하는게 map 함수이다.
  /// 스트림이 이렇게 간단하나? 그래서 그랸 StreamProvider 를 사용하면 되는건가?
  ///
  /// 매번 유저가 signed-in 혹은 signed-out 을 할 때마다 여기 Stream 에서 알려주고
  ///
  /// https://flutterbyexample.com/lesson/stream-provider
  Stream<UserModel?> get user {
    return _auth.authStateChanges() // Sign in, Sing out 했는지 알려준다.
        .map((user) => _userModelFromFirebaseUser(user)); // 정말 중요하다. 매번 받는 객체를 내가 원하는 객체로 즉각 변환해 주게 하는게 map 함수이다.
  }

  /// create userModel object based on FirebaseUser
  ///
  /// 생각해보니 기존의 User 를 계속 사용하여도 될 것 같다.
  UserModel? _userModelFromFirebaseUser(User? user) { // TODO : 나중에 UserModel 과 User 를 합칠 생각을 해보자.
    return user != null ? UserModel(uid: user.uid.toString()) : null; // null 사용법
  }


  // sign in with email & password, 그래서 여기에 두개가 있구나.
  Future signInWithEmailAndPassword({required String email, required String password}) async { // 함수 생성
    try {
      var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userModelFromFirebaseUser(user); // 성공하면
    } catch(e) {
      print(e.toString());
      return null; // 실패하면 null
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword({required String email, required String password}) async { // 함수 생성
    try {
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      // create a new document for the user with the uid
      if (user != null) {
        await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
      }
      return _userModelFromFirebaseUser(user); // 성공하면
    } catch(e) {
        print(e.toString());
        return null; // 실패하면 null
    }
  }


  // sign out
  /// 리턴타입 : Future 또는 null
  Future signOut() async {
    try {
      return await _auth.signOut(); // 파이어베이스에서 제공해주는 사인아웃
    } catch(e) {
      print(e.toString());
      return null;

    }
  }
}