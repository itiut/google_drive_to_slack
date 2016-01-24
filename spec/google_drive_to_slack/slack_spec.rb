require 'spec_helper'

module GoogleDriveToSlack
  RSpec.describe Slack do
    let(:slack) do
      described_class.new(
        webhook_url: 'http://example.com',
        username: 'GoogleDriveToSlack',
        icon_url: 'http://example.com/example.png'
      )
    end

    describe '#notifier' do
      it 'returns a valid notifier' do
        expect(slack.notifier).to be_truthy
        expect(slack.notifier.endpoint.to_s).to eq 'http://example.com'
        expect(slack.notifier.username).to eq 'GoogleDriveToSlack'
      end
    end

    describe '#notify' do
      it 'sends message to notifier' do
        dummy_notifier = double('::Slack::Notifier')
        expect(dummy_notifier).to receive(:ping)
          .with(
            '',
            attachments:
              [
                {
                  fallback: 'fallback',
                  title: 'title',
                  text: 'text'
                }
              ],
            icon_url: 'http://example.com/example.png'
          )

        allow(slack).to receive(:notifier).and_return(dummy_notifier)

        slack.notify(fallback: 'fallback', title: 'title', text: 'text')
      end
    end
  end
end
