import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/model/brew.dart';
import 'package:firebase1/model/user.dart';

class DatabaseService {

  /// 1. collection reference so that to do add docu, update docu, remove docu from a collection. 왜냐하면 collection 에 document 가 저장되어 있으니깐
  ///

  // 1. collection reference

  final String? _uid;
  DatabaseService({String? uid}) : _uid = uid;
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews'); // instance 호출때마다 매번 같은 Firebase App 이 호출된다.

  // 레코드 하나에 모두다
  // 잘봐라.. 지금 이 레코드 하나에 uid 가 연결되고 그안에 user 에 대한 값들을 모두 다 집어넣으려고 한다. 그말은 최대한 많이 정보를 넣어도 된다는 거겠지?
  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(_uid).set({
      'sugars' : sugars, // 여기 보이지? key 와 value 가 들어간다. type 은 어떻게 정할까?
      'name' : name,
      'strength' : strength,
    });
  }

  // brew list from snapshot : 이 데이터 변환을 여기서 하는 이유는? 컬렉션을 사용할 수 있으니깐.. 아니면 다른데도 또 똑같이 instance 를 등록해줘야하잖아.
  List<BrewModel> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // 각 doc 값이 Map 으로 1:1로 맵핑이 되잖아.
      Map<String, dynamic> d = doc.data()! as Map<String, dynamic>; //그래서 이게 가능한거지. Map 함수 베스트
      return BrewModel(
        name: d['name'] ?? '', // null 이면 베스트
        sugars: d['sugars'] ?? '0',
        strength: d['strength'] ?? 0
        );
    }).toList();
  }

  // get brews stream
  Stream<List<BrewModel>> get brews {
    return brewCollection.snapshots() // 이건 이 컬렉션안의 모든걸 다 받는거잖아..
      .map((snapshot) => _brewListFromSnapshot(snapshot));
  }

  // userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> d = documentSnapshot.data()! as Map<String, dynamic>; // 각 doc 값이 Map 으로 1:1로 맵핑이 되잖아. 그래서 이게 가능한거지.
    return UserData(_uid!, d['name'], d['sugars'], d['strength']);
  }
  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(_uid).snapshots() // 데이터가 바뀔때 마다 새롭게 snapshots 을 받을거다. DocumentSnapshot
      .map((documentSnapshot) => _userDataFromSnapshot(documentSnapshot));
  }
}