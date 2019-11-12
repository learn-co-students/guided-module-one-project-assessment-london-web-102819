require 'faker'

10.times do
  User.create(user_name: Faker::JapaneseMedia::DragonBall.character)
end

10.times do
  Review.create(user_id: User.all.sample.id, show_id: Show.all.sample.id, title: Faker::Hacker.say_something_smart, rating: Faker::Number.between(from: 1, to: 10), content: Faker::Hacker.say_something_smart)
end

10.times do
  Show.create(show_name: Faker::JapaneseMedia::OnePiece.akuma_no_mi)
end