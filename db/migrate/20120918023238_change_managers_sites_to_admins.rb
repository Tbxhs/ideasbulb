class ChangeManagersSitesToAdmins < ActiveRecord::Migration
  def change
    rename_table :managers_sites,:admins
    rename_index :admins,"index_managers_sites_on_user_id_and_site_id","index_admins_on_user_id_and_site_id"
  end
end
