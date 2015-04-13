class User < ActiveRecord::Base
  has_secure_password

  # maybe dependent destroy here.
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
end
