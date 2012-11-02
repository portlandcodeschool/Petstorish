# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#User.delete_all()
#Product.delete_all()
#Order.delete_all()
#LineItem.delete_all()
#Option.delete_all()
#OptionAssignment.delete_all()
#Cart.delete_all()


User.create(
  email: 'testuser@test.com',
  password: '000000009',
  password_confirmation: '000000009',
  address: 'steve',
  credit_card: 'steve',
  admin: true
)
User.create(
  email: 'pkinnecom@elctech.com',
  password: 'rushrush',
  password_confirmation: 'rushrush',
  address: 'steve',
  credit_card: 'steve',
  admin: true
)

User.create(
  email: 'mdanskey@elctech.com',
  password: 'rushrush',
  password_confirmation: 'rushrush',
  address: 'steve',
  credit_card: 'steve',
  admin: true
)

User.create(
  email: 'rsakry@elctech.com',
  password: 'rushrush',
  password_confirmation: 'rushrush',
  address: 'steve',
  credit_card: 'steve',
  admin: true

)
products = []
products << Product.create(
        name: 'This is the test name funzone',
        description: 'This is the description crazypants',
        price: 2,
        category: 'misc'
)

products << Product.create(
        name: 'Steve E. Wonder',
        description: 'Life of Steve',
        price: 2,
        category: 'misc'
)
Product.categories.each do |cat|
  10.times do 
    products << Product.create(
      name: RandomWord.adjs.next + " " + RandomWord.nouns.next,
      description: 'description text is so fun to write I having fun i having fun i having fun',
      price: rand(100),
      category: cat
    )
  end
end

products.each do |p|
  p.image = File.open('db/seed_images/'+rand(5).to_s + '.png')
  p.save!
end


Option.create(family: 'color', value: 'blue')
Option.create(family: 'color', value: 'yellow')
Option.create(family: 'color', value: 'green')

OptionAssignment.create(product_id: 1, option_id: 1)
OptionAssignment.create(product_id: 1, option_id: 2)
OptionAssignment.create(product_id: 1, option_id: 3)

