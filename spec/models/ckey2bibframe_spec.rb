require 'rails_helper'
require 'net/ssh'

# rubocop: disable RSpec/VerifiedDoubles
RSpec.describe Ckey2bibframe, type: :model do
  describe 'SSH to server and retrieve some data' do
    before do
      session = double(Net::SSH::Connection::Session)
      allow(session).to receive(:exec).and_return('marc')
      allow(session).to receive(:close)

      ssh = double(Net::SSH)
      allow(ssh).to receive(:start).and_return(session)
    end

    it 'checks if the ckey ids invalid' do
      f = described_class.new(ckey: 'wmd', baseuri: 'http://example.com').valid?
      expect(f).to be_falsey
    end

    it 'checks if a ckey is valid' do
      t = described_class.new(ckey: '123', baseuri: 'http://example.com').valid?
      expect(t).to be_truthy
    end

    it 'does a convert' do
      c = described_class.new(ckey: '123', baseuri: 'http://example.com')
      expect(c.convert).to include('ssh',
                                   'echo 123',
                                   'xform-marc21-to-xml-jar-with-dependencies.jar',
                                   'edu.stanford.MarcToXMLStream')
    end

    it 'converts marc21 to xml' do
      c = double(described_class.new(ckey: '123', baseuri: 'http://example.com'))
      allow(c).to receive(:marc21_to_xml).and_return('some_marcxml')
      expect(c.marc21_to_xml).to eq('some_marcxml')
    end

    it 'converts marcxml to bibframe' do
      c = double(described_class.new(ckey: '123', baseuri: 'http://example.com'))
      allow(c).to receive(:marcxml_to_bibframe).and_return('some_bibframe')
      expect(c.marcxml_to_bibframe).to eq('some_bibframe')
    end
  end
end
# rubocop: enable RSpec/VerifiedDoubles
