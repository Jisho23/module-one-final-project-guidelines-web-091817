class User < ActiveRecord::Base
  has_many :answers
  has_many :questions, through: :answers
  has_many :quizs, through: :questions

#returns all correct answers by user instance (note: <user object>.answers will get ALL answers associate with user)
  def correct_answers
    # binding.pry
    correct_answers = self.answers.where(truthiness: true) #for this current user instance (self), gets all the answers where the truthiness is true (set during question/answer creation)
  end

# calls on user object for all correct answers, then selects those with a corresponding quiz id from argument.
  def correct_answers_by_quiz(quiz)
    full_list_of_answers = self.correct_answers #gets correct_answers on the current user instance.
    correct_answers_from_quiz = full_list_of_answers.select {|answer| answer.quiz_id == quiz.id} #selects answers whose quiz_id matches the passed in quiz's id. Makes an array of correct answers by quiz for this user instance
  end

#generates the average correct answers over ALL quizzes
  def total_average #gets correct answers array length, all answers array length, passes them into caluculate_average method, and returns average
    correct_answers = self.correct_answers.length #length of correct_answers array for this user instance
    all_answers = Answer.all.where(user_id: self).length #length of all answers array for this user instance
    average = calculate_average(correct_answers, all_answers) #uses calculate average method below to get average percentage of questions answerted correctly

  end

# creates the average based on a quiz argument
  def average_by_quiz(quiz) #given a quiz, get the average for that quiz
    correct_answers_by_quiz = self.correct_answers_by_quiz(quiz).length # uses correct_answers_by_quiz method to get the number of questions correct for that quiz
    quiz_questions = quiz.questions.length #length of the quiz passed in
    average = calculate_average(correct_answers_by_quiz, quiz_questions) #calculate_average method below to get average for this quiz
  end

# handy method to calculate the average of correct answers versus total answers
  def calculate_average(correct_answers, total_answers)
     #this is an average. uses floats to get decimals, *100 because thats what a percentage is, and converts to an integer. '%.2f' % to round the float off to 2 decimal places
    if Adapter.check_for_zero?(total_answers) == true
      puts "You haven't taken any quizzes!!!"
      return -1
    else
      average = (correct_answers.to_f * 100) / (total_answers.to_f * 100)
      average = average * 100
      return average.to_i
    end

  end

end
