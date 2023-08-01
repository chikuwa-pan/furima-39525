FactoryBot.define do
  factory :purchase do
    association :user, factory: :user # userオブジェクトを関連づけ
    association :item, factory: :item # itemオブジェクトを関連づけ
  end
end
