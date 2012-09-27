class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea,:counter_cache => true

  validates :content,:presence =>true,:length => {:maximum => 1000}
  validates :idea_id,:presence=>true
  validates :user_id,:presence=>true

  after_create do |comment|
    Resque.enqueue(CommentMessage, comment.id)
  end 

end
