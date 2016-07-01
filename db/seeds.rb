User.create!(name:  "admin",
             email: "nhoxvip95@gmail.com",
             password:              "abc123",
             password_confirmation: "abc123",
             admin: true)

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "123456"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
20.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.entries.create!(content: content) }
end
