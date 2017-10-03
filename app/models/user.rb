class User < ActiveRecord::Base
  has_many :answers
  has_many :questions, through: :answers
end
