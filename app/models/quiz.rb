class Quiz < ActiveRecord::Base
  has_many :questions
  has_many :answers, through: :questions

  #generate question objects that are associated to quiz by question_id
  def create_question
    question_data = RestClient.get('https://opentdb.com/api.php?amount=1&type=multiple')
    question_hash = JSON.parse(question_hash["results"])
    new_question = Question.new
    new_question.quiz_id = self.id
    new_question.save
  end

  def create_questions_by_integer(num)
    (num).times { create_question }
  end
end
