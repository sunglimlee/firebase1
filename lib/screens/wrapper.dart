import 'package:firebase1/screens/authenticate/authenticate.dart';
import 'package:firebase1/screens/home/home.dart';
import 'package:flutter/material.dart';

/// 어디로 보낼지를 정해주는 최상단의 위젯
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return either Home or Authenticate widget // TODO
    return Authenticate(); }
}
