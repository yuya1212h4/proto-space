# include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    name               { Faker::Name.name }
    user_image         { fixture_file_upload("spec/fixtures/img/sample.png", 'image/png') }
    member             { Faker::Lorem.sentence }
    profile            { Faker::Lorem.sentence }
    works              { Faker::Job.title }
    email              { Faker::Internet.email }
    password           { Faker::Internet.password(8)}
    password_confirmation { password }
    created_at         { DateTime.now }
    updated_at         { DateTime.now }
  end
end
