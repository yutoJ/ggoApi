# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

email = ENV['SEED_USER_EMAIL']
name = Faker::LordOfTheRings.character
password = ENV['SEED_USER_PASSWORD']
uid = SecureRandom.uuid
user = User.create!(
  email: email,
  name: name,
  uid: uid,
  confirmed_at: DateTime.now,
  password: password,
  password_confirmation: password,
)

name = Faker::LordOfTheRings.character
uid = SecureRandom.uuid
user2 = User.create!(
  email: email + "2",
  name: name,
  uid: uid,
  confirmed_at: DateTime.now,
  password: password,
  password_confirmation: password,
)
