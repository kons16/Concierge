class MessageBroadcastJob < ApplicationJob
  queue_as :default
  require 'json'
  require 'net/https'
  require "uri"

  def perform(message)
    q = ""
    # 質問生成APIを呼び出す
    if message.context != "image_not_null" then
      @msg = message.context

      if @msg.length >= 10 and @msg[-1] != "?" and @msg[-1] != "か" then
        uri = URI.parse(ENV["CONCIERGE_PYTHON_END_POINT"])
        http = Net::HTTP.new(uri.host, uri.port)
        # http.use_ssl = true
        # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        req = Net::HTTP::Post.new(uri.path)
        req.set_form_data({'message': @msg})
        res = http.request(req)
        result = ActiveSupport::JSON.decode(res.body)
        # puts result["question"]
        q = result["question"]

        Question.create!({chat_context: @msg, q_context: q, user_id: -1,
                          target_id: -1, room_id: -1})
      end
    end

    ActionCable.server.broadcast 'room_channel',
                                 message_right: render_message_right(message),
                                 message_left: render_message_left(message),
                                 question: q,
                                 chat_user: @arguments[0].user_id
  end

  private

  def render_message_right(message)
    ApplicationController.renderer.render partial: 'messages/message_right', locals: {message: message}
  end

  def render_message_left(message)
    ApplicationController.renderer.render partial: 'messages/message_left', locals: {message: message}
  end

  def render_question(question)
    ApplicationController.renderer.render partial: 'questions/question', locals: {question: question}
  end
end
