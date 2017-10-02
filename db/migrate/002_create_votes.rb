class CreateVotes < ActiveRecord::Migration[4.2]
  def change
    create_table :votes do |t|
      t.integer :vote_count
      t.string :user_id
      t.string :quote_id
    end
  end
end
