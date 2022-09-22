Firebase Web Hosting

[question] firebase : File C:\Users\Nowlee\AppData\Roaming\npm\firebase.ps1 cannot be loaded because running scripts is disabled on this system.
[answer] Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass 실행


[Web Hosting]
https://www.youtube.com/watch?v=OwO0oPcCeX0
https://stackoverflow.com/questions/38486069/firebase-not-running-index-html-file

npm install -g firebase-tools

firebase login

flutter build web

firebase init hosting


[error] firebase : File C:\Users\Nowlee\AppData\Roaming\npm\firebase.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see
about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ firebase init hosting
  [answer] https://stackoverflow.com/questions/60594178/firebase-cannot-be-loading-because-running-scripts-is-disabled-on-this-system
  Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass  입력하자.

firebase init hosting


? Are you ready to proceed? Yes

? What do you want to use as your public directory? build/web
? Configure as a single-page app (rewrite all urls to /index.html)? No
? Set up automatic builds and deploys with GitHub? No
+  Wrote build/web/404.html
   ? File build/web/index.html already exists. Overwrite? No

마지막으로 firebase deploy 혹은 firebase deploy --only hosting




만약에 새로 시작하고 싶다면

Delete .firebase folder
Delete .firebaserc
Delete firebase.json

firebase init hosting

flutter build web

firebase deploy --only hosting


//////////////////////////////////////////////////////////////////////////////
Firebase benefits
automatically provisions SSL certificates
free subdomains (web.app)
connect your own domain name
create multiple sites



