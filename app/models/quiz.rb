class Quiz < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :answers, through: :questions #does the questions table need an answer_id to make this connection work?

  #generate question objects that are associated to quiz by question_id
  def create_question
    question_hash = Adapter.quiz_api(difficulty) #use adapter method, with difficulty passes into the url as a variable, to gnerate a new list of questions.
    new_question = Question.new #make a new question instance
    new_question.save #save now so we can store the question's id in the answer by calling self.id
    new_question.content = question_hash['question'] #adding all necessary column data to this question object/row
    new_question.create_answers(question_hash)
    new_question.quiz_id = self.id
    new_question.save #send the newly created question to the database
  end

  def create_questions_by_integer(num) #makes as many questions as input by the user in the CLI
    (num).times { create_question }
  end

end
