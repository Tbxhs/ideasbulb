class AddSiteToTags < ActiveRecord::Migration
  def change
    add_column :tags,:site_id,:integer
  end
end
