require 'pry'
require 'command_line_reporter'


class Table
  include CommandLineReporter

 #  def initialize
 #   self.formatter = 'progress'
 # end
 #
 # def run
 #   x = 0
 #   report do
 #     10.times do
 #       x += 1
 #       progress
 #     end
 #   end
 # end

 def big_table
    # suppress_output
    # header title: 'Monkey Butt the wide, and annoying', width: 80, align: 'left', rule: false, color: 'blue', bold: false, timestamp: false
    table border: true do
      row color: 'blue' do
        column 'Player', width: 20, align: 'left', color: 'green'
        column 'Overall % correct', width: 30, align: 'left', color: 'green'
      end
      User.all.each do |user|
        row color: 'blue' do
          # binding.pry
          column "#{user.name}", width: 20, align: 'left', color: 'green'
          column "#{user.total_average}%", width: 20, align: 'left', color: 'green'
        end
      end
      #   column 'ADDRESS', width: 30, padding: 5
      #   column 'CITY', width: 15
      # end
      # row color: 'green', bold: true do
      #   column 'caeser'
      #   column '1 Appian Way'
      #   column 'Rome'
      # end
      # row do
      #   column 'Richard Feynman'
      #   column '1 Golden Gate'
      #   column 'Quantum Field'
    end

    # return capture_output
  end


  def self.welcome_display
      table :border => false do
       row :color => 'blue' do
         column "WELCOME TO FACEIT",
         :width => 155, :color => 'cyan', align: 'center', :bold => true
       end
     end
  end
end
