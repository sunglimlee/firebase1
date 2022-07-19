# firebase1
#################################################################################################
Background image 는 어떻게 넣을까? 매번 새로운 화면이 그려지는데 아마도 MatrialApp 이러곳에서 바꾸지 않을까???
* 꼭 기억하자. assets 디렉토리는 맨 바깥으로 보낸다. lib 안에 아니다. 기억해라.
당연히 Home 에서 바꾸어야지..
    body: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    fit : BoxFit.cover,
    image: AssetImage('assets/coffee_bg.png'),
    )
    ),
    child: BrewList()),

#################################################################################################
FireStore 에 데이터를 저장 : settings_form.dart 에 ElevatedButton 부분
* 기존에 걸 그대로 사용했음..
  Future updateUserData(String sugars, String name, int strength) async {
  return await brewCollection.doc(_uid).set({
  'sugars' : sugars, // 여기 보이지? key 와 value 가 들어간다. type 은 어떻게 정할까?
  'name' : name,
  'strength' : strength,
  });
  }

*                   ElevatedButton(
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
                        Navigator.pop(context); // BottomSheet 이제 없어진다.
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

#################################################################################################
그러면 StreamBuilder 부분은 결국 StreamProvider 과 기능이 같은 것인가????????????? 같은 기능을 하지만 같은 위젯에서 값을 바로 받을 때 StreamBuilder 를 사용한다. 왜냐면 계속 build 를 하기 때문에
결국 App 이 커지면 StreamProvider 를 사용해야 하는구나.
https://stackoverflow.com/questions/59737116/flutter-with-firestore-streambuilder-vs-streamprovider
내가 이해하지 못했던 부분. 새로운 Stream 인데 Document 와 관련된거 같은데.. 현재 BottomSheet 와 list item 을 선택했을 때의 관계를 만드는 것 같다.
* uid 와 document 와 관련 user data model 사용하기 위해서 userData class 를 만들었고
* 그걸 사용하기 위해서 database.dart 에서 Stream<UserData> 를 받기 위한 함수를 만들었다. 알지? UserData 로 변환하는 함수도 거기에 같이 있다는 걸..

* SettingsForm class 에서 작업하는데 이번에는 StreamBuilder 를 사용할것이다.
* setting_form.dart 의 Form() 을 StreamBuilder 로 감싼다.

  return StreamBuilder<UserData>(
  stream: DatabaseService(uid: user.uid).userData, // provider<UserModel> 에서 제공하는 user 를 가지고 stream 을 userData 를 stream 으로 선택하였다. 기억해라. userData 는 get 함수이다.
  builder:(context, snapshot) { return Form(
  key: _formKey,
  child: Column(
  children: [
  Text(
  'Update your brew settings.',

* 여기부분은 이제 if 문으로 작업을 하니깐 settings_form.dart 전체를 다시 보도록 하자. 

#################################################################################################
BottomSheet 사용 - 함수안에(context 있는함수) 함수를 또 정의하는게 가능하다. 와우
#################################################################################################
항상 사용자 정의 위젯을 사용하려고 시도해보자.. 여기서는 지금 BrewTile 이라는 ListTile 을 만들고 있다.

#################################################################################################
BrewModel 을 만들어서 사용자정의 데이터 클래스를 만들어준다. 
* 원칙 1 : 사용자 클랙스 만들기
* 원칙 2 : 데이터를 연결하는 dart 파일에서 변환 함수를 만들기 (database.dart/_brewListFromSnapshot(QuerySnapshot snapshot))
* 원칙 3 : map 함수를 사용하여 변환
  List<BrewModel> _brewListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
  Map<String, dynamic> d = doc.data()! as Map<String, dynamic>; // 각 doc 값이 Map 으로 1:1로 맵핑이 되잖아. 그래서 이게 가능한거지.
  return BrewModel(
  name: d['name'] ?? '', // null 이면
  sugars: d['sugars'] ?? '0',
  strength: d['strength'] ?? 0
  );
  }).toList();
}
* 이제 해당 데이터를 brew_list.dart 에서 사용한다. 어떻게? 자동으로 넘어오는 provider 를 사용해서.. ㅋㅋㅋ
#################################################################################################
* 데이터를 화면에 보여줄텐데 데이터가 변경이되어도 바로바로 보여줄 수 있도록 Stream 을 사용한다.
* SnapShot 을 받을건데 그안에 모든 Document 들이 들어있다.
* database.dart 에 stream 함수를 만든다.
* 이제 home.dart 에서 해당 Stream 을 사용할 거다. 
      return StreamProvider<List<BrewModel>?>.value( // initialData 가 null 이 되기 위해서는 List<BrewModel>? 이렇게 되어야 한다.
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
  이렇게 하면 이제 하위의 모든 위젯에서 자동으로 QuerySnapshot 을 갱신할 수 있게된다. 왜냐면 후손들이 듣고 있거덩.. ^^
* 화면에 보여줄 brew_list.dart 를 만들고 그안에서 데이터를 받는걸 테스트 한다.
  @override
  Widget build(BuildContext context) {

  final brews = Provider.of<QuerySnapshot>(context);
  print(brews.docs);
  for (var doc in brews.docs) {
  print(doc.data());
  }
  return Container();
  }

#################################################################################################
User Data for FireStore
* name, sugars, strength
* 해당 유저가 해당 FireStore 를 어떻게 연결할래? Firebase uid 를 생성한다. 그 uid 도 등록한다.
* DatabaseService class 에서 함수들을 만들어 준다.
* (여기서 중요한것은 레코드 하나에 User 정보 다 넣는다. )
* 'sugars' : sugars, // 여기 보이지? key 와 value 가 들어간다. type 은 어떻게 정할까?
* registerWithEmailAndPassword 혹은 sign - in 을 했을 때 uid 를 이용해서 document 를 선택해준다.
  (which document belongs to which user by uid) <---- 이거 너무 중요하다.
  // create a new document for the user with the uid
  if (user != null) {
  await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
  }
* 
#################################################################################################
FireStore
* go to Console and choose FireStore and create FireStore
* 나중에 test mode 에 대해서 수정해야겠지.
* 
#################################################################################################
Loading Widget
* flutter_spinkit 4.0.0
* 새로운 Loading 위젯을 만든다. 
* bool loading = false; // sign in page 에 local variable 로 넣어준다.
* 로컬 validation 이 끝나고 나면 loading = true 로 만들고 에러가 나면 loading = false 로 해주고
* 이제 맨 상단에서 loading 이 true 이면 Loading() false 이면 Scaffold 실행
* 이게 왜 가능하냐면 후속으로 Firebase validation 이 이루어지고 나면 거기서 다시 Home 화면으로 가게되는 이벤트가 실행되기때문이지. 아주 좋아..!
#################################################################################################
TextFormField Decoration 할 떼
* decoration: textInputDecoration.copyWith(labelText: 'Password'),
* const textInputDecoration(labelText : "email", .....) 이렇게 만들어놓으면 반복할 필요가 없다.
#################################################################################################
Stream 과 StreamProvider 그리고 Provider.of<>(context) 사용법
* Stream 은 정해놓은 타입을 계속적으로 감시하겠다는 것이고 authStateChanges() 함수와 map() 함수를 통해서 나의 UserModel 을 지속적으로 받겠다는 의미
* Stream Provider 는 Stream 을 연결해놓고 이제부터 계속 감시하다가 만약 데이터가 달라지면 각 자식들에게 통보
* Provider.of<>(context) 사용하는 애들이 다시금 데이터를 받아서 그데이터를 이용해 새롭게 rebuild 하게 된다.
#################################################################################################
Sign in & Register toggle 과 setState 로 왔다갔다 하기
* showSignIn = true 불리언 값을 만든다.
* showSignIn 에 따라 네비게이션 하게 하고
* toggleView 함수를 만들고 setState(()=> showSignIn = !showSignIn) 해주고
* SignIn() 과 Register() 에 함수를 넘겨준다. SignIn(toggleView : toggleView);
* SignIn({Function toggleView}) : _toggleView = toggleView;
* final Function toggleView;
#################################################################################################
Validate 하고 값을 Firebase 에서 Validate 하고 결과값으로 데이터를 전달하는 방법
* final _formKey = GlobalKey<FormState>(); // Form 을 구별하기 위해 사용한다.
* String email = '';
  String password = '';
  String error = '';
* Form(key : _formKey,)
* TextFormField(validator : (val) =>)); // null 값 체크, isEmpty, length
* TextFormField(onChanged : (val) => setState(() => email = val);
* _auth.registerWithEmailAndPassword() 함수 작성
* ElevatedButton(onPressed : async {                     
   if (_formKey.currentState != null) {
       // null 조건문
       if (_formKey.currentState!.validate()) {
       // 폼키를 가지고 현재 들어온 값들을 가지고 validation 을 진행한다.
          dynamic result = await _auth.registerWithEmailAndPassword(email: email, password: password);
          if (result == null) {
             // error 이라면
             setState(() => error = 'please supply a valid email');
             print(error);
          }
       }
   }
 })
* 내가 validate 를 하고 Firebase 가 validate 를 한번 더 하고 결과값에 따라 반응
* 이후에는 Stream 을 계속 감시하고 있기 때문에 authStateChange() 함수로 새로운 유저값의 UserModel 을 만들고 Listening 하고 있는 자식들을 변경하게 된다.
#################################################################################################
FireStore 에서 Collection 과 Document 를 만들었을 때 데이터를 구분하는 방법
* Collection : 레코드를 가지고 있는 큰 주제 즉 테이블과 같은 개념으로 생각해도 되는거지. 이 개념은 user 로 나눈게 나을 것 같다.
* 실제로는 : Brews 라고 Collection 을 만들고 있다. 어떤 목적을 기준으로 Collection 을 만드는 것 같다.
* Document : key, value 값으로 나누어져 있으니깐. 그걸 나누는데 커피의 농도, 설탕의 숫자, 여러가지 user 가 가지질 수 있는 그런 것들을 다 
  key, value 값으로 나누어서 넣어줄 수 있다는 거지.
* 여기서 알아야 할 것은 Firebase 가 유니크한 ID 를 생성해 준다는 거다. Document 별로 맞지? 여기서는 User UID 를 Document 의 ID 로 사용하였다. 
#################################################################################################
* pubspec.yaml 파일에
* firebase_auth 설치 
* cloud_firestore 설치
#################################################################################################
// firebase install 파이어베이스 설치
//   : 초기 설치방법
// https://firebase.google.com/docs/flutter/setup?platform=web : google official documents
// https://pub.dev/packages/firebase_core/install : firebase core package 설치해야함
// 그리고 마지막 투두:4 부분 해줘야 함 : 초기 설치방법 4:03 에 있는 부분
#################################################################################################

