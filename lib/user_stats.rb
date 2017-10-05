class User_stats
#simple method to display a leaderboard
  def self.leaderboard
    leader_board = []
    User.all.each do |user|
      if Helper.check_for_zero?(user.answers.length) != true
        hash = {}
        hash[:name] = user.name
        hash[:correct_answers] = user.correct_answers.length
        hash[:average] = user.total_average
        leader_board << hash
        # puts "#{user.name}: #{user.correct_answers.length} correct answers. Average: #{user.total_average}%"
      # else
      #   puts "#{user.name} hasn't taken a quiz!"
      end
    end
    unless leader_board.empty?
      leader_board.sort_by! {|hash| hash[:average]}
      Table.leader_board_table(leader_board.reverse)
    end
  end
end
