require 'spec_helper'

module GoogleDriveToSlack
  RSpec.describe MessageFormatter do
    class DummyFile
      attr_reader :title, :alternate_link, :modified_date, :last_modifying_user_name

      def initialize(title, alternate_link, modified_date, last_modifying_user_name)
        @title = title
        @alternate_link = alternate_link
        @modified_date = modified_date
        @last_modifying_user_name = last_modifying_user_name
      end
    end

    let!(:files) do
      (1..5).map do |i|
        DummyFile.new("File#{i}", "http://example.com/#{i}", Time.new(2016, 1, 24, i * 2, i * 3), "User#{i}")
      end
    end

    describe 'self.format' do
      subject { described_class.format(files) }
      it { should have_key(:fallback) }
      it { should have_key(:title) }
      it { should have_key(:text) }
    end

    describe 'self.attachment_text' do
      context 'given an array of a file' do
        subject { described_class.attachment_text(files[0, 1]) }
        it { should eq '[File1](http://example.com/1) - User1 @ 02:03' }
      end

      context 'given an array of files' do
        subject { described_class.attachment_text(files) }
        it { should eq <<-EOS.strip }
[File1](http://example.com/1) - User1 @ 02:03
[File2](http://example.com/2) - User2 @ 04:06
[File3](http://example.com/3) - User3 @ 06:09
[File4](http://example.com/4) - User4 @ 08:12
[File5](http://example.com/5) - User5 @ 10:15
        EOS
      end
    end

    describe 'self.attachment_title' do
      subject { described_class.attachment_title(files) }
      it { should eq '5 file(s) modified' }
    end

    describe 'self.format_time' do
      it 'format time as HH:MM' do
        expect(described_class.format_time(Time.new(2016, 1, 24, 9, 1))).to eq '09:01'
        expect(described_class.format_time(Time.new(2016, 1, 24, 12, 34))).to eq '12:34'
      end
    end
  end
end
