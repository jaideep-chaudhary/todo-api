FactoryBot.define do
  factory :item do
    name { Faker::StarWars.character }
    status { Faker::StarWars.character }
  end
end
