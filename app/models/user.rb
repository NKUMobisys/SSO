class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable
  validates_uniqueness_of :account

  # http://stackoverflow.com/questions/11678508/email-cant-be-blank-devise-using-username-or-email
  # https://github.com/plataformatec/devise/blob/master/lib/devise/models/validatable.rb#L29
  # def email_required?
  #   false
  # end

  def first_login?
    self.sign_in_count==1 && 10.seconds.ago < current_sign_in_at
  end
end
