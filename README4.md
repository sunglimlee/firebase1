Firebase to Flutterweb

https://www.youtube.com/watch?v=dIK5MNvaxeY&t=39s
(FlutterFire installation 을 사용할거다.)

여기에서 node.js 를 사용할거다. 

download LTS version

npm install -g fireabase-tools

firebase --version

firebase login

Allow Firebase to collect CLI usage and error reporting information? (Y/n) Y

(signing permission CLI 해주고)

dart pub global activate flutterfire_cli

(warning message : $HOME/.pub-cache/bin 이런 메세지.)

export PATH="$PATH":"$HOME/.pub-cache/bin"

(혹은 c:\users\base8\AppData\Local\Pub\Cache\bin 이부분을 복사해서 Windows Environment 부분에 넣어주면 된다.)

------------------------------ 여기까지 다 설치 완료

flutterfire configure 

(Enter a project id for your new Firebase project )  random-project-lsl

플랫폼 선택

ios 디렉토리에서 서브메뉴 Open in Xcode 선택하고 Bundle Identifier 거 복사
android 디렉토리에서 AndroidMenifest.xml 에서 package 에서 com.example.headache_wave_buttom 선택

그래서 bundled id 에다 com.example.headache_wave_buttom 입력

이제 Firebase console 에 들어가면 Firebase project 가 자동으로 등록되어 있다.

------------------ Android Studio 에서
(lib\firebase_options.dart) 안에서 firebase_core.dart 설치를 해준다.

(main.dart 안에서)
import 'package:firebase_core/firebase_core.dart';


void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options : DefaultFirebaseOptions.currentPlatform );

runApp(const MyApp());
}

----------------------------- 끝


Firebase to Flutterweb 두번째 방법
https://www.youtube.com/watch?v=l0cFOUJJcGQ

pubspec.yaml 에 firebase core 설치해준다.

void main() {
WidgetsFlutterBinding.ensureInitialized();
runApp(myApp());
}

class MYApp extends StatelessWidget {
    MyApp({Key? key}) : super(Key:key);
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

밑에
    home : FutureBuilder(
        future : _initializtion, 
        builder : (context, snapshot) {
            if (snapshot.hasError) {
                print("Error");
            }
            if (snapshot.connectionState == ConnectionState.done) {
                return MyHomePage(title: 'Flutter Demo');
            }
            return CircularProgressIndicator();
        },
    ), // FutureBuilder 


test 디렉토리에서 const 지우고.. 에러가 없어지네.

------------------------------------- 이제 Firebase console 로 가서
등록을 하자.
이부분은 5:00 부터 다시보자.
