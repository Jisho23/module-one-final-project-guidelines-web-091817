class Question < ActiveRecord::Base

  has_many :answers

#hash of data passed in initialize)
#it will have the "quiz id" set in the create_question method in quiz.rb

  def initialize(question_hash)
    @text = question_hash["question"]
    correct_answer = Answer.new(question_hash[0]["correct_answer"], true)
    correct_answer.question_id = self.id
    correct_answer.save
    question_hash[0]['incorrect_answers'].each do |answer_text|
      incorrect_answer = Answer.new(answer_text, false)
      incorrect_answer.id = self.id
      incorrect_answer.save
    end
  end

#randomly displays all the question's text with a number assignment
  def display_answers
    answer_number = 0
    self.questions.shuffle.each do |answer|
      #assign number_identifier to check user's answers
      answer_number += 1
      puts "#{answer_number} #{answer.text}"
      answer.number_indentifier = answer_number
      answer.save
    end
  end

end
