## 名称

### ZaiCoCCo(読み：ざいこっこ)

## 概要

買い物の際に、店舗に着いて棚を見ると在庫切れだった、なんて経験があると思います。店舗の在庫の情報が、店舗に着くまでわからないことは不便なことだと考えます。忙しい現代人の時間を無駄にしないために、店舗の在庫の有無をどこからでも確認できるようするために、在庫情報の確認、管理のできるアプリケーションを作成しました。

## app URL

```
www.zaicocco.com
```

[リンクはこちら](http://www.zaicocco.com)
簡単ログインがあります。是非ご利用ください。

## Basic 認証

```
ID:admin pass:9876
```

## 使用技術

- Ruby 2.5.7
- Ruby on Rails 6.0.3.4
- MySQL 14.14
- Nginx 1.18.0
- unicorn 5.4.1
- AWS
  - EC2
  - S3
  - Route53
- Capistrano3
- RSpec

## 機能一覧

### 未ログイン時でも利用できる機能

- ユーザー登録、ログイン機能(devise)
- 簡単ログイン機能

### すべてのユーザーの利用できる機能

- 店舗一覧表示機能(kaminari)
- 店舗情報表示機能
- 商品名による在庫検索機能
- お気に入り登録(Ajax)
- メッセージ機能(ActionCable)

### 店舗ユーザーの利用できる機能

- 店舗の登録、更新、削除機能
- 店舗の登録時の確認ページ機能
- 店舗画像のプレビュー、登録機能(CarrierWave)
- ユーザーの作成した店舗一覧表示機能(kaminari)
- 店舗の在庫登録、一括変更、削除機能(Ajax)

## 機能一覧

- 単体テスト
- 結合テスト

## 使い方

### 在庫確認方法

1. 一般ユーザーまたは店舗ユーザーでログインしてください。(簡単ログインの使用をおすすめします。)
2. 在庫を確認したい商品をヘッダーの検索窓から検索してみましょう。（例：「大根」）
3. 検索結果をご覧ください。商品名、値段、在庫数、店舗名が表示されます。
4. 店舗名をクリックして、店舗ページに飛ぶことができます。（例：「八百屋」）
5. 店舗画像や店舗情報、在庫情報、メッセージを確認することができます。
6. メッセージを入力してみましょう。店舗ユーザーやその他のユーザーとリアルタイムチャットをすることができます。
7. 店舗一覧ページのハートのアイコンからお気に入り登録をすることができます。登録した店は「お気に入り一覧」から確認することができます。
8. 右上のユーザー名のボタンから、マイページへ飛ぶことができます。登録変更や、ユーザーの削除が行えます。（簡単ログインのユーザーは変更削除ができません。）

### 店舗出店・在庫管理方法

1. 店舗ユーザーでログインしてください。(簡単ログインの使用をおすすめします。)
2. 「店舗を作成する」を押してください。
3. 各種店舗の情報を入力してください。画像は任意です。
4. 「確認画面へ」を押し、確認画面で確認してください。
5. 「店舗登録」を押し、店舗ページにて作成した店舗ページを確認してください。
6. 店舗情報の変更は「店舗情報を変更する」から行えます。
7. 「在庫を編集する」を押してください。
8. 商品名と値段と在庫数を入力して、「追加」を押してください。
9. 在庫が追加できました。作成した商品名の横の「商品を編集する」を押してください。
10. 商品情報が編集可能になります。編集して、「編集を保存する」を押してください。
11. 編集が保存されました。編集した商品名の横の「商品を削除する」を押してください。
12. 確認に「OK」を押してください。
13. 削除ができました。 14.右上のユーザー名のボタンから、マイページへ飛ぶことができます。作成した店舗の一覧を確認することができます。

## ERD

![ERD](https://user-images.githubusercontent.com/62154444/105213599-3fe11300-5b92-11eb-8321-9578e415b9a5.png)

## 今度の計画

- Docker を用いた環境構築
- CircleCi での CI/CD 構築
- ラベル設定
- 高度な検索機能
- 店舗の地図表示
- 位置情報による在庫検索(geocoder)
- https 通信化
- 無限スクロール
