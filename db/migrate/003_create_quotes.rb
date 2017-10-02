class CreateVotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :content
    end
  end
end
