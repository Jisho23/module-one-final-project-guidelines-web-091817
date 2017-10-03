class Question < ActiveRecord::Base

  belongs_to :quiz
  has_many :answers
  has_many :users, through: :answers

#hash of data passed in initialize)
#it will have the "quiz id" set in the create_question method in quiz.rb

  def initialize(question_hash)
    @content = question_hash["question"]
    correct_answer = Answer.new(question_hash["correct_answer"], true) #correct answer will always have the truthiness of true initialized
    correct_answer.question_id = self.id
    correct_answer.save #always save the answer!!!
    question_hash['incorrect_answers'].each do |answer_text|
      incorrect_answer = Answer.new(answer_text, false) #incorrect answer will always have the truthiness of false, initialized
      incorrect_answer.question_id = self.id
      incorrect_answer.save #always save the answer!!!
    end
  end

#randomly displays all the question's text with a number assignment
  def display_answers
    answer_number = 0
    self.answers.shuffle.each do |answer|
      #assign number_identifier to check user's answers
      answer_number += 1
      puts "#{answer_number}. #{answer.content}"
      answer.number_indentifier = answer_number
      answer.save
    end
  end
end
