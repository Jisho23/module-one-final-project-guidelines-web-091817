class User_stats
#simple method to display a leaderboard
  def self.leaderboard
    User.all.each do |user|
      if Adapter.check_for_zero?(user.answers.length) != true
        puts "#{user.name}: #{user.correct_answers.length} correct answers. Average: #{user.total_average}%"
      else
        puts "#{user.name} hasn't taken a quiz!"
      end
    end
  end
end
