namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: 'Aleks',
                 email: 'aleksey.senkou@gmail.com',
                 password: 'foobar',
                 password_confirmation: 'foobar',
                 admin: true)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n + 1}@railstutorial.org"
      password = 'password'
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    # users = User.all(limit: 6)
    20.times do 
      content = Faker::Lorem.sentence(5)
      User.first(6).each { |user| user.microposts.create!(content: content) }
    end
  end 
end
