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

puts 'Puting posts'
user.subscribe!(community)
user.posts.create!(community: community, title: "Hello #{('a'..'z').to_a.sample(5).join}", content: 'Reading')
user.posts.create!(community: community, title: "Hello #{('a'..'z').to_a.sample(5).join}", content: 'Chatting')
user.posts.create!(community: community, title: "Hello #{('a'..'z').to_a.sample(5).join}", content: 'Gamming')
user.posts.create!(community: community, title: "Hello #{('a'..'z').to_a.sample(5).join}", content: 'Drinking')
user.posts.create!(community: community, title: "Hello #{('a'..'z').to_a.sample(5).join}", content: 'Hangout')
