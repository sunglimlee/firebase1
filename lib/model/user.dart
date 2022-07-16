class UserModel {
  final String _uid;

  UserModel({uid}) : _uid = uid;

  String get uid => _uid; // id 를 당연히 만들어야지.

}


class UserData {

  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData(this.uid, this.name, this.sugars, this.strength);
}