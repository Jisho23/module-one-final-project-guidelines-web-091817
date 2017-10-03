class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t| #need to make certain of plural case (see filename)
      t.string :content
    end
  end
end
