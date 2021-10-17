FactoryBot.define do
  factory :shipping_address do
    postal_code = Faker::Number.number(digits: 7).to_s.insert(3, "-")
    postal_code             { postal_code }
    prefecture_id           { Faker::Number.between(from: 1, to: 47) }
    city                    { Faker::Address.city }
    address                 { Faker::Address.street_name }
    building                { Faker::Address.building_number }
    phone_number            { Faker::Number.between(from: 1000000000, to: 99999999999) }
    association :order
  end
end