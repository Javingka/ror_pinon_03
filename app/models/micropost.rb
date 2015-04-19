class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc)} #:desc it works on Rails 4.0+
  mount_uploader :picture, PictureUploader # Using carrierwave to upload pictures
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size # this is a custom method to validate image size

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "debe ser menor que 5MB")
      end
    end

end
