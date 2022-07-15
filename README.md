# firebase1


#################################################################################################
* FireStore 에서 Collection 과 Document 를 만들었을 때 데이터를 구분하는 방법
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

