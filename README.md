# Furima要件

## 概要
会員登録し、商品を出品もしくは、他ユーザーが出品した商品を購入できるアプリ。

## 機能
### ユーザー登録機能
##### 必須項目
- ニックネーム
- メールアドレス
- パスワード
- 本人確認
- 姓・名
- 姓・名フリガナ
- 生年月日

### 商品出品機能
##### 必須項目
- 商品画像
- 商品名
- 商品説明
- カテゴリー (Active hash)
- 商品の状態 (Active hash)
- 配送料の負担 (Active hash)
- 発送元の地域 (Active hash)
- 発送までの日数 (Active hash)
- 販売価格

### 商品購入機能
クレジットカード情報はPAY.JPに送信
- 購入代金の表示

##### 必須項目
- 郵便番号
- 都道府県 (Active hash)
- 市区町村
- 番地
- 建物名
- 電話番号

## テーブル設計

### users
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| nickname           | string     | null: false                    |
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false                    |
| last_name          | string     | null: false                    |
| first_name         | string     | null: false                    |
| last_name_kana     | string     | null: false                    |
| first_name_kana    | string     | null: false                    |
| date_of_birth      | date       | null: false                    |

#### Association
- has_many :items
- has_many :orders
- has_many :addresses


### items
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | foreign_key: true              |
| title              | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| postage_id         | integer    | null: false                    |
| prefectures_id     | integer    | null: false                    |
| shipping_days_id   | integer    | null: false                    |
| price              | integer    | null: false                    |

#### Association
- belongs_to :user
- has_many :purchases
- has_many :comments


### purchases
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | foreign_key: true              |
| item               | references | foreign_key: true              |

#### Association
- belongs_to :user
- belongs_to :item
- has_many :address


### addresses
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_number        | integer    | null: false                    |
| prefectures_id     | integer    | null: false                    |
| municipalities     | string     | null: false                    |
| address            | string     | null: false                    |
| building           | string     |                                |
| phone              | string     | null: false                    |

#### Association
- belongs_to :users
- belongs_to :purchases

#### Association
- belongs_to :users
- belongs_to :items

### prefectures(Active hash)
- prefectures

### category(Active hash)
- category

### condition(Active hash)
- condition

### postage(Active hash)
- postage

### sender(Active hash)
- sender

### shipping_day(Active hash)
- shipping_day