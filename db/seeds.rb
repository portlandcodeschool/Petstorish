# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  email: 'pkinnecom@elctech.com',
  password: 'rushrush',
  password_confirmation: 'rushrush',
  address: 'steve',
  credit_card: 'steve'

)

User.create(
  email: 'mdanskey@elctech.com',
  password: 'rushrush',
  password_confirmation: 'rushrush',
  address: 'steve',
  credit_card: 'steve'

)

User.create(
  email: 'rsakry@elctech.com',
  password: 'rushrush',
  password_confirmation: 'rushrush',
  address: 'steve',
  credit_card: 'steve'

)
Product.create(
        name: 'This is the test name funzone',
        description: 'This is the description crazypants',
        price: 2,
        category: 'misc'
)
Product.create(
        name: 'Steve E. Wonder',
        description: 'Life of Steve',
        price: 2,
        category: 'misc'
)
Product.categories.each do |cat|
  50.times do 
    Product.create(
      name: RandomWord.adjs.next + " " + RandomWord.nouns.next,
      description: 'description text is so fun to write I having fun i having fun i having fun',
      price: 12.99,
      category: cat
    )
  end
end

Option.create(family: 'color', value: 'blue')
Option.create(family: 'color', value: 'yellow')
Option.create(family: 'color', value: 'green')

OptionAssignment.create(product_id: 1, option_id: 1)
OptionAssignment.create(product_id: 1, option_id: 2)
OptionAssignment.create(product_id: 1, option_id: 3)

