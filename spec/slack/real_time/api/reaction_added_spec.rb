require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  include_context 'connected client'

  describe '#reaction_added' do
    before do
      allow(client).to receive(:next_id).and_return(42)
    end
    it 'sends message' do
      expect(socket).to receive(:send_data).with({ type: 'reaction_added', id: 42, channel: 'channel' }.to_json)
      client.reaction_added(channel: 'channel')
    end
  end
end
