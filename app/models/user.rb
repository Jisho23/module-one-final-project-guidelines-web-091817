class User < ActiveRecord::Base
  has_many :answers
  has_many :questions, through: :answers
  has_many :quizs, through: :questions
end
