class CreateManagersSites < ActiveRecord::Migration
  def change
    create_table :managers_sites do |t|
      t.integer :user_id
      t.integer :site_id
  
      t.timestamps
    end

    add_index :managers_sites,[:user_id,:site_id],:unique => true
  end
end
