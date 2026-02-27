FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    summary { Faker::Lorem.sentence }
    author

    after(:create) do |book|
      genres = create_list(:genre, 2)
      book.genres << genres
    end
  end

  factory :book_genre do
    sequence(:name) { |n| "Género #{n}" }
  end
end