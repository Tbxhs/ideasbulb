class AddApplicantToSite < ActiveRecord::Migration
  def change
    add_column :sites,:applicant_id,:integer
  end
end
