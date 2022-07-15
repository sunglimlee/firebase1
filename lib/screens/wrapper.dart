import 'package:firebase1/model/user.dart';
import 'package:firebase1/screens/authenticate/authenticate.dart';
import 'package:firebase1/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 어디로 보낼지를 정해주는 최상단의 위젯
/// Steams : 실제 A 에서 B 로 가는 스트림,
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel?>(context);
    print(userModel);
    // return either Home or Authenticate widget // 여기서 연결이 되었는지 되었다면 홈으로 보낼지를 결정하는 위젯
    return Authenticate(); }
}
