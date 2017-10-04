class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

#checks if this answer instance is true or false, outputs a text, and returns a value accordingly
  def right_or_wrong
    if self.truthiness == true
      puts "Correct! But that was an easy question."
      return true
    else
      Images.wrong
      return false
    end
  end
end
