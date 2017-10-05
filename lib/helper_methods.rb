class Helper

  def self.query_user #this is an easy call method for and query to user. Tests run in local object
    ARGV.clear

    user_input = gets.strip
    until user_input != '' #this loop prevents an input of nothing
      puts 'Enter something real!'
      user_input = gets.strip
    end
    user_input
  end

  def self.check_for_zero?(int) #checks if an int is 0
    int == 0
  end

  def self.create_space #this creates a line space, the hell with constant puts " "!
    puts " "
  end

end
