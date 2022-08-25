puts 'creating sample user'
user = User.create!(email: 'test@test.com',
             username: 'barry',
             password: 'pwd123123',
             bio: 'Hello world',
             gender: User.genders[:male],
             age: 22)

puts 'creating sample community'
community = Community.create!(name: 'Ruby', description: 'Magical.')

puts 'Setting user to community admin'
community.admin!(user)
