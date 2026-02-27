FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    summary { Faker::Lorem.sentence }
    author
  end
end