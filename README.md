GoogleDriveToSlack
====
[![Build Status](https://travis-ci.org/itiut/google_drive_to_slack.svg?branch=master)](https://travis-ci.org/itiut/google_drive_to_slack)

Notify file updates in Google Drive to Slack.  

Usage
----
Run `bin/notify` periodically by cron or something.

```console
$ bundle exec ruby bin/notify
```

Settings
----
Settings can be done through environmental variables.

### Required
- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`
- `GOOGLE_REFRESH_TOKEN`
- `SLACK_WEBHOOK_URL`

### Optional
- `SLACK_USERNAME` (default: `GooglDriveToSlack`)
  - Bot name
- `SLACK_ICON_URL` (default: `https://developers.google.com/drive/images/drive_icon.png`)
  - Bot icon url
- `TIME_WINDOW_MINUTES` (default: `60`)
  - Time window [minutes] within which to search file updates.

Alternatives
----
- [optionfactory/gdrive2slack](https://github.com/optionfactory/gdrive2slack)
