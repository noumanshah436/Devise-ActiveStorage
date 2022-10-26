class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  after_commit :add_default_avatar, on: %i[create update]

  has_one_attached :avatar
  validates :avatar, attached: true, content_type:  ['image/jpeg','image/png','image/jpg']

  # custom validation:
  # validate :image_type, on: %i[update]

  def avatar_thumbnail
    avatar.variant( resize:"150x150!").processed
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io:File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.jpg' )  ),
        filename: 'default_profile.jpg',
        content_type: 'image/jpg'
      )
    end
  end

  def image_type
    if !avatar.content_type.in?(%('image/jpeg image/png'))
      errors.add(:avatar, "Must be a JPEG or PNG")
    end
  end
end
