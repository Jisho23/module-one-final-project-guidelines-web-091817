class User < ActiveRecord::Base
  has_many :answers
  has_many :questions, through: :answers
  has_many :quizs, through: :questions

#returns all correct answers by user instance (note: <user object>.answers will get ALL answers associate with user)
  def correct_answers
    correct_answers = self.answers.where(truthiness: true)
  end

# calls on user object for all correct answers, then selects those with a corresponding quiz id from argument.
  def correct_answers_by_quiz(quiz)
    full_list_of_answers = self.correct_answers
    correct_answers_from_quiz = full_list_of_answers.select {|answer| answer.quiz_id == quiz.id}
  end

#generates the average correct answers over ALL quizzes
  def total_average
    correct_answers = self.correct_answers.length
    all_answers = self.answers.length
    average = calculate_average(correct_answers, all_answers)
  end

# creates the average based on a quiz argument
  def average_by_quiz(quiz)
    correct_answers_by_quiz = self.correct_answers_by_quiz(quiz).length
    quiz_questions = quiz.questions.length
    average = calculate_average(correct_answers_by_quiz, quiz_questions)
  end

# handy method to calculate the average of correct answers versus total answers
  def calculate_average(correct_answers, total_answers)
    average = (correct_answers.to_f * 100) / (total_answers.to_f * 100)
    average = average * 100
    average.to_i
  end

end
