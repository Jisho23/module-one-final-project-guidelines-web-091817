class User_stats

  def self.leaderboard
    User.all.each do |user|
      puts "#{user.name}: #{user.correct_answers.length} correct answers. Average: %#{user.average}"
    end
  end

end
