class ChangeDefaultForAlcoholCount < ActiveRecord::Migration
  def change
    change_column :alcohols, :count, :integer, :default => 0
  end
end
