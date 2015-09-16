module Slack
  module RealTime
    module Api
      module Reaction_added
        #
        # Sends a message to a channel.
        #
        # @option options [channel] :channel
        #   Channel to send message to. Can be a public channel, private group or IM channel. Can be an encoded ID, or a name.
        # @option options [Object] :text
        #   Text of the message to send. See below for an explanation of formatting.
        def reaction_added(options = {})
          throw ArgumentError.new('Required arguments :channel missing') if options[:channel].nil?
          puts "Reaction added started"
          send_json({ type: 'reaction_added', id: next_id }.merge(options))
        end
      end
    end
  end
end
