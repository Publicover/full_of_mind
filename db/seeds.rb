# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
365.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = 'Airship123'
  user.save!
  puts "User #{user.first_name} created..."
  75.times do
    feeling = Feeling.new
    feeling.body = Faker::Games::Witcher.quote
    feeling.user_id = user.id
    puts "\t...and is feeling #{feeling.body}"
    feeling.save!
  end
  user.feelings.first(4).each_with_index do |feeling, index|
    feeling.current! if index == 0
    feeling.update(page_order: index) if (0..3).include?(index)
  end
end
