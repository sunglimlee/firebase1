import 'package:firebase1/services/auth.dart';
import 'package:flutter/material.dart';

/// 인증이 끝난뒤의 홈 네비게이션 위젯
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            // IconButton 이거 사용하는게 베스트
            TextButton.icon( // FlatButton Alternative with Icon,
                onPressed: () async {
                  await _auth.signOut(); // 리턴값이 중요하지 않나? Future 이나 null 이 리턴이 되는데
                },
                icon: Icon(Icons.person),
                label: Text("logout"))
          ],
        ),
      ),
    );
  }
}
