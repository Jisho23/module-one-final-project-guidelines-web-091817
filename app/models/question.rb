class Question < ActiveRecord::Base

  belongs_to :quiz
  has_many :answers
  has_many :users, through: :answers

#hash of data passed in initialize)
#it will have the "quiz id" set in the create_question method in quiz.rb

  def create_answers(question_hash) #question has generated in quiz.create_question. sends each question, correct or incorrect, to that create_correct or create_incorrect method
    correct_answer =  create_correct_answer(question_hash['correct_answer']) #this is how the hash is structured. 1 correct answer, 3 incorrect in a separate array.
    question_hash['incorrect_answers'].each do |answer|
      incorrect_answer = create_incorrect_answers(answer)
    end
  end

#randomly displays all the question's text with a number assignment
  def display_answers
    answer_number = 0 #set our answer # counter to set answers' number_identifier
    self.answers.shuffle.each do |answer|
      #assign number_identifier to check user's answers
      answer_number += 1
      puts "#{answer_number}. #{answer.content}"
      answer.number_identifier = answer_number
      answer.save
    end
  end

  def create_correct_answer(answer) #this method makes the correct answer, be alert of the local "correct answer" which should be like the local "correct_answer" in the create answers method.
    correct_answer = Answer.new #makes a new answers, sets all answer instance column data. answer is the passes in correct_answer content from the question hash
    correct_answer.content = answer
    correct_answer.truthiness = true #the one true answer
    correct_answer.question_id = self.id
    correct_answer.save
  end

  def create_incorrect_answers(answer) #this method makes the correct answer, be alert of the local "correct answer" which should be like the local "correct_answer" in the create answers method
    incorrect_answer = Answer.new #makes a new incorrect answer, answer, set to content, is the passed in data from the question hash
    incorrect_answer.content = answer
    incorrect_answer.truthiness = false #other false answers
    incorrect_answer.question_id = self.id
    incorrect_answer.save
  end


  def stamp_answer_with_user_id(user_answer, user_id)#stamps from 'take quiz' in CLI
    # users_answer = self.answers.find_by(:number_identifier == user_answer.to_i)
    self.answers.each do |answer|
      if answer.number_identifier == user_answer.to_i #user_answer is user_input in take_quiz method in cli. checks if that matches the number identifier (set in display_answers above, to match the shuffled position of the answer)
        answer.user_id = user_id #if so, sets user_id of the answer to equal the user.id who answered the question.
        answer.save
      end
    end
    # users_answer.user_id = user_id
    # users_answer.save
    # binding.pry
  end

end
