FactoryBot.define do
 
  factory :user do    
    name                    { "michael" }
    sequence(:email)        { |n| "test#{n}@example.com" }
    password                { "password" }
    password_confirmation   { "password" }
  end
end
