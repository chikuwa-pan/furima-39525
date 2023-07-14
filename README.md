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
|      Column             | Type    | Options     |
| ----------------------- | ------- | ----------- |
| PK | id                 | integer |             |
|    | nickname           | string  | null: false |
|    | email              | string  | null: false |
|    | pass               | string  | null: false |
|    | last_name          | string  | null: false |
|    | first_name         | string  | null: false |
|    | last_name_kana     | string  | null: false |
|    | first_name_kana    | string  | null: false |
|    | date_of_birth      | integer | null: false |

#### Association
- has_many :items
- has_many :orders
- has_many :addresses


### items
|      Column             | Type    | Options     |
| ----------------------- | ------- | ----------- |
| PK | id                 | integer |             |
| FK | user_id            | integer |             |
|    | image              | text    | null: false |
|    | title              | string  | null: false |
|    | description        | text    | null: false |
|    | category_id        | integer |             |
|    | condition_id       | integer |             |
|    | postage_id         | integer |             |
|    | sender_id          | integer |             |
|    | shipping_days_id   | integer |             |
|    | price              | integer | null: false |

#### Association
- belongs_to :users
- belongs_to :purchases
- has_many :comments


### purchases
|      Column             | Type    | Options     |
| ----------------------- | ------- | ----------- |
| PK | id                 | integer |             |
| FK | buyer_id           | integer |             |
| FK | seller_id          | integer |             |
| FK | item_id            | integer |             |

#### Association
- belongs_to :users
- belongs_to :items
- belongs_to :addresses


### addresses
|      Column             | Type    | Options     |
| ----------------------- | ------- | ----------- |
|    | post_number        | integer | null: false |
|    | prefectures_id     | integer |             |
|    | municipalities     | string  | null: false |
|    | address            | string  | null: false |
|    | building           | string  | null: false |
|    | phone              | integer | null: false |
| FK | last_name          | string  | null: false |
| FK | first_name         | string  | null: false |
| FK | last_name_kana     | string  | null: false |
| FK | first_name_kana    | string  | null: false |

#### Association
- belongs_to :users
- belongs_to :purchases


### comments
|      Column             | Type    | Options     |
| ----------------------- | ------- | ----------- |
| FK | nickname           | string  |             |
| FK | user_id            | integer |             |
| FK | item_id            | integer |             |
|    | text               | text    |             |

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