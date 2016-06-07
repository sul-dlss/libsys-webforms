require 'rails_helper'

describe WebformsMailer do
  describe 'batch update' do
    let(:uni_updates_batch) { FactoryGirl.create(:uni_updates_batch) }
    let(:mail) { WebformsMailer.batch_upload_email(uni_updates_batch) }

    describe 'to' do
      it 'is the list email address' do
        expect(mail.to).to eq ['sul-unicorn-devs@lists.stanford.edu']
      end
    end

    describe 'from' do
      it 'is the default from address' do
        expect(mail.from).to eq ['no-reply@libsys-webforms.stanford.edu']
      end
    end

    describe 'subject' do
      it 'is about a batch upload' do
        expect(mail.subject).to eq 'batch record update'
      end
    end

    describe 'body' do
      let(:body) { mail.body.to_s }
      it 'has the id of the batch updated' do
        expect(body).to match(/Batch id: 1/)
      end
    end
  end
end
