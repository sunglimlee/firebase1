import 'package:firebase1/services/auth.dart';
import 'package:firebase1/shared/constants.dart';
import 'package:firebase1/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function _toggleView;

  const Register({Key? key, required Function toggleView})
      : _toggleView = toggleView,
        super(key: key); // 보이지? 외부의 함수를 통째로 넣는것. 생성자함수, 생성자 함수 베스트

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth =
      AuthService(); // 잘봐라. AuthService 객체안에서 이미 정적 객체를 만들고 그걸 사용하고 있다.
  final _formKey = GlobalKey<
      FormState>(); // 이메일과 패스워드를 이용해서 Firebase 에 Authentication 을 하기 위해 꼭 필요한 글로벌 키이다. // Form 을 구별하기 위해 사용한다.
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      // color 의 strength 를 설정할 수 있다. 커피의 농도, 진하기를 설정하는데 유효하다.
      appBar: AppBar(
        backgroundColor: Colors.brown[400], // 약간 더 진하게 설정한다.
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
        actions: [
          TextButton.icon(
              // FlatButton Alternative with Icon,
              onPressed: () {
                widget._toggleView(); // 이거 알고 있지? widget 을 사용해야 하는거..
              },
              icon: Icon(Icons.person),
              label: Text("Sign in"))
        ],
      ),
      body: Center(
        child: Container(
            alignment: Alignment.center,
            width: 400,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              // 위에서 만든 글로벌 키를 여기에다가 등록해주어야 한다. // 이걸로 validation 을 할 수 있다.
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration,
                    // 값을 변경할 때마다 해당 함수가 작동한다.
                    // [question] The property 'isEmpty" can't be unconditionally accessed because the receiver can be 'null'
                    // [answer] https://stackoverflow.com/questions/68141719/the-property-isempty-cant-be-unconditionally-accessed-because-the-receiver-ca
                    validator: (val) {
                      // 비어 있으면
                      if (val != null && val.isEmpty) {
                        return 'Enter an email.';
                      } else {
                        return null;
                      }
                    }, // 여기서 값을 평가한다.
                    onChanged: (val) {
                      // [question] The declaration 'setState' isn't referenced.
                      // [answer] 괄호로 감싸준다.
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) {
                      if (val != null && val.length < 6) {
                        return 'Enter a password 6+ chars long';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.pink),
                    onPressed: () async {
                      // [question] The method 'validate' can't be unconditionally invoked because the receiver can be 'null'.
                      // [answer] https://stackoverflow.com/questions/69547879/dart-the-method-validate-cant-be-unconditionally-invoked-because-the-receiver
                      // 기억하자.. 로그인이 성공하면 Stream 을 이용해서 Home 으로 가도록 한다는걸..
                      if (_formKey.currentState != null) {
                        // null 조건문
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          // 폼키를 가지고 현재 들어온 값들을 가지고 validation 을 진행한다.
                          dynamic result = await _auth.registerWithEmailAndPassword(email: email, password: password);
                          if (result == null) {
                            // error 이라면
                            setState(() {
                              error = 'Please supply a valid email address';
                              loading = false;
                              print(error);
                            });
                          }
                        }
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 12.0,),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
