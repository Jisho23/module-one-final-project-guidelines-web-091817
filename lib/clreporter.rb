# require 'command_line_reporter'
# require 'colorize'

class Table
  extend CommandLineReporter

  def self.title
  end

  def self.display_text_box(text)
     table border: true do
       row color: 'magenta' do
         column "#{text}", width: text.length, align: 'left'
       end
     end
   end

   def self.display_quiz_score(correct_answers, number_of_questions)
     table border: true do
       row color: 'red' do
         column 'Correct Answers', width: 35, align: 'center'
         column 'Number of Questions', width: 35, align: 'center'
       end
       row color: 'red' do
         column "#{correct_answers}", width: 35, align: 'center', color: 'cyan'
         column "#{number_of_questions}", width: 35, align: 'center', color: 'cyan'
       end
     end
   end

   def self.display_average_by_difficulty(difficulty, average)
     table border: true do
       row color: 'red' do
         column "#{difficulty.capitalize} Quizzes", width: 50, align: 'center', color: 'cyan'
         column "#{average}%", width: 30, align: 'center', color: 'cyan'
       end
     end
   end

   def self.leader_board_table(stats)
     table border: true do
       row color: 'red' do
         column "User", width: 35
         column "Correct Answers", width: 35
         column "Average", width: 35
       end
       stats.each do |hash|
          row do
            column "#{hash[:name]}"
            column "#{hash[:correct_answers]}"
            column "#{hash[:average]}"
          end
       end
     end
   end

end

# FORMAT = Example.new
