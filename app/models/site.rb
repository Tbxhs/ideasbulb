class Site < ActiveRecord::Base
  belongs_to :user
  has_many :site_admins,:through => :admins,:source =>:user
  has_many :admins
  has_many :topics
  has_many :ideas

  has_attached_file :icon, :styles => { :medium => "120x120#", :small => "50x50#"}
end
