class Admin < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
  validates :site_id,:presence=>true
  validates :user_id,:presence=>true
end
