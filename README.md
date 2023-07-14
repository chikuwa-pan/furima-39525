# FURIMA要件

## 概要
商品を出品もしくは、他ユーザーが出品した商品を購入できるアプリ。

## 機能
### ユーザー登録機能
- 必須項目
- ニックネーム
- メールアドレス
- パスワード
- 本人確認
- 姓・名
- 姓・名フリガナ
- 生年月日

### 商品出品機能
- 必須項目
- 商品画像
- 商品名
- 商品説明
- カテゴリー
- 商品の状態
- 配送料の負担
- 発送元の地域
- 発送までの日数
- 販売価格

### 商品購入機能
- 購入代金の表示
- クレジットカード情報はPAY.JP
- 必須項目
- 配送先
- 郵便番号
- 都道府県
- 市区町村
- 番地
- 建物名
- 電話番号

## テーブル設計

### users
| Column             | Type    | Options     | 
| ------------------ | ------- | ----------- | 
| nickname           | string  | null: false | 
| email              | string  | null: false |
| pass               | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| last_name_kana     | string  | null: false |
| first_name_kana    | string  | null: false |
| date_of_birth      | integer | null: false |

### Association
- has_many :items
- has_many :orders

### items
| Column             | Type    | Options     | 
| ------------------ | ------- | ----------- | 
| item_image         | text    | null: false |
| title              | string  | null: false |
| description        | text    | null: false |
| category           | string  | null: false |
| condition          | string  | null: false |
| postage            | string  | null: false |
| sender             | string  | null: false |
| shipping_days      | string  | null: false |
| price              | integer | null: false |

### Association
- belongs_to :orders

### orders
| Column             | Type    | Options     | 
| ------------------ | ------- | ----------- | 
| post_number        | integer | null: false |
| prefectures        | string  | null: false |
| municipalities     | string  | null: false |
| address            | string  | null: false |
| building_name      | string  | null: false |
| phone              | integer | null: false |

### Association
- belongs_to :items