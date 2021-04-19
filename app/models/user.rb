class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :experts, :through => :events, dependent: :destroy
  has_many :children, dependent: :destroy
  has_many :visits, through: :events
  has_one :vaccine, dependent: :destroy
  has_one :expert, dependent: :destroy
  has_one :card, dependent: :destroy
  enum role: [ :patient, :doctor ]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(
      name: access_token.info.name,
      email: data["email"],
      image: access_token.info.image,
      password: "28ddds83")
      binding.pry
    end
    user
  end
end
