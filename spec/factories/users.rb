FactoryBot.define do
  factory :user do
    login { "login" }
    sequence(:email) { |i| "email@email#{i}.com" }
    password { 'password' }
  end
end