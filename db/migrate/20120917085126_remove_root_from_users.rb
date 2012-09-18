class RemoveRootFromUsers < ActiveRecord::Migration
  def change
    remove_column :users,:root
  end
end
