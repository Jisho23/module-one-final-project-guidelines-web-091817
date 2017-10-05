class Quiz < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :answers, through: :questions #does the questions table need an answer_id to make this connection work?

  #generate question objects that are associated to quiz by question_id
  def create_question
    binding.pry
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

#   def get_users_answer
#     while
#       user_input = Adapter.query_user #abtracted out gets.chomp
#       if valid_answer?(user_input) == false #checks below to make sure the input is a valid choice
#         puts "Give a numbered answer please."
#       else
#         break
#       end
#     end
#     return user_input.to_i
#   end
#
#   def valid_answer?(input)
#     unless input == '1' || input == '2' || input == '3' || input == '4' #max 4 questions, if they enter anything other than 1-4 numerically, gives error message above
#       false
#     end
#     true
#   end
# end
