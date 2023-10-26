class CreateUserWeights < ActiveRecord::Migration[7.0]
  def change
    create_table :user_weights do |t|
      t.references :user, null: false, foreign_key: true
      t.float :weight
      t.datetime :date

      t.timestamps
    end
  end
end
