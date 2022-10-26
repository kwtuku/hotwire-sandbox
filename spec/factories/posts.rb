FactoryBot.define do
  factory :post do
    content { 'Hello world!' }
    user
  end
end
