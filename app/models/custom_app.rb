class CustomApp < ActiveRecord::Base
	validates :modelo, presence: true
  validates :est_per_file, presence: true
  validates :est_lat_file, presence: true
  validates :est_sup_file, presence: true
  validates :apl_per_file, presence: true
  validates :apl_lat_file, presence: true
  validates :apl_sup_file, presence: true
  validates :asi_per_file, presence: true
  validates :asi_lat_file, presence: true
  validates :asi_sup_file, presence: true
  validates :man_per_file, presence: true
  validates :man_lat_file, presence: true
  validates :man_sup_file, presence: true
  validates :lla_per_file, presence: true
  validates :lla_lat_file, presence: true
  validates :lla_sup_file, presence: true
  validates :foc_per_file, presence: true
  validates :foc_lat_file, presence: true
  validates :foc_sup_file, presence: true

  belongs_to :user
  mount_uploader :picture, PictureUploader
end
