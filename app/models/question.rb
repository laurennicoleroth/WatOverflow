class Question < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :answers


  def self.find_highest_voted
    Question.all.sort_by do |question|
      question.votes.map do |vote|
        question.votes.count
      end.reduce(0, :+)
    end
  end

  def self.find_most_recent
    Question.order('created_at DESC').limit(10)
  end

  def self.find_trending
     Question.all.sort_by do |question|
      question.comments.map do |comment|
        question.comments.count
      end.reduce(0, :+)
    end
  end
end
