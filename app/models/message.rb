class Message < ApplicationRecord
  belongs_to :user, optional: true
  after_create_commit { MessageBroadcastJob.perform_later self }

  mount_uploader :image, ChatImageUploader
end
