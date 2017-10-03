class Photo < ApplicationRecord
  belongs_to :gadget
  mount_uploader :image, ImageUploader

end
