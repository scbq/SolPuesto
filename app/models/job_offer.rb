class JobOffer < ApplicationRecord
  belongs_to :user
  has_many :applications
end
