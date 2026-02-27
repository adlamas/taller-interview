FactoryBot.define do
  factory :author do
    name { Faker::Book.author }
    bio { Faker::Lorem.paragraph(sentence_count: 3) }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 90) }
  end
end