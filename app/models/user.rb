class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :login,:username,:email, :password, :password_confirmation, :remember_me,:terms_of_service,:description,:website,:avatar
  attr_accessor :login,:password_confirmation

  has_many :ideas
  has_many :voted_solutions,:through => :votes,:source =>:solution
  has_many :votes
  has_many :liked_votes,:class_name => "Vote",:conditions => {:like => true}
  has_many :unliked_votes,:class_name => "Vote",:conditions => {:like => false}
  has_many :favored_ideas,:through => :favors,:source =>:idea
  has_many :favors
  has_many :commented_ideas,:through => :comments,:source =>:idea
  has_many :comments
  has_many :solutions
  has_many :messages
  has_attached_file :avatar, :styles => { :medium => "120x120#", :small => "50x50#", :thumb => "32x32#" },:url => "/system/:attachment/:id/:style/:filename",:whiny => false

  self.per_page = 10

  validates :username,:uniqueness => true,:if => :username_changed? 
  validates :username,:length => {:minimum => 3,:maximum => 14},:format => {:with => /\A[a-zA-Z0-9]+\z/,:message => I18n.t('app.error.user.username_format')}
  validates :description,:length => {:maximum => 40}
  validates_format_of :website, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix,:allow_blank => true
  validates :avatar,:attachment_content_type => {:content_type=>["image/jpeg","image/png"],:message => I18n.t('app.error.user.avatar_content_type')},:attachment_size => { :less_than => 50.kilobytes,:message => I18n.t('app.error.user.avatar_size') }

  before_update do |user|
    user.website = nil if user.website && user.website.strip.empty?
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
  end

  def self.update_points(user_id,points)
    connection.update("UPDATE `users` set `points` = `points` + #{points} WHERE `id` = #{user_id}")
  end
end
