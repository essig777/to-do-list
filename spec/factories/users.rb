FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
    is_admin { false }
    
    trait :admin do
      is_admin { true }
    end
  end
end
