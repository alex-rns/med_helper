class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :events, dependent: :destroy
  has_many :experts, :through => :events
  has_many :children, dependent: :destroy
  has_many :visits, through: :events
  has_one :vaccine, dependent: :destroy
  has_one :expert, dependent: :destroy
  has_one :client, dependent: :destroy
  has_one :card, dependent: :destroy
  has_one_attached :image

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(
          name: data["name"],
          email: data["email"],
          birthday: Time.now.strftime("%d of %B, %Y"),
          password: '12383929'
      )
    end
    user
  end
end
