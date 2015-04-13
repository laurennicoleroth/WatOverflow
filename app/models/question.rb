class Question < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy_all
  has_many :votes, as: :votable, dependent: :destroy_all
  has_many :answers, dependent: :destroy_all
  validates :content, length: {minimum: 1}

  def self.find_highest_voted
    # TODO: Should be Question.joins(...).order(...)
    Question.all.sort_by do |question|
      question.votes.map do |vote|
        question.votes.count
      end.reduce(0, :+)
    end
  end

  def self.find_most_recent
    # maybe do: Question.order(created_at: :descending).limit(10)
    Question.order('created_at DESC').limit(10)
  end

  def self.find_trending
    # plz to not load whole database into the frontend kthxbai.
     Question.all.sort_by do |question|
      question.comments.map do |comment|
        question.comments.count
      end.reduce(0, :+)
    end
  end
end
