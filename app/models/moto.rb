class Moto < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :modelo, presence: true
  validates :description, presence: true
end
