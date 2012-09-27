class RemovePointsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users,:points
  end
end
