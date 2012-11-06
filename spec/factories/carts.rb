# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :line_item do
    sequence(:product_id) { |n| "#{n}"}
    cart_id 1
    quantity 1
    cart
  end

  factory :cart do

    factory :cart_with_line_items do

      ignore do
        line_items_count 3
      end

      after(:create) do |cart, evaluator|
        FactoryGirl.create_list(:line_item, evaluator.line_items_count, cart: cart)
      end
    end
  end

end
