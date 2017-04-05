class User < ApplicationRecord
  paginates_per 10

  has_many :companies
  has_many :subscribes
  has_many :visits

  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def name_display
    self.name || self.email
  end

  def role
    self.admin? ? "Administrador" : "Usuário"
  end

  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      return_user = self.where(email: auth.info.email).first
      return_user.provider = auth.provider
      return_user.uid = auth.uid
      return_user.name = auth.info.name if return_user.name.blank?
      return_user.image = auth.info.image if return_user.image.blank?
      return_user.save
    else
      return_user = self.create do |user|
         user.provider = auth.provider
         user.uid = auth.uid
         user.name = auth.info.name
         user.image = auth.info.image
         user.email = auth.info.email
        #  user.oauth_token = auth.credentials.token
        #  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      end
    end

    return_user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
