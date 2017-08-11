FactoryGirl.define do
  factory :prototype do
    title              { Faker::Cat.name }
    catch_copy         { Faker::Lorem.sentence }
    text               { Faker::Lorem.sentence }
    likes_count        0
    user

    after(:create) do |prototype|
      create(:prototype_image, :main_image, prototype: prototype)
      create(:prototype_image, :sub_image, prototype: prototype)
    end
  end
end
