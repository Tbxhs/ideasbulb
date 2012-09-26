class Topic < ActiveRecord::Base
  has_many :ideas
  has_attached_file :logo, :styles => { :medium => "120x120#", :small => "50x50#"}

  def status_ideas
    {
      IDEA_STATUS_UNDER_REVIEW => self.ideas.where("status=?",IDEA_STATUS_UNDER_REVIEW).order("ideas.created_at DESC").first,
      IDEA_STATUS_REVIEWED_SUCCESS => self.ideas.where("status=?",IDEA_STATUS_REVIEWED_SUCCESS).order("ideas.created_at DESC").first,
      IDEA_STATUS_LAUNCHED => self.ideas.where("status=?",IDEA_STATUS_LAUNCHED).order("ideas.created_at DESC").first
    }
  end
end
