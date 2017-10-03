class Answer < ActiveRecord::Base

  belongs_to :answers
#has values of truthiness (is it correct), text, question_id, and user_id
  def initialize(text, truthiness)
    @tcontent = text
    @truthiness = truthiness
  end

end
