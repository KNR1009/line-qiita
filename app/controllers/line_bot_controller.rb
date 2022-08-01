# nethttp.rb
require 'uri'
require 'net/http'
class LineBotController < ApplicationController

  def callback
    body = request.body.read
    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message["text"] == "出勤"
            # uri = URI('https://qiita-api.vercel.app/api/trend')
            # res = Net::HTTP.get_response(uri)
            # puts res.body if res.is_a?(Net::HTTPSuccess)
              message = {
                type: "text",
                text: text
              }
              client.reply_message(event['replyToken'], [{type: "text", text: "第一のメッセージ"}, {type: "text", text: '第二のメッセージ'}])
          end
        end
      end
    end
  end

  private
 
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
