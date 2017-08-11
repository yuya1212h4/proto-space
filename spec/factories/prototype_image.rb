FactoryGirl.define do
  factory :prototype_image do
    image             { fixture_file_upload("spec/fixtures/img/sample.png", 'image/png') }
    prototype

    trait :main_image do
      image_type 0
    end

    trait :sub_image do
      image_type 1
    end
  end
end
