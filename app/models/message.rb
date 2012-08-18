class Message < ActiveRecord::Base
  belongs_to :user
  validates :user_id,:presence=>true
  self.per_page = 30
end
