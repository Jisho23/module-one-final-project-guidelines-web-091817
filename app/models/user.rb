class User < ActiveRecord::Base
  has_many :answers
  has_many :questions, through: :answers
  has_many :quizzes, through: :questions
end
