require 'active_support'
require 'active_support/core_ext'

module GoogleDriveToSlack
  class Slack
    USERNAME = 'GoogleDriveToSlack'
    ICON_URL = 'https://developers.google.com/drive/images/drive_icon.png'

    def initialize(webhook_url:, **options)
      @webhook_url = webhook_url
      @options = { username: USERNAME, icon_url: ICON_URL }.merge(options)
    end

    def notifier
      @notifier ||= ::Slack::Notifier.new(@webhook_url, @options.slice(:username))
    end

    def notify(attachment)
      options = { attachments: [attachment] }.merge(@options.slice(:icon_url))
      notifier.ping('', options)
    end
  end
end
