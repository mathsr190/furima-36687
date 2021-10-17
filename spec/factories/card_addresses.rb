FactoryBot.define do
  factory :card_address do
    number                  { 4242424242424242 }
    exp_month               { Faker::Number.between(from: 1, to: 12) }
    exp_year                { Faker::Number.between(from: 22, to: 99) }
    cvc                     { 123 }
    postal_code = Faker::Number.number(digits: 7).to_s.insert(3, "-")
    postal_code             { postal_code }
    prefecture_id           { Faker::Number.between(from: 1, to: 47) }
    city                    { Faker::Address.city }
    address                 { Faker::Address.street_name }
    building                { Faker::Address.building_number }
    phone_number            { Faker::Number.between(from: 1000000000, to: 99999999999) }
  end
end
