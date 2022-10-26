class Post < ApplicationRecord
  has_many_attached :images
  validates :title , presence: true
  validates :body , presence: true
  validate :image_type

  def thumbnail(index)
    return self.images[index].variant(resize: '300x300!').processed
  end

  private

  def image_type
    if images.attached? == false
      errors.add(:images, "are missing!")
    end

    images.each do |image|
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:images, "needs to be JPEG or PNG")
      end
    end
  end


end
