FactoryBot.define do
  factory :private_group do
    name    { "プライベートグループ" }
    user_id { User.first.id }
  end
end
