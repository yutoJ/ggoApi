class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  has_many :gadgets
  has_many :reservations
  has_many :guest_reviews, class_name: "GuestReview", foreign_key: "guest_id"
  has_many :owner_reviews, class_name: "OwnerReview", foreign_key: "owner_id"
  mount_uploader :local_image, LocalImageUploader

   def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
     user = User.find_by(email: auth.info.email)

     unless user
       user = User.new(
       name:     auth.extra.raw_info.name,
       provider: auth.provider,
       uid:      auth.uid,
       email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
       sns_image:   auth.info.image,
       password: Devise.friendly_token[0, 20]
       )
       user.skip_confirmation!
       user.save(validate: false)
     end
     user
   end

   def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
     user = User.find_by(provider: auth.provider, uid: auth.uid)

     unless user
       user = User.new(
       name:     auth.info.nickname,
       sns_image: auth.info.image,
       provider: auth.provider,
       uid:      auth.uid,
       email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
       password: Devise.friendly_token[0, 20]
       )
       user.skip_confirmation!
       user.save
     end
     user
   end
end
