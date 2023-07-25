FactoryBot.define do
  factory :item do
      title           {"商品名"}
      description     {"商品説明"}
      category_id     {2}
      condition_id    {2}
      postage_id      {2}
      prefecture_id   {2}
      shipping_day_id {2}
      price           {1000}
      
      user { FactoryBot.create(:user) }

      after(:build) do |image|
      image.image.attach(io: File.open(Rails.root.join('spec/fixtures/sample1.png')), filename: 'sample1.png')
    end
  end
end