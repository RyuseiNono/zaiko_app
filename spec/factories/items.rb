FactoryBot.define do
  factory :item do
    name                     { Faker::Food.fruits }
    price                    { rand(0..99999999) }
    count                    { rand(0..99) }
    association :shop
  end
end
