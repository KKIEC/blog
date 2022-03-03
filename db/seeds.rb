user = User.create(username: 'testuser', email: 'test@example.com', password: 'xxxxxxxx', admin: true)

category = Category.create(name: 'Basketball')
category1 = Category.create(name: 'Volleyball')
category2 = Category.create(name: 'Football')

10.times do
  Article.create(
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 10),
    user: user,
    premium: [true, false].sample
  )
end
