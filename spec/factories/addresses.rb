FactoryBot.define do
  factory :address do
    japanese_address = Gimei.address
      post_number     { 111-1111 }
      prefecture_id   { 2 }
      municipalities  { japanese_address.city.kanji }
      address         { japanese_address.town.kanji }
      phone           {'09011112222'}

      association :purchase, factory: :purchase # purchaseオブジェクトを関連づけ
    end
end
