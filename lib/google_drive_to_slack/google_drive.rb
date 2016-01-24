require 'google_drive'
require 'google/api_client'

module GoogleDriveToSlack
  class GoogleDrive
    class << self
      def oauth(client_id:, client_secret:, refresh_token:)
        client = OAuth2::Client.new(
          client_id, client_secret,
          site: 'https://accounts.google.com',
          token_url: '/o/oauth2/token',
          authorize_url: '/o/oauth2/auth'
        )
        auth_token = OAuth2::AccessToken.from_hash(client, refresh_token: refresh_token, expires_at: 3600)
        auth_token = auth_token.refresh!
        ::GoogleDrive.login_with_oauth(auth_token.token)
      end
    end

    def initialize(client_id:, client_secret:, refresh_token:)
      @client_id = client_id
      @client_secret = client_secret
      @refresh_token = refresh_token
    end

    def session
      @session ||= self.class.oauth(client_id: @client_id, client_secret: @client_secret, refresh_token: @refresh_token)
    end

    def modified_files(since:)
      query = "modifiedDate >= '#{since.iso8601}' and mimeType != 'application/vnd.google-apps.folder'"
      session.files(q: query)
    end
  end
end
