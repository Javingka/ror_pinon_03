class CustomApp < ActiveRecord::Base
	validates :modelo, presence: true
  belongs_to :user
  mount_uploader :picture, PictureUploader
end
