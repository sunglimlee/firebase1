import 'package:firebase1/model/brew.dart';
import 'package:firebase1/screens/home/brew_list.dart';
import 'package:firebase1/screens/home/settings_form.dart';
import 'package:firebase1/services/auth.dart';
import 'package:firebase1/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 인증이 끝난뒤의 홈 네비게이션 위젯
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // 잘봐라.. 함수 안에 또 함수를 넣어놨다. 이게 가능해??????
    void _showSettingPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
          child: SettingsForm(),
        );
      } );
    }


    return StreamProvider<List<BrewModel>?>.value( // initialData 가 null 이 되기 위해서는 QuerySnapshot? 이렇게 되어야 한다.
      value: DatabaseService().brews,
      initialData: null,
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
                label: Text("logout")),
            TextButton.icon(onPressed: () => _showSettingPanel(), icon: Icon(Icons.settings), label: Text('settings')),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit : BoxFit.contain, // TODO 반복해서 이미지가 나오는거 연구하자.
              )
            ),
            child: BrewList()),
      ),
    );
  }

}
