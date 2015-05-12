# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# The create! method is just like the create method, except it raises an exception for an invalid user rather than returning false
User.create!(name:  "Taller Piñon",
             email: "contacto@tallerpinon.cl",
             password:              "pad3828",
             password_confirmation: "pad3828",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
User.create!(name:  "Javingka",
             email: "jcruzsm@gmail.com",
             password:              "dinamo2015",
             password_confirmation: "dinamo2015",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
# User.create!(name:  "Example User",
#              email: "example@railstutorial.org",
#              password:              "foobar",
#              password_confirmation: "foobar",
#              admin: true,
#              activated: true,
#              activated_at: Time.zone.now)
# 
# 
# 50.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+1}@pinonTest.org"
#   password = "password"
#   User.create!(name:  name,
#                email: email,
#                password:              password,
#                password_confirmation: password,
#                activated: true,
#                activated_at: Time.zone.now)
# end
# 
# users = User.order(:created_at).take(6)
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   users.each { |user| user.microposts.create!(content: content) }
# end
# 
# # Creating motos in Users
# user = User.second
# content = Faker::Lorem.sentence(10)
# user.motos.create!(modelo: "cafe racer", name: "mi moto", description: content )
# user = User.find_by(email: 'admin@pinon.cl') 
# user.motos.create!(modelo: "scrambler", name: "mi moto", description: content )
# 
# # Following relationships
# users = User.all
# user  = users.first
# following = users[2..50]
# followers = users[3..40]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }
# 
