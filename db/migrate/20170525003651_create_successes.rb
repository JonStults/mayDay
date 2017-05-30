class CreateSuccesses < ActiveRecord::Migration
  def change
    create_table :successes do |t|
      t.integer :days, :default => 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
