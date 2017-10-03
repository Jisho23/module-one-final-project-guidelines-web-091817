class Quiz < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :answers, through: :questions #does the questions table need an answer_id to make this connection work?

  #generate question objects that are associated to quiz by question_id
  def create_question
    question_hash = Adapter.quiz_api
    new_question = Question.new
    new_question.save #save now so we can store the question's id in the answer by calling self.id
    new_question.content = question_hash['question']
    new_question.create_answers(question_hash)
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

end
