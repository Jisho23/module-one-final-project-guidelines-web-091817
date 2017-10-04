class User_stats

#simple method to display a leaderboard
  def self.leaderboard
    User.all.each do |user|
      unless user.answers.length == 0
        puts "#{user.name}: #{user.correct_answers.length} correct answers. Average: %#{user.total_average}"
      else
        puts "#{user.name} hasn't taken a quiz!"
      end
    end
  end
end
