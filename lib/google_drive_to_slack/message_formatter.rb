require 'slack-notifier'

module GoogleDriveToSlack
  class MessageFormatter
    class << self
      def attachment_text(files)
        files.map do |file|
          "[#{file.title}](#{file.alternate_link}) - #{file.last_modifying_user_name} @ #{format_time(file.modified_date)}"
        end.join("\n")
      end

      def attachment_title(files)
        "#{files.size} file(s) modified"
      end

      def format(files)
        title = attachment_title(files)
        {
          fallback: title,
          title: title,
          text: ::Slack::Notifier::LinkFormatter.format(attachment_text(files))
        }
      end

      def format_time(time)
        time.localtime.strftime('%R')
      end
    end
  end
end
