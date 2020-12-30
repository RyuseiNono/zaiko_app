FactoryBot.define do
  factory :item do
    name                     { Faker::Food.fruits }
    count                    { rand(0..100) }
    association :shop
  end
end
