FactoryBot.define do
  factory :user do
    japanese_user = Gimei.name

      nickname              {Faker::Name.initials(number: 2)}
      email                 {Faker::Internet.email}
      password              {Faker::Internet.password(min_length: 6)}
      password_confirmation {password}
      last_name             { japanese_user.last.kanji }
      first_name            { japanese_user.first.kanji }
      last_name_kana        { japanese_user.last.katakana }
      first_name_kana       { japanese_user.first.katakana }
      date_of_birth         { Faker::Date.between(from: '1930-01-01', to: '2016-12-31') }
  end
end