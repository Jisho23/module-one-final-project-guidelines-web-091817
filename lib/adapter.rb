class Adapter
URL = "https://opentdb.com/api.php?amount=1&type=multiple&difficulty="
  def self.quiz_api(difficulty)
      raw_data = RestClient.get("#{URL}#{difficulty}") #raw api data
      JSON.parse(raw_data)["results"][0] #data as hash, only returning results (which is an array of hash hence [0])
      binding.pry
  end

  def self.query_user #this is an easy call method for and query to user. Tests run in local object
    ARGV.clear
    user_input = gets.chomp
  end

  def self.check_for_zero?(int)
    int == 0
  end

end
