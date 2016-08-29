require 'rails_helper'

describe WebformsMailer do
  describe 'batch update and delete mail' do
    let(:uni_updates_batch) { FactoryGirl.create(:uni_updates_batch) }
    let(:upload_mail) { WebformsMailer.batch_upload_email(uni_updates_batch, ['123']) }
    let(:delete_mail) { WebformsMailer.batch_delete_email(uni_updates_batch) }

    describe 'to' do
      it 'is the list email address' do
        expect(upload_mail.to).to eq ['sul-unicorn-devs@lists.stanford.edu']
        expect(delete_mail.to).to eq ['sul-unicorn-devs@lists.stanford.edu']
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
        expect(upload_mail.subject).to eq 'batch record update'
        expect(delete_mail.subject).to eq 'batch record deletion'
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
