class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :site_name,:null => false
      t.string :site_domain,:null => false
      t.string :org_name
      t.string :org_website
      t.string :org_intro
      t.string :status
      t.string :message
      t.references :user

      t.timestamps
    end
  end
end
