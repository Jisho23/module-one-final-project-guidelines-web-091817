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
    puts "What's your name?"
    input = Adapter.query_user
    find_or_create_by(input)
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
    #how to add difficulty is on joshs branch
    new_quiz.create_questions_by_integer(number_of_questions)
    new_quiz.questions.each do |question|
      question.user_id = user.id
    end
  end

  def take_quiz
    @new_quiz.questions.each do |question|
      puts question.content
      question.display_answers
      puts "Time to choose... (1-4)"
      user_input = Adapter.query_user
      question.stamp_answer_with_user_id(user_input, @user.id)
      #stamp answers with quiz id
      question.answers.each { |answer| answer.quiz_id = @new_quiz.id }
      binding.pry
    end
    binding.pry
  end

  #-------- post-game stats

  def did_you_win
    user_answer = new_quiz.answers.where(user_id: user.id, truthiness: true)
    puts "You got #{user_answer.size} out of #{number_of_questions} questions right!"
    winng?(user_answer)
  end

  def winning?
    #output how many questions you got right, and how many total questions there were
    puts ""
  end

  def user_stats
    #things like overall percentage, by quiz (>75%, say), and by question number. multiple methods, probably

  end



end


# #flow of the game:
# select user.  find_or_create_by to select from existing user or make a new one and add to table
# user selects difficulty and number of questions
# pull quiz with those criteria from db (with adapter)
# drop_user_by_name method?

# display_questions will show all questions
