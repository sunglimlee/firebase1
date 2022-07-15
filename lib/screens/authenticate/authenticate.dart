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

  bool showSignIn = true; // SignIn 이냐? Register 냐? 정하는 부분

  /// ## 네비게이션이 필요없이 화면이 바뀌도록 해주는 트릭인데.. navigation trick, 네비게이션 트릭
  ///
  /// athenticate 에서 showSignIn 에 따라 SignIn 이나 Register 로 가느냐를 결정하는데 이 것을 toggleView 라는 함수를 이용해서 setState 로 바꾸어준다.
  ///
  /// 그리고 나서는 해당 함수 자체를 SignIn 과 Register 로 넘겨주고 그안에서 버턴을 눌러주면(토글함수실행이 되므로) setState 이므로 플러터가 화면을 다시 그리게 되고 바뀐 화면이 적용되게 된다.
  void toggleView() {
    setState(() {
      //print(showSignIn);
      showSignIn = !showSignIn;}); // 이렇게 토글을 해준다. 네비게이션 트릭, 느낌표 잘봐라... 이런 실수를....
  }

  @override
  Widget build(BuildContext context) {
    // 진짜 파이어베이스를 연결하고 있는거야? 너무 흥분된다.
    if (showSignIn) {
      return SignIn(toggleView: toggleView); // 함수 넘겨주는 것 잘 보자.
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
