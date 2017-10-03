class Adapter
URL = "https://opentdb.com/api.php?amount=1&type=multiple&"
  def self.quiz_api(difficulty)
      raw_data = RestClient.get("#{URL}#{difficulty}") #raw api data
      JSON.parse(raw_data)["results"][0] #data as hash, only returning results (which is an array of hash hence [0])
  end

  def self.query_user
    ARGV.clear
    user_input = gets.chomp
  end

end
