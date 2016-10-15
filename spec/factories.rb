FactoryGirl.define do
  factory :user do
    name     "User"
    email    "user@example.com"
    password "password"
    password_confirmation "password"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end
