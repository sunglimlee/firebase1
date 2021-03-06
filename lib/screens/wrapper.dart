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
    final userModel = Provider.of<UserModel?>(context); // wrapper 가 생성되면 이 Provider 부분이 계속 실행된다는 뜻이잖아. 맞지?
    print(userModel?.uid != null ? userModel!.uid.toString() : " 값이 없습니다."); // print 문 베스트

    // return either Home or Authenticate widget // 여기서 연결이 되었는지 되었다면 홈으로 보낼지를 결정하는 위
    if (userModel == null) {
      return Authenticate();
    } else {
      return Home();
    }
    }
}
