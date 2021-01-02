FactoryBot.define do
  factory :shop do
    name                     { "#{Faker::Address.city}店" }
    location                 { Faker::Address.state }
    phone_number             { Faker::PhoneNumber.phone_number.gsub(/-/, '') }
    prefecture_id            { 1 }
    opening_time             { '10:00:00' }
    closing_time             { '20:00:00' }
    parking_id               { 1 }
    credit_card_id           { 1 }
    electronic_money_id      { 1 }
    association :admin
  end
end
