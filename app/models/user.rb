class User < ApplicationRecord
  enum role: { admin: 0, employee: 1 }
  has_many :job_offers
  has_many :applications
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
