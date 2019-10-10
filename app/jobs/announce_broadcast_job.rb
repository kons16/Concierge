class AnnounceBroadcastJob < ApplicationJob
  queue_as :default

  def perform(announce)
    ActionCable.server.broadcast 'writing_channel', announce: announce
  end
end
