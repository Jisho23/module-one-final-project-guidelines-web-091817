class Question < ActiveRecord::Base

  belongs_to :quiz
  has_many :answers
  has_many :users, through: :answers

#hash of data passed in initialize)
#it will have the "quiz id" set in the create_question method in quiz.rb

  def create_answers(question_hash)
    correct_answer = Answer.new
    correct_answer.content = question_hash['correct_answer']
    correct_answer.truthiness = true
    correct_answer.question_id = self.id
    correct_answer.save

    question_hash['incorrect_answers'].each do |answer|
      incorrect_answer = Answer.new
      incorrect_answer.content = answer
      incorrect_answer.truthiness = false
      incorrect_answer.question_id = self.id
      incorrect_answer.save
    end
  end

#randomly displays all the question's text with a number assignment
  def display_answers
    answer_number = 0 #set our answer # counter to set answers' number_identifier
    self.answers.shuffle.each do |answer|
      #assign number_identifier to check user's answers
      answer_number += 1
      puts "#{answer_number}. #{answer.content}"
      answer.number_indentifier = answer_number
      answer.save
    end
  end

  def create_correct_answer(answer)
  end

  def create_incorrect_answers(answer)
  end
end
