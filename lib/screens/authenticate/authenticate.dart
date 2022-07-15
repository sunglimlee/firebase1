import 'package:firebase1/screens/authenticate/register.dart';
import 'package:firebase1/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

/// ## Wrapper Class 에서 큰 두갈래로 나뉘는 것중 [인증(Authentication) ] 과 [홈(Home) ] 둘중에 인증에 해당하는 네비게이션 위젯
///
/// 왜 이렇게 하나를 더 두었냐고? sign-in 과 register 를 구분해서 받기 위해서
///
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}
class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Register(), // 진짜 파이어베이스를 연결하고 있는거야? 너무 흥분된다.
    );
  }
}
