import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// loading 화면을 만드는것도 위젯을 사용하는구나.
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: const Center(
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}