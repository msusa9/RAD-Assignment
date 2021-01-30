# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

current = Time.zone.now 

User.create!(user_name: "Tristan Macaulay", email: "tristanmacaulay6@gmail.com", phone_number: "111111111111", password: "examplepassword", password_confirmation: "examplepassword", login_time: 1.day.ago, area: "Melbourne")
User.create!(user_name: "Michael Bendis", email: "example@railstutorial.org", phone_number: "11111111111", password: "examplepassword", password_confirmation: "examplepassword", login_time: 2.days.ago, area: "Adelaide")
User.create!(user_name: "Corvo Attano", email: "corvo@outsidermail.com", phone_number: "11111111111", password: "examplepassword", password_confirmation: "examplepassword", login_time: 3.days.ago, area: "Dunwall")

test_user = User.new(user_name: "RAD", email: "RAD", phone_number: "11111111111", password: "Rails2020", password_confirmation: "Rails2020", login_time: 5.days.ago, area: "RMIT university")
test_user.save!(validate: false)

# 10.times do |n|
#     name = Faker::Name.name 
#     email= "example-#{n+1}@railstutorial.org" 
#     phone = "1"
#     password= "password"
#     day = n + 1;
#     User.create!(user_name: name, email: email, phone_number: phone, password: password, password_confirmation: password, login_time: day.days.ago, area: "Melbourne") 
#     id = n + 1;
#     Post.create!(topic: "news", content: "some content", view: 0, commentCount: 0, title: "some title", tID: 1, uID: id)
# end

#If validation error, it means these topics are going into db twice, just delete all Topic.create lines
Topic.create!(name: "Games", description: "", views: 0);
Topic.create!(name: "AI", description: "", views: 0);
Topic.create!(name: "Stuff", description: "", views: 0);
Topic.create!(name: "World", description: "", views: 0);
Topic.create!(name: "COVID19", description: "", views: 0);
Topic.create!(name: "VR", description: "", views: 0);

Post.create!(topic: "COVID19", content: "Massive outbreak causes massive disrupts to the economy", view: 0, date: 1.day.ago, commentCount: 0, title: "Economy breaks under COVID19", tID: 5, uID: 1);
Post.create!(topic: "AI", content: "Are jobs going to be taken by robots!!!", view: 3, date: 5.days.ago, commentCount: 0, title: "AI robots becoming a reality", tID: 2, uID: 3);