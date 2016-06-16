###
#  Application-wide mailer class to let us set some defaults
###
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@libsys-webforms.stanford.edu'
end
