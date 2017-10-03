class Answer < ActiveRecord::Base
  belongs_to :answers
  belongs_to :user
end
