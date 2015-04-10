require 'tubular-faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do
User.create!(name: TubularFaker.name, email: TubularFaker.email, password: '1234')
end

User.all.each do |user|
  5.times do
    Question.create!(title: TubularFaker.lingo, content: TubularFaker.lingo, user_id: user.id)
  end
  5.times do
    Answer.create!(body: TubularFaker.lingo, user_id: user.id, question_id: rand(1..25))
  end
  5.times do
    Comment.create!(body: TubularFaker.lingo, user_id: user.id, commentable_id: rand(1..25), commentable_type: "question")
  end
  5.times do
    Comment.create!(body: TubularFaker.lingo, user_id: user.id, commentable_id: rand(1..25), commentable_type: "answer")
  end
  5.times do
    Vote.create!( votable_id: rand(1..25), votable_type: "question")
  end
  5.times do
    Vote.create!( votable_id: rand(1..25), votable_type: "question")
  end
  5.times do
    Vote.create!( votable_id: rand(1..25), votable_type: "answer")
  end
   5.times do
    Vote.create!( votable_id: rand(1..25), votable_type: "comment")
  end
end
