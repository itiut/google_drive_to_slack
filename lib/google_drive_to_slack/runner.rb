require 'active_support'
require 'active_support/core_ext'
require 'logger'

require 'google_drive_to_slack/google_drive'
require 'google_drive_to_slack/message_formatter'
require 'google_drive_to_slack/slack'

module GoogleDriveToSlack
  class Runner
    class << self
      def run(
        google_client_id:,
        google_client_secret:,
        google_refresh_token:,
        slack_webhook_url:,
        slack_username: '',
        slack_icon_url: '',
        interval_minutes: 60,
        logger_out: STDOUT
      )
        logger = Logger.new(logger_out)

        google_drive = GoogleDrive.new(
          client_id: google_client_id,
          client_secret: google_client_secret,
          refresh_token: google_refresh_token
        )

        files = google_drive.modified_files(since: interval_minutes.minutes.ago)
        logger.debug(files)
        return if files.size <= 0

        slack = Slack.new(
          {
            webhook_url: slack_webhook_url,
            username: slack_username,
            icon_url: slack_icon_url
          }.reject { |_, v| v.empty? }
        )
        res = slack.notify(MessageFormatter.format(files))
        logger.debug(res)
      end
    end
  end
end
