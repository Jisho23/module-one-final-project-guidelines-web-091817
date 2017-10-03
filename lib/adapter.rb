class Adapter

  def self.quiz_api
      raw_data = RestClient.get('https://opentdb.com/api.php?amount=1&type=multiple') #raw api data
      JSON.parse(raw_data)["results"][0] #data as hash, only returning results (which is an array of hash hence [0])
  end
end
