FactoryBot.define do
  factory :user do
    nickname              {Faker::Name}
    email                 {Faker::Internet.free_email}
    password = Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)
    password              {password}
    password_confirmation {password}
    gimei = Gimei.name
    last_name             {gimei.last.kanji}
    first_name            {gimei.first.kanji}
    last_name_kana        {gimei.last.katakana}
    first_name_kana       {gimei.first.katakana}
    date_of_birth         {Faker::Date.between(from: '1930-01-01', to: '2015-12-31')}
  end
end
