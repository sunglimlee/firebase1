import 'package:flutter/material.dart';

/// 이게 뭘 의미하는지 봐라. 변수이지만 변하지 않도록 const 로 정했고 그 변수를 InputDecoration 객체를 만드는데 그 객체의 값들을 넣어준거다.
/// 더 재밌는 사실은 이 값을 다시 with 를 이용해서 값을 바꿀 수 있다는 사실이다. 왜냐하면 const 는 현재 객체의 주소를 가리킬 뿐이거든.
/// 그래서 이렇게 내가 원하는 사용자 정의 객체를 쉽게 만들고 수정도 할 수 있게 되는 거다.
const textInputDecoration = InputDecoration(
    hintText: 'Email',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    ));
