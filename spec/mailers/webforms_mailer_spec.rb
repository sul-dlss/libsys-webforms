require 'rails_helper'

describe WebformsMailer do
  describe 'batch update and delete mail' do
    let(:uni_updates_batch) { create(:uni_updates_batch) }
    let(:sal3_batch_requests_batch) { create(:sal3_batch_requests_batch) }
    let(:uni_updates_batch_w_no_user) { create(:uni_updates_batch, user_email: '') }
    let(:sal3_batch_requests_batch_w_no_user) { create(:sal3_batch_requests_batch, user_email: '') }
    let(:uni_updates_batch_w_emails) do
      build(:uni_updates_batch, user_email: 'libraryuser@stanford.edu,
                                                        otheruser@stanford.edu
                                                        anotheruser@stanford.edu;
                                                        lastuser@stanford.edu')
    end
    let(:sal3_batch_requests_batch_w_emails) do
      build(:sal3_batch_requests_batch, user_email: 'libraryuser@stanford.edu,
                                                                sal3contact@stanford.edu,
                                                                otheruser@stanford.edu
                                                                anotheruser@stanford.edu;
                                                                lastuser@stanford.edu')
    end

    let(:upload_mail) { described_class.batch_upload_email(uni_updates_batch, ['123']) }
    let(:sal3_mail) { described_class.sal3_batch_email(sal3_batch_requests_batch) }
    let(:upload_mail_no_user) { described_class.batch_upload_email(uni_updates_batch_w_no_user, ['123']) }
    let(:sal3_mail_no_user) { described_class.sal3_batch_email(sal3_batch_requests_batch_w_no_user) }
    let(:delete_mail) { described_class.batch_delete_email(uni_updates_batch) }
    let(:delete_mail_no_user) { described_class.batch_delete_email(uni_updates_batch_w_no_user) }
    let(:upload_mail_w_emails) { described_class.batch_upload_email(uni_updates_batch_w_emails, ['123']) }
    let(:delete_mail_w_emails) { described_class.batch_delete_email(uni_updates_batch_w_emails) }

    describe 'to' do
      it 'is the list email address and email_user' do
        expect(upload_mail.to)
          .to eq %w(sul-unicorn-devs@lists.stanford.edu libraryuser@stanford.edu otheruser@stanford.edu)
      end

      it 'is the list email address and email_user for deletes' do
        expect(delete_mail.to)
          .to eq %w(sul-unicorn-devs@lists.stanford.edu libraryuser@stanford.edu otheruser@stanford.edu)
      end

      it 'is the list email address and email_users for sal3' do
        expect(sal3_mail.to)
          .to eq %w(sul-unicorn-devs@lists.stanford.edu sal3contact@stanford.edu
                    libraryuser@stanford.edu otheruser@stanford.edu)
      end

      it 'replaces spaces, commas, and semicolons for upload mail' do
        expect(upload_mail_w_emails.to).to eq %w(sul-unicorn-devs@lists.stanford.edu libraryuser@stanford.edu
                                                 otheruser@stanford.edu anotheruser@stanford.edu lastuser@stanford.edu)
      end

      it 'replaces spaces, commas, and semicolons fr delete mail' do
        expect(delete_mail_w_emails.to).to eq %w(sul-unicorn-devs@lists.stanford.edu libraryuser@stanford.edu
                                                 otheruser@stanford.edu anotheruser@stanford.edu lastuser@stanford.edu)
      end

      it 'upload mail is just the email address when no email_user is specified' do
        expect(upload_mail_no_user.to).to eq ['sul-unicorn-devs@lists.stanford.edu']
      end

      it 'sal3 mail is just the email address when no email_user is specified' do
        expect(sal3_mail_no_user.to).to eq %w(sul-unicorn-devs@lists.stanford.edu sal3contact@stanford.edu)
      end

      it 'delete is just the email address when no email_user is specified' do
        expect(delete_mail_no_user.to).to eq ['sul-unicorn-devs@lists.stanford.edu']
      end
    end

    describe 'from' do
      it 'is the default from address for upload mail' do
        expect(upload_mail.from).to eq ['no-reply@libsys-webforms.stanford.edu']
      end

      it 'is the default from address for delete mail' do
        expect(delete_mail.from).to eq ['no-reply@libsys-webforms.stanford.edu']
      end

      it 'is the default from address for sal3 mail' do
        expect(sal3_mail.from).to eq ['no-reply@libsys-webforms.stanford.edu']
      end
    end

    describe 'subject' do
      it 'is about a batch upload or deletion for upload mail' do
        expect(upload_mail.subject).to eq 'Batch update request'
      end

      it 'is about a batch upload or deletion for delete mail' do
        expect(delete_mail.subject).to eq 'Batch update deletion'
      end

      it 'is about a batch upload or deletion for sal3 mail' do
        expect(sal3_mail.subject).to eq 'SAL3 pull request'
      end
    end

    describe 'body' do
      let(:upload_body) { upload_mail.body.to_s }
      let(:delete_body) { delete_mail.body.to_s }
      let(:sal3_body) { sal3_mail.body.to_s }

      it 'has the id of the batch updated for upload mail' do
        expect(upload_body).to match(/Batch id: 1/)
      end

      it 'has the id of the batch updated for delete mail' do
        expect(delete_body).to match(/Batch id: 1/)
      end

      it 'has the name of the sal3 batch' do
        expect(sal3_body).to match(/Batch name: Batch name/)
      end

      it 'has the id of the sal3 batch' do
        expect(sal3_body).to match(/Batch id: 1/)
      end

      it 'has the name of the sal3 batch requestor' do
        expect(sal3_body).to match(/Requestor name: Test User/)
      end
    end
  end
end
