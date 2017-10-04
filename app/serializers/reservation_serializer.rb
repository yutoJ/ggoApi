class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :price, :status, :start_date, :end_date

  def start_date
    object.start_date.strftime("%Y-%m-%d")
  end

  def end_date
    object.end_date.strftime("%Y-%m-%d")
  end

  class UserSerializer < ActiveModel::Serializer
    attributes :email, :name, :local_image
  end

  belongs_to :user, serializer: UserSerializer, key: :guest
end
