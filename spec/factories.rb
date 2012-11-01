FactoryGirl.define do
  factory :user do
    email "steve@dilbert.com"
    admin false
    password "90iii393"
    password_confirmation "90iii393"
    address "12394 funstreet"
    credit_card "woooo"
  end

  factory :admin, class: User do
    email "bob@bob.com"
    admin true
    password "90aaa393"
    password_confirmation "90aaa393"
    address "12394 funstreet"
    credit_card "woooo"
  end
end
