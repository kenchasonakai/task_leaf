FactoryBot.define do
  factory :task do
    name { Faker::JapaneseMedia::StudioGhibli.movie }
    description { Faker::JapaneseMedia::StudioGhibli.quote}
  end
end