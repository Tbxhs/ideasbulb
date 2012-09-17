class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :domain
      t.references :user
      t.string :status
      t.date :due_date
      t.has_attached_file :icon

      t.timestamps
    end
  end
end
