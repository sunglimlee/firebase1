import 'package:firebase1/model/user.dart';
import 'package:firebase1/services/database.dart';
import 'package:firebase1/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase1/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4']; // list initialization

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    // Provider 에서 제공한 userModel 을 받아서 그걸로 DatabaseService 를 이용해서 값을 받는다.
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserData>( // 이걸 사용한 이유가 있다. 왜냐면 다른 사용자가 값을 변경할 수 도 있거든...
        stream: DatabaseService(uid: user.uid).userData,
        // provider<UserModel> 에서 제공하는 user 를 가지고 stream 을 userData 를 stream 으로 선택하였다. 기억해라. userData 는 get 함수이다.
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 데이터가 존재하면 스트림 베스트
            UserData userData = snapshot.data!;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    // 여기에서 TextFormField 가 들어가는구나.
                    decoration: textInputDecoration.copyWith(labelText: "Name"),
                    validator: (val) => (val != null && val.isEmpty)
                        ? 'Please enter a name'
                        : null, // validation 베스트
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // dropdown
                  DropdownButtonFormField(
                    decoration:
                        textInputDecoration.copyWith(labelText: "sugar"),
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                          value: sugar, child: Text('$sugar sugars'));
                    }).toList(),
                    onChanged: (String? value) =>
                        setState(() => _currentSugars = value),
                  ),
                  //slider
                  Slider(
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.toInt()),
                    value: _currentStrength?.toDouble() ??
                        userData.strength.toDouble(),
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                  ),
                  ElevatedButton(
                    // FireStore 에 데이터를 저장한다.
                    // RaisedButton 대용
                    style: ElevatedButton.styleFrom(primary: Colors.pink[400]),
                    onPressed: () async {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars, // null 입력 해결 베스트
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength
                          );
                        }
                        print(_currentName);
                        print(_currentSugars);
                        print(_currentStrength);
                        Navigator.pop(context); // BottomSheet 이제 없어진다.
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
