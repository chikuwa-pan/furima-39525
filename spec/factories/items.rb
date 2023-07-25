FactoryBot.define do
  factory :item do
      title           {"商品名"}
      description     {"商品説明"}
      category_id     {1}
      condition_id    {1}
      postage_id      {1}
      prefecture_id   {1}
      shipping_day_id {1}
      price           {1000}
      
      user { FactoryBot.create(:user) }

      after(:build) do |image|
      image.image.attach(io: File.open(Rails.root.join('spec/fixtures/sample1.png')), filename: 'sample1.png')
    end
  end
end