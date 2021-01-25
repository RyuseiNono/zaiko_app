FactoryBot.define do
  factory :shop do
    name { "#{Faker::Address.city}店" }
    location { Faker::Address.state }
    phone_number { Faker::PhoneNumber.phone_number.gsub(/-/, '') }
    prefecture_id { rand(1..Prefecture.all.length) }
    opening_time { '10:00:00' }
    closing_time { '20:00:00' }
    parking_id { rand(1..Parking.all.length) }
    credit_card_id { rand(1..CreditCard.all.length) }
    electronic_money_id { rand(1..ElectronicMoney.all.length) }
    association :admin
  end
end
