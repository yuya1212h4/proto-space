FactoryGirl.define do
  factory :comment do
    content            { Faker::Lorem.sentence }
    user
    prototype
    created_at         { DateTime.now }
    updated_at         { DateTime.now }
  end
end
