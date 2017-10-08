class GadgetSerializer < ActiveModel::Serializer
  attributes :id, :listing_name, :description, :address, :instant,
                  :gadget_type, :has_guarantee, :has_manual, :has_content,
                  :has_no_setup, :has_battery, :require_mobile, :require_account, :price, :active, :image, :unavailable_dates

  def unavailable_dates
    @instance_options[:unavailable_dates]
  end

  def image
    @instance_options[:image]
  end

  class UserSerializer < ActiveModel::Serializer
    attributes :email, :name, :local_image
  end

  belongs_to :user, serializer: UserSerializer, key: :owner
end
