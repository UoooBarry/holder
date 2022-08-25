puts 'creating sample user'
User.create!(email: 'test@test.com',
             username: 'barry',
             password: 'pwd123123',
             bio: 'Hello world',
             gender: User.genders[:male],
             age: 22)

puts 'creating sample community'
Community.create!(name: 'Ruby', description: 'Magical.')
