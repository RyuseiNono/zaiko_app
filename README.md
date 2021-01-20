## 名称

### ZaiCoCCo(読み：ざいこっこ)

## 概要

Web ページ上で、実店舗の在庫の有無を確認できるアプリケーション

## app URL

```
www.zaicocco.com
```

簡単ログインがあります。是非ご利用ください。

## Basic 認証

```
ID:admin　pass:9876
```

## 機能一覧

- ユーザー登録、ログイン機能(devise)
- 簡単ログイン機能

### すべてのユーザーの利用できる機能

- 店舗一覧表示機能(kaminari)
- 店舗情報表示機能
- 商品名による在庫検索機能
- お気に入り登録(Ajax)
- メッセージ機能(Actioncable)

### 店舗ユーザーの利用できる機能

- 店舗の登録、更新、削除機能
- 店舗の登録時の確認ページ機能
- 店舗画像のプレビュー、登録機能(carrierwave)
- ユーザーの作成した店舗一覧表示機能(kaminari)
- 店舗の在庫登録、一括変更、削除機能(Ajax)

## 使用技術

- Ruby 2.5.7
- Ruby on Rails 6.0.3.4
- MySQL 14.14
- Nginx 1.18.0
- unicorn 5.4.1
- AWS
  - VPC
  - EC2
  - S3
  - Route53
- Capistrano3
- RSpec

## 今度の計画

- ラベル設定
- 高度な検索機能
- 店舗の地図表示
- 位置情報による在庫検索(geocoder)
- https 通信化
- Docker を用いた環境構築
- CircleCi での CI/CD 構築
