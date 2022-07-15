import 'package:firebase1/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function _toggleView;
  const Register({Key? key, required Function toggleView}) : _toggleView = toggleView, super(key: key); // 보이지? 외부의 함수를 통째로 넣는것. 생성자함수, 생성자 함수 베스트

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService(); // 잘봐라. AuthService 객체안에서 이미 정적 객체를 만들고 그걸 사용하고 있다.
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.brown[100], // color 의 strength 를 설정할 수 있다. 커피의 농도, 진하기를 설정하는데 유효하다.
      appBar: AppBar(
        backgroundColor: Colors.brown[400], // 약간 더 진하게 설정한다.
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
        actions: [
          TextButton.icon( // FlatButton Alternative with Icon,
              onPressed: ()  {
                widget._toggleView(); // 이거 알고 있지? widget 을 사용해야 하는거..
              },
              icon: Icon(Icons.person),
              label: Text("Sign in"))
        ],
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
                    },
                    child: Text(
                      "Register",
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
