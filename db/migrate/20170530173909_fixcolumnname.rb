class Fixcolumnname < ActiveRecord::Migration
  def change
    rename_column :users, :avatar, :avatar_filename
  end
end
