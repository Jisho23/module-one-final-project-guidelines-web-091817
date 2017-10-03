class User_stats

  def self.leaderboard
    Users.all.each do |user|
      puts "#{user.name}: #{user.correct_answers} %#{user.average}"
    end
  end
end
