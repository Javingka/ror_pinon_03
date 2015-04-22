class Moto < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :modelo, presence: true
  validates :description, presence: true
  validate  :picture_size

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "La imagen debe ser menor que 5MB")
      end
    end

end
