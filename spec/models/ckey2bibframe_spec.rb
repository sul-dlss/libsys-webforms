require 'rails_helper'
require 'net/ssh'

RSpec.describe Ckey2bibframe, type: :model do
  describe 'SSH to server and retrieve some data' do
    before(:each) do
      session = double(Net::SSH::Connection::Session)
      allow(session).to receive(:exec).and_return('marc')
      allow(session).to receive(:close)

      ssh = double(Net::SSH)
      allow(ssh).to receive(:start).and_return(session)
    end

    it 'should check for a ckey' do
      f = Ckey2bibframe.new(ckey: 'wmd', baseuri: 'http://example.com').valid?
      expect(f).to be_falsey
      t = Ckey2bibframe.new(ckey: '123', baseuri: 'http://example.com').valid?
      expect(t).to be_truthy
    end

    it 'should do a convert' do
      c = Ckey2bibframe.new(ckey: '123', baseuri: 'http://example.com')
      expect(c.convert).to include('ssh',
                                   'echo 123',
                                   'xform-marc21-to-xml-jar-with-dependencies.jar',
                                   'edu.stanford.MarcToXMLStream')
    end

    it 'should convert marc21 to xml' do
      c = double(Ckey2bibframe.new(ckey: '123', baseuri: 'http://example.com'))
      allow(c).to receive(:marc21_to_xml).and_return('some_marcxml')
      expect(c.marc21_to_xml).to eq('some_marcxml')
    end

    it 'should convert marcxml to bibframe' do
      c = double(Ckey2bibframe.new(ckey: '123', baseuri: 'http://example.com'))
      allow(c).to receive(:marcxml_to_bibframe).and_return('some_bibframe')
      expect(c.marcxml_to_bibframe).to eq('some_bibframe')
    end
  end
end
