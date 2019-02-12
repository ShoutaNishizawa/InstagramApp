
# InstagramApp

![demo](https://github.com/amaocha-first/InstagramApp/blob/media/InstagramAppDemo.gif)

TechAcademyで制作したインスタグラムのクローンアプリです。(2018/09)  
基本的には教材に従ってく作っていき、コメント投稿機能は自分で調べて追加しました。

## このアプリでできること
* FireBaseを使って、アカウント作成、ユーザー認証、ログイン・ログアウトなどができる。
* ライブラリから選択、またはカメラを起動して撮った写真を加工でき、短いキャプションとともに投稿できる。
* 投稿された写真をリアルタイムでTableViewに表示する。
* 投稿された写真に対して、いいねやコメントができる。

## 使用した技術
* FireBaseによるサーバー連携およびユーザー認証など。
* タブバーから直接写真選択画面へ遷移するために、ESTabBarというライブラリを使用。
* ロード中をユーザーに知らせるために、SVProgressHUDを使用。
* 写真加工のために、CLImageEditorを使用。

