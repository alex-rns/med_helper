class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :events, dependent: :destroy
  has_many :experts, :through => :events, dependent: :destroy
  has_one :vaccine, dependent: :destroy
  has_one :expert, dependent: :destroy
  has_one :client, dependent: :destroy

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(
          name: data["name"],
          email: data["email"],
          birthday: Time.now.strftime("%d of %B, %Y"),
          encrypted_password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
