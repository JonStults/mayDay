class RemoveCompleted < ActiveRecord::Migration
  def change
    remove_column :goals, :completed
  end
end
