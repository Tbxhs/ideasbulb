class AddSiteToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas,:site_id,:integer
  end
end
