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
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // text field state
    // 항상 이런 local variable 을 이용해서 저장하는걸 보도록 하자.

    return Scaffold(
      backgroundColor: Colors.brown[100], // color 의 strength 를 설정할 수 있다. 커피의 농도, 진하기를 설정하는데 유효하다.
      appBar: AppBar(
        backgroundColor: Colors.brown[400], // 약간 더 진하게 설정한다.
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center ,
          width: 400,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.0,),
                TextFormField( // 값을 변경할 때마다 해당 함수가 작동한다.
                  onChanged: (val) {
                    // [question] The declaration 'setState' isn't referenced.
                    // [answer] 괄호로 감싸준다.
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  obscureText: true,
                ),
                SizedBox(height: 20.0,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.pink),
                    onPressed: () async {
                      print(email);
                      print(password);
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
