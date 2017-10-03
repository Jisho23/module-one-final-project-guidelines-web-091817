class Answer < ActiveRecord::Base

  belongs_to :answers
  belongs_to :user
#has values of truthiness (is it correct), text, question_id, and user_id
  def initialize(text, truthiness)
    @content = text
    @truthiness = truthiness
  end

end
