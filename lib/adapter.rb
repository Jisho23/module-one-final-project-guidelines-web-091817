class Adapter
URL = "https://opentdb.com/api.php?amount=1&type=multiple&difficulty="
  def self.quiz_api(difficulty)
      raw_data = RestClient.get("#{URL}#{difficulty}") #raw api data
      JSON.parse(raw_data)["results"][0] #data as hash, only returning results (which is an array of hash hence [0])
      parsed_hash = JSON.parse(raw_data)["results"][0] #data as hash, only returning results (which is an array of hash hence [0])
      output = {}
      parsed_hash.each do |key, value|
        if value.is_a? Array
          value.each_with_index do |element, index|
            parsed_hash[key][index] = Adapter.delete_quotes(element)
          end
        else
          parsed_hash[key] = Adapter.delete_quotes(value)
        end
      end
  end

  def self.query_user #this is an easy call method for and query to user. Tests run in local object
    ARGV.clear

    user_input = gets.strip
    until user_input != '' #this loop prevents an input of nothing
      puts 'Enter something real!'
      user_input = gets.strip
    end
    user_input
  end

  def self.check_for_zero?(int)
    int == 0
  end

  def self.delete_quotes(string) #this subs out any characters that will be unread
    string = string.gsub(/&quot;/, "\"")
    string = string.gsub(/&#039;/, "\'")
    string = string.gsub(/&rsquo;/, "\'")
    string = string.gsub(/&eacute;/,"\'")
    string = string.gsub(/&rdquo;/, "\"")
    string = string.gsub(/&e/, "\ê")
  end

  def self.create_space #this creates a line space, the hell with constant puts " "!
    puts " "
  end

end



# {"category"=>"Entertainment: Video Games",
#  "type"=>"multiple",
#  "difficulty"=>"medium",
#  "question"=>"What was the original name of  &quot;Minecraft&quot;?",
#  "correct_answer"=>"Cave Game",
#  "incorrect_answers"=>["Minecraft: Order of the Stone", "Dig And Build", "Infiniminer"]}
