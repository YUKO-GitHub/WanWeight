class CreateDogWeights < ActiveRecord::Migration[7.0]
  def change
    create_table :dog_weights do |t|
      t.references :dog, null: false, foreign_key: true
      t.float :weight, null: false
      t.datetime :date, null: false

      t.timestamps
    end
  end
end
