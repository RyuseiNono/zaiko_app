FactoryBot.define do
  factory :message do
    text                     { Faker::Lorem.sentence }
    association :admin
    association :user
    association :shop
  end
end
