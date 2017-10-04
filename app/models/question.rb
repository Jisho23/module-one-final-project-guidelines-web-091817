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
    chosen_answer = self.answers.find_by(number_identifier: user_answer)
    chosen_answer.user_id = user_id
    chosen_answer.save
    if chosen_answer.right_or_wrong == false #checks if the answer was right or wrong (called on answer choice) then shows right answer for the question (called on self)
      self.show_right_answer
    end
  end

# simple method that shows the right answer, called on a question object
  def show_right_answer
    correct_answer = self.answers.find_by(truthiness: true)
    puts "For reference the right answer was #{correct_answer.content}... dummy!"
  end

end
