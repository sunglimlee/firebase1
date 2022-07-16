# firebase1

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
* 여기서 알아야 할 것은 Firebase 가 유니크한 ID 를 생성해 준다는 거다. Document 별로 맞지?
#################################################################################################
* pubspec.yaml 파일에
* firebase_auth 설치 
* cloud_firestore 설치
#################################################################################################
// firebase install 파이어베이스 설치
// https://www.youtube.com/watch?v=dIK5MNvaxeY&t=39s : 초기 설치방법
// https://firebase.google.com/docs/flutter/setup?platform=web : google official documents
// https://pub.dev/packages/firebase_core/install : firebase core package 설치해야함
// 그리고 마지막 투두:4 부분 해줘야 함 : 초기 설치방법 4:03 에 있는 부분
#################################################################################################

