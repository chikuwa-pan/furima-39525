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
- has_many :purchases


### items
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| title              | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| postage_id         | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| shipping_day_id    | integer    | null: false                    |
| price              | integer    | null: false                    |

#### Association
- belongs_to :user
- has_one :purchase


### purchases
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | foreign_key: true              |
| item               | references | foreign_key: true              |

#### Association
- belongs_to :user
- belongs_to :item
- has_one :address


### addresses
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| order              | references | foreign_key: true              |
| post_number        | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| municipalities     | string     | null: false                    |
| address            | string     | null: false                    |
| building           | string     |                                |
| phone              | string     | null: false                    |

#### Association
- belongs_to :purchase


### prefecture(Active hash)
- prefecture

### category(Active hash)
- category

### condition(Active hash)
- condition

### postage(Active hash)
- postage

### shipping_day(Active hash)
- shipping_day