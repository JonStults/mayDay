class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
