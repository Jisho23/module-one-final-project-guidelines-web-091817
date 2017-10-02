class User < ActiveRecord::Base
  has_many :answers
  has_many :quizzes, through: :answers
end
