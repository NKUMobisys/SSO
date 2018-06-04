class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable
  validates_uniqueness_of :account
  validates :account, exclusion: ReservedName.list

  # https://github.com/plataformatec/devise/wiki/How-To:-Add-an-Admin-Role
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  # http://stackoverflow.com/questions/11678508/email-cant-be-blank-devise-using-username-or-email
  # https://github.com/plataformatec/devise/blob/master/lib/devise/models/validatable.rb#L29
  # def email_required?
  #   false
  # end

  def first_login?
    self.sign_in_count==1 && 10.seconds.ago < current_sign_in_at
  end

  def study_state
    StudyState.find_by(id: self.study_state_id)
  end

  def set_default_role
    self.role ||= :user
  end
end
