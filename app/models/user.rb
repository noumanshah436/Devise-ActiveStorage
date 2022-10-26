class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  after_commit :add_default_avatar, on: %i[create update]

  has_one_attached :avatar

  def avatar_thumbnail
    avatar.variant( resize:"150x150!").processed
    
    # if avatar.attached?
    # avatar.variant( resize:"150x150!").processed
    # else
    #   "/default_profile.jpg"
    # end
  end

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io:File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.jpg' )  ),
        filename: 'default_profile.jpg',
        content_type: 'image/jpg'
      )
    end
  end




end
