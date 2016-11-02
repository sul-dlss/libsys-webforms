# by convention, we mount at /status
OkComputer.mount_at = 'status' # use /status or /status/all or /status/<name-of-check>

# register some additional checks
# feature-check-name-app is the convention to name checks for the app team
OkComputer::Registry.register 'feature-mailer-app', OkComputer::ActionMailerCheck.new
OkComputer::Registry.register 'feature-symphony-dir-app', OkComputer::DirectoryCheck.new('/symphony')
OkComputer::Registry.register 'version', OkComputer::AppVersionCheck.new
OkComputer::Registry.register 'ruby_version', OkComputer::RubyVersionCheck.new
