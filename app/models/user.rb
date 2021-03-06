class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :facebook_id, presence: true
  
  has_many :orders

  class << self
    def check_user data
      unless user = User.where(facebook_id: data["id"]).first
        user = User.create(facebook_id: data["id"], name: data["name"],
          email: "#{data["username"]}@framgia-order.com",
          password: data["id"], facebook_link: data["link"])
      end
      user
    end
  end
end
