# This file was auto-generated by lib/slack/web/api/tasks/generate.rake

module Slack
  module Web
    module Api
      module Endpoints
        module Rtm
          #
          # This method starts a Real Time Messaging API session. Refer to the
          # RTM API documentation for full details on how to use the RTM API.
          #
          # @option options [Object] :simple_latest
          #   Return timestamp only for latest message object of each channel (improves performance).
          # @option options [Object] :no_unreads
          #   Skip unread counts for each channel (improves performance).
          # @see https://api.slack.com/methods/rtm.start
          # @see https://github.com/dblock/slack-api-ref/blob/master/methods/rtm.start.json
          def rtm_start(options = {})
            post('rtm.start', options)
          end
        end
      end
    end
  end
end
