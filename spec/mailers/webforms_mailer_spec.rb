require 'rails_helper'

describe WebformsMailer do
  describe 'batch update and delete mail' do
    let(:uni_updates_batch) { FactoryGirl.create(:uni_updates_batch) }
    let(:uni_updates_batch_w_no_user) { FactoryGirl.create(:uni_updates_batch, user_email: '') }
    let(:upload_mail) { WebformsMailer.batch_upload_email(uni_updates_batch, ['123']) }
    let(:upload_mail_no_user) { WebformsMailer.batch_upload_email(uni_updates_batch_w_no_user, ['123']) }
    let(:delete_mail) { WebformsMailer.batch_delete_email(uni_updates_batch) }
    let(:delete_mail_no_user) { WebformsMailer.batch_delete_email(uni_updates_batch_w_no_user) }

    describe 'to' do
      it 'is the list email address and email_user' do
        expect(upload_mail.to).to eq ['sul-unicorn-devs@lists.stanford.edu', 'libraryuser@stanford.edu']
        expect(delete_mail.to).to eq ['sul-unicorn-devs@lists.stanford.edu', 'libraryuser@stanford.edu']
      end

      it 'is just the email address when no email_user is specified' do
        expect(upload_mail_no_user.to).to eq ['sul-unicorn-devs@lists.stanford.edu']
        expect(delete_mail_no_user.to).to eq ['sul-unicorn-devs@lists.stanford.edu']
      end
    end

    describe 'from' do
      it 'is the default from address' do
        expect(upload_mail.from).to eq ['no-reply@libsys-webforms.stanford.edu']
        expect(delete_mail.from).to eq ['no-reply@libsys-webforms.stanford.edu']
      end
    end

    describe 'subject' do
      it 'is about a batch upload or deletion' do
        expect(upload_mail.subject).to eq 'Batch update request'
        expect(delete_mail.subject).to eq 'Batch update deletion'
      end
    end

    describe 'body' do
      let(:upload_body) { upload_mail.body.to_s }
      let(:delete_body) { delete_mail.body.to_s }
      it 'has the id of the batch updated' do
        expect(upload_body).to match(/Batch id: 1/)
        expect(delete_body).to match(/Batch id: 1/)
      end
    end
  end
end
