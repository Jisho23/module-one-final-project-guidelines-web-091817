class Adapter
URL = "https://opentdb.com/api.php?amount=1&type=multiple&difficulty="
  def self.quiz_api(difficulty)
      raw_data = RestClient.get("#{URL}#{difficulty}") #raw api data
      # JSON.parse(raw_data)["results"][0] #data as hash, only returning results (which is an array of hash hence [0])
      parsed_hash = JSON.parse(raw_data)["results"][0] #data as hash, only returning results (which is an array of hash hence [0])
      # output = {}
      parsed_hash.each do |key, value|
        if value.is_a? Array
          value.each_with_index do |element, index| #each_with_index uneccessary, only needs to be .each |element|, and element = Adapter.delete_quotes(element), but this way also works.
            parsed_hash[key][index] = Adapter.delete_quotes(element)
          end
        else
          parsed_hash[key] = Adapter.delete_quotes(value)
        end
      end
  end


  def self.delete_quotes(string) #this subs out any characters that will be unread
    string = string.gsub(/&quot;/, "\"")
    string = string.gsub(/&#039;/, "\'")
    string = string.gsub(/&rsquo;/, "\'")
    string = string.gsub(/&eacute;/,"\'")
    string = string.gsub(/&rdquo;/, "\"")
    string = string.gsub(/&e/, "\ê")
  end

end



# {"category"=>"Entertainment: Video Games",
#  "type"=>"multiple",
#  "difficulty"=>"medium",
#  "question"=>"What was the original name of  &quot;Minecraft&quot;?",
#  "correct_answer"=>"Cave Game",
#  "incorrect_answers"=>["Minecraft: Order of the Stone", "Dig And Build", "Infiniminer"]}
