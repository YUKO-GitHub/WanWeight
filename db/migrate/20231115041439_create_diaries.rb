class CreateDiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :diaries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :dog, null: true, foreign_key: true
      t.datetime :date
      t.text :diary_text
      t.text :meal_text
      t.text :exercise_text
      t.text :health_text

      t.timestamps
    end
  end
end
