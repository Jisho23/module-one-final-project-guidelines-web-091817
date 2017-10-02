class User < ActiveRecord::Base
  has_many :votes
  has_many :quotes, through: :votes
end
