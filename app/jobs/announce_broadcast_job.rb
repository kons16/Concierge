class AnnounceBroadcastJob < ApplicationJob
  queue_as :default

  def perform(announce)
    ActionCable.server.broadcast 'writing_channel', announce: announce, writting_user: "1"
  end
end
