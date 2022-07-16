import 'package:firebase1/model/brew.dart';
import 'package:firebase1/screens/home/brew_tile.dart';
import 'package:firebase1/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<BrewModel>?>(context);   // provider null 체크 베스트 // TODO 이부분 다시 처리하도록 해보자.
//    final brews = Provider.of<List<BrewModel>>(context) ?? [];   // provider null 체크 베스트
    if (brews != null) {
      return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) { // 각각의 아이템에 대해서 빌딩해 간다.
          return BrewTile(brewModel: brews[index]); // ListView, List 값넘기기 베스트
        },
      );
    } else {
      return const Center(child: Loading());
    }
  }
}

/*
    for (var doc in brews.docs) { // iteration 베스트
      print(doc.data());
    }

 */

/*
      brews.forEach((brew) { // forEach 베스트
        print(brew.name);
        print(brew.sugars);
        print(brew.strength);
      });

 */