import 'package:firebase1/screens/authenticate/authenticate.dart';
import 'package:firebase1/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return either Home or Authenticate widget // TODO
    return Authenticate(); }
}
