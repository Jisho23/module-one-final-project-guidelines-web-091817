require 'pry'
class CLI
  attr_accessor :new_quiz, :user, :number_of_questions

  def welcome #welcomes the user, starts a game
    puts "Welcome to TRIVIA!"
    puts "ARE"
    puts "   YOU"
    puts "      WORTHY?"
    start_game #run the start_game method
  end

  def start_game
    @user = pick_user #instance =variable for use later.
    puts "Our trivia game is basically the best thing ever. Ever"
    difficulty = pick_difficulty #variable difficulty to use in interpolation, method below modifies numerical input to easy/medium/hard
    @number_of_questions = pick_number_of_questions #ditto above, chooses how many questions the make_quiz.create_questions_by_integer method will iterate
    puts "Awesome! You chose difficulty #{difficulty}, with #{number_of_questions} questions."
    make_quiz(difficulty, number_of_questions)
    take_quiz
    did_you_win
  end

  def pick_user
    puts "Let's find your records, or make a new username for you."
    puts "If you need to remove a user, enter pi to 5 decimal places"
    puts "What's your name?"
    input = Adapter.query_user
    if input == "3.14159"
      delete_user
    else
      find_or_create_by(input)
    end
  end

  def delete_user
    puts "What user do you need to delete? Don't be an asshole. Only delete your own records"
    input = Adapter.query_user
    puts "Hint: There is an Easter Egg. But where.....?"
    name_id_to_delete = User.find_by(name: input).id
    User.delete(name_id_to_delete)
    pick_user
  end

  def find_or_create_by(name)
    User.find_or_create_by(name: name)
  end

  def pick_difficulty
    while true #I wanted to call the function again if an improper inpiut was entered, but the while loop is better for functionality.
      puts "Please choose your difficulty: 1. Easy. 2. Medium. 3. Hard. 4. Exit"
      difficulty_level = Adapter.query_user
      case difficulty_level
      when "1"
        return "easy"
      when "2"
        return "medium"
      when "3"
        return "hard"
      when "Easter Egg" #hehe
        puts "ASAMBI SANA SQUASH BANANA"
      when "4"
        puts "COWARD!!!"
        exit
      else
        puts "Hmm, that isn't an option, pick again"
      end
    end
  end

  def pick_number_of_questions # simple method, asks how many questions theyd like the quiz to be.
    puts "How many questions would you like? (Enter a number, 1-20)"
    number_of_questions = Adapter.query_user
    if !number_of_questions.to_i.between?(1,20)
      puts "Sorry, incorrect input."
      pick_number_of_questions
    end
    return number_of_questions.to_i
  end

#makes entire quiz here, stamps questions with the @user.id
  def make_quiz(difficulty, number_of_questions)
    @new_quiz = Quiz.create
    new_quiz.user_id = @user.id
    new_quiz.difficulty = difficulty
    new_quiz.save
    new_quiz.create_questions_by_integer(number_of_questions)
    new_quiz.questions.each do |question|
      question.user_id = user.id
      question.save
    end
  end

  def take_quiz
    @new_quiz.questions.each do |question|
      puts question.content
      question.display_answers
      puts "Time to choose... (1-4)"
      valid_input = false
      while valid_input == false
        user_input = Adapter.query_user
        valid_input = question_input_valid?(user_input)
      end
      question.stamp_answer_with_user_id(user_input, @user.id)
      #stamp answers with quiz id
    end
    new_quiz.answers.each do |answer|
      answer.quiz_id = @new_quiz.id
      answer.save
    end
  end

  def question_input_valid?(user_input)
    if user_input.to_i > 4
      puts "There aren't that many answers! Between 1-4 please..."
      false
    elsif user_input.to_i < 1
      puts "Are you even trying?"
      false
    else user_input.to_i.between?(1, 4)
       true
    end
  end

  #-------- post-game stats

  def did_you_win
    user_answers = user.correct_answers_by_quiz(new_quiz)
    puts "You got #{user.correct_answers_by_quiz(new_quiz).length} out of #{number_of_questions} questions right!"
    winning?
    binding.pry
  end

  def winning?
    puts "All time, you've answered #{user.correct_answers.size} correct out of #{user.answers.size} total. That's #{user.total_average}%. That's...yeah. You know."
  end

  def difficulty_stats(difficulty) #difficulty is a valid string of 'easy', 'medium', or 'hard' (DOWNCASE!!!)
    quizzes_by_difficulty = Quiz.all.where(difficulty: difficulty, user_id: user.id)
    total_average = 0
    quizzes_by_difficulty.each do |quiz|
      average = @user.average_by_quiz(quiz)
      total_average += average
    end
    final_average = total_average / quizzes_by_difficulty.length
    puts "Based on #{difficulty} quizzes, you have an average of #{final_average}%!"
  end

  def stats
  end
end


# #flow of the game:
# select user.  find_or_create_by to select from existing user or make a new one and add to table
# user selects difficulty and number of questions
# pull quiz with those criteria from db (with adapter)
# drop_user_by_name method?

# display_questions will show all questions
