import 'package:firebase1/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// ## 여기에서 sign-in 페이지를 만든다.
///
/// [StatefulWidget] 을 사용하는 이유는 setState 를 이용해서 상태값을 갱신하기 위함이다.
///
/// Provider 를 사용하는 것도 고려해보자
///
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService(); // 잘봐라. AuthService 객체안에서 이미 정적 객체를 만들고 그걸 사용하고 있다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100], // color 의 strength 를 설정할 수 있다. 커피의 농도, 진하기를 설정하는데 유효하다.
      appBar: AppBar(
        backgroundColor: Colors.brown[400], // 약간 더 진하게 설정한다.
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.brown[400]),
          ),
          child: Text('Sign in anon'),
          onPressed: () async {
            dynamic result = await _auth.signInAnon(); // 클래스안의 정적객체를 이용해서 연결을 시도한다.
            if (result == null) {
              print('error signing in');
            } else {
              print('signed in');
              print(result);
            }
          }, // 여기서 시간이 걸리는 작업이므로 비동기화 작업을 한다.
        ),
      ),
    );
  }
}
