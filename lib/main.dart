import 'package:firebase1/firebase_options.dart';
import 'package:firebase1/model/user.dart';
import 'package:firebase1/screens/wrapper.dart';
import 'package:firebase1/services/auth.dart';
import 'package:firebase1/theme/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 여기 파이어 베이스를 연결하기 위한 초기화 작업을 해주어야 한다.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options : DefaultFirebaseOptions.currentPlatform );

  runApp(const MyApp());
}
ThemeManager _themeManager = ThemeManager(); // ThemeManager() 사용하기 위한 인스턴스 생성


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // [question] The argument type 'Stream<UserModel?>' can't be assigned to the parameter type 'Stream<UserModel>?'.
    // [answer] <UserModel?> 이렇게 바꾸자.
    return StreamProvider<UserModel?>.value(
      value: AuthService().user, // 여기 보이지? 여기서 객체를 만들어서 밑으로 보내주는다. 여기에 객체가 만들어져 있다.
      initialData: null,
      child: MaterialApp( // 여기서 StreamProvider 를 만들어준다. 그래야 밑에서 전부 접근가능하지.
        debugShowCheckedModeBanner: false,
        themeMode: _themeManager.themeMode,
        home: Wrapper() ,
      ),
    );
  }
}
