class RemoveNameFromQuestions < ActiveRecord::Migration[4.2]
  def change
    remove_column :questions, :name
  end
end
