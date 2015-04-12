class Question < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :answers


  def self.find_highest_voted
    @vote_counts = []
    Question.all.each do |question|
      @vote_counts << { question.votes.count => question }
    end
    # Hash[@vote_counts.sort]

  end

  def self.find_most_recent
    Question.order('created_at DESC').limit(10)
  end

  def self.find_trending

  end
end
