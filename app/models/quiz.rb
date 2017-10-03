class Quiz < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :answers, through: :questions

  #generate question objects that are associated to quiz by question_id
  def create_question
    question_hash = Adapter.quiz_api
    new_question = Question.new(question_hash)
    new_question.quiz_id = self.id
    new_question.save
  end

  def create_questions_by_integer(num)
    (num).times { create_question }
  end

  def display_questions
    self.questions.each do |question| #iterate through each question object that belongs to THIS instance of a quiz.
      puts question.content
      question.display_answers
    end
end
