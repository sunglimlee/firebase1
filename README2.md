1. setState 로 화면을 변경해야한다면 Build 함수를 실행한다. 단 해당 위젯의 Build 만 실행된다. 
2. Firebase 연결에 대해서 확실하게 숙지한다. 
3. webHosting 에 대해서 확실하게 숙지한다.
4. Firestore 의 Collection 과 Document 에 대한 이해.
   - 실제로는 : Brews 라고 Collection 을 만들고 있다. 어떤 목적을 기준으로 Collection 을 만드는 것 같다.
   - Document : key, value 값으로 나누어져 있으니깐. 그걸 나누는데 커피의 농도, 설탕의 숫자, 여러가지 user 가 가지질 수 있는 그런 것들을 다 key, value 값으로 나누어서 넣어줄 수 있다는 거지.
5. 화면 구성도의 전체적인 구조를 이해해야 한다. 왜 wrapper class 를 만들었고 각각의 하위에 대표 Widget 을 딸로 만들고 있는지
    - 화면의 Navigation 을 위해서지. *** 위젯 트리 *** 상하 관계 기억하자.
6. uid 값에 따른 Sign-in 과 Home 
    - 로그인 uid 의 존재 유무로 Sign-in 과 Home 으로 Navigation 가능토록 한다. 
    - 존재하는 uid 로 추후 List 를 만들 수도 있고, Settings 메뉴에서 갱신하는데에도 사용할 수 있다.
7. UID 의 값을 Document 의 ID 로 사용하게 하여서 데이터를 연결한다. 
   - 그게 아니라면 Document 안에 UID 를 넣어주는 방법도 있다. 그러면 검색을 해야한다. 
8. Sign-in 과 Registration 을 setState 와 toggle 함수로 구분
    - 한개의 화면에서 계속 위젯을 바꿔가며 데이터를 불러들일 수 있고.. 탭을 사용하는것도 고려해 볼 수 있다. 
    - setState 가 실행되면 거기에 해당하는 데이터의 변경에 따라 그 데이터를 가지고 있는 곳에서 새로운 화면 Refresh 가 일어나게 된다.
9. Validation 과 Firebase Validation 사용하는 방법 
   - Global Key 사용.
10. 변경되는 데이터를 자동으로 바꾸어주는 StreamBuilder
     - 계속 들어오는 데이터를 감시하고 있다가 데이터가 변경되면 비로서 해당 provider 의 값을 변경하는데
     - Build 의 snapshot 을 통해 조건문이 가능하다는 것.. 좀 더 세부적으로 쉽게 할 수 있지만 해당 위젯에서 만들고 그걸 사용해야 한다.
     - 어떤 데이터의 변경을 보고자 하는지 정의 해야 한다. 데이터의 값일까? 
11. BottomSheet 에 uid 에 해당하는 데이터를 보여주는 기능
     - 해당 uid 의 값을 받아서 그 데이터를 해당 위젯의 값에다가 뿌려주는데 어떤 방식으로 뿌려주는지 봐야한다. 
     - 기억나지? 함수 안에 함수 가능.. 아니면 해당 클래스에서 함수 만들고 그 함수 호출할 때 context 넘겨주던지..
13. Firebase 에 대한 정적 연결과 해당 인스턴스를 매번 구해오는 방법
     - 한번의 연결로 계속 데이터를 사용하므로 인스턴스를 어떻게 가져오는지를 확인해야 한다. (객체 생성이 내부에서 만들어져 있으면 그걸 불러서 바로 쓰는게 좋을 것 같음.)