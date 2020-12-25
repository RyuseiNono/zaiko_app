FactoryBot.define do
  factory :admin do
    Faker::Name.first_name
    name              { Faker::Name.first_name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) + rand(10).to_s }
    password_confirmation { password }
  end
end
