class RemoveOwnerFromUsers < ActiveRecord::Migration
  def change
    remove_column :users,:owner
  end
end
