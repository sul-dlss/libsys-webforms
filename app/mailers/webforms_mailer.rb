# app/mailers/webforms_mailer.rb
class WebformsMailer < ApplicationMailer
  def batch_upload_email(uni_updates_batch)
    @uni_updates_batch = uni_updates_batch
    destination = 'sul-unicorn-devs@lists.stanford.edu'
    mail(to: destination, subject: 'batch record update')
  end

  def batch_delete_email(uni_updates_batch)
    @uni_updates_batch = uni_updates_batch
    destination = 'sul-unicorn-devs@lists.stanford.edu'
    mail(to: destination, subject: 'batch record deletion')
  end
end
