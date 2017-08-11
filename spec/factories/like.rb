FactoryGirl.define do
  factory :like do
    user
    prototype
    created_at         { DateTime.now }
    updated_at         { DateTime.now }
  end
end
