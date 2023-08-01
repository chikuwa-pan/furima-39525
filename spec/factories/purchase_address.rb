FactoryBot.define do
  factory :purchase_address do
    japanese_address = Gimei.address
    post_number     { '111-1111' }
    prefecture_id   { 2 }
    municipalities  { japanese_address.city.kanji }
    address         { japanese_address.town.kanji }
    phone           { '09011112222' }
    token           { 'sk_test_00000000000000000000000' }
    item_id         { 1 }
    user_id         { 1 }
  end
end
