class Quiz < ActiveRecord::Base
  has_many :questions
  has_many :answers, through: :questions

  #generate question objects that are associated to quiz by question_id
  def create_question
    question_hash = JSON.parse(RestClient.get('https://opentdb.com/api.php?amount=1&type=multiple'))["results"][0]
    new_question = Question.new(question_hash)
    new_question.quiz_id = self.id
    new_question.save
  end

  def create_questions_by_integer(num)
    (num).times { create_question }
  end
>>>>>>> joshs_branch
end
