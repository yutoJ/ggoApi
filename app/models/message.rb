class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  has_many :notifications, dependent: :destroy

  validates_presence_of :body, :conversation_id, :user_id
end
