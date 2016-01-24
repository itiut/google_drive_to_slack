require 'spec_helper'

module GoogleDriveToSlack
  RSpec.describe GoogleDrive do
    let(:google_drive) do
      described_class.new(
        client_id: ENV['GOOGLE_CLIENT_ID'],
        client_secret: ENV['GOOGLE_CLIENT_SECRET'],
        refresh_token: ENV['GOOGLE_REFRESH_TOKEN']
      )
    end

    describe '#session' do
      it 'returns a valid session' do
        expect(google_drive.session).to be_truthy
      end
    end

    describe '#modified_files' do
      it 'throws a query to session' do
        dummy_session = double('::GoogleDrive::Session')
        expect(dummy_session).to receive(:files)
          .with(q: "modifiedDate >= '2016-01-24T13:18:05+09:00' and mimeType != 'application/vnd.google-apps.folder'")
          .and_return([])

        allow(google_drive).to receive(:session).and_return(dummy_session)

        google_drive.modified_files(since: Time.new(2016, 1, 24, 13, 18, 5, '+09:00'))
      end
    end
  end
end
