class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one_attached :profile_photo
validates :password, confirmation: true
validates :email, presence: true, uniqueness: true
validates :experience, length: { maximum: 1000 }, allow_blank: true
attribute :skills, :json, default: []
attribute :previous_clients, :string, array: true, default: []

end
