import 'package:flutter/material.dart';
import 'package:firebase1/model/brew.dart';

class BrewTile extends StatelessWidget {
  final BrewModel _brewModel;
  BrewTile({Key? key, required BrewModel brewModel}) : _brewModel = brewModel, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/coffee_icon.png'), // 이거 중간부분 Transparent 이다.
            radius: 25.0,
            backgroundColor: Colors.brown[_brewModel.strength],
          ),
          title: Text(_brewModel.name),
          subtitle: Text('Takes ${_brewModel.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
